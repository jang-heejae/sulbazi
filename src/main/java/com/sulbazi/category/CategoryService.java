package com.sulbazi.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
	
	@Autowired CategoryDAO category_dao;

	Logger logger = LoggerFactory.getLogger(getClass());
	
	public Map<String, Object> categoryList() {
		List<CategoryOptDTO> list = category_dao.categoryList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	 public String categoryAdd(Map<String, String> param) {
		 String msg = "";
		 if(category_dao.categoryAdd(param) > 0)
			 msg = "성공"; 
		 return msg;
	  }
	public boolean categoryState(String category, String state) {
		return category_dao.categoryState(category, state) > 0;
	}

	
	//매장 리스트 필터링 
	public List<Integer> storefiltering(Map<String, String> params) {
		logger.info("매장 필터링 서비스");
		logger.info(""+params);
		int idx_1= Integer.parseInt(params.get("alchol")) ;
		int idx_2=Integer.parseInt(params.get("food"));
		int idx_3=Integer.parseInt(params.get("mood"));
		int idx_4=Integer.parseInt(params.get("visit"));
		logger.info(""+idx_1);
		List<Integer> filteringstoreidx= category_dao.storefiltering(idx_1,idx_2,idx_3,idx_4);
		logger.info(""+filteringstoreidx);
		return filteringstoreidx;
	}
	
	public List<CategoryOptDTO> joincategory() {
		return category_dao.joincategory();
	}
	public void userJoindo(String user_id, int category1, int category2, int category3, int category4) {
		logger.info("넘어온 user_id : " + user_id  + ", c1 : " + category1 + ", c2 : " + category2 + ", c3: " + category3 + ", c4: " + category4);
		UserCategoryDTO usercategorydto = new UserCategoryDTO();
		usercategorydto.setUser_id(user_id);
		usercategorydto.setOpt_idx(category1);
	    category_dao.userJoindo(usercategorydto);
	    usercategorydto.setOpt_idx(category2);
	    category_dao.userJoindo(usercategorydto);
	    usercategorydto.setOpt_idx(category3);
	    category_dao.userJoindo(usercategorydto);
	    usercategorydto.setOpt_idx(category4);
	    category_dao.userJoindo(usercategorydto);
	}
	public void storejoin(int store_idx, int category1, int category2, int category3, int category4) {
		logger.info("넘어온 store_idx : " + store_idx   + ", c1 : " + category1 + ", c2 : " + category2 + ", c3: " + category3 + ", c4: " + category4);
		StoreCategoryDTO storecategorydto = new StoreCategoryDTO();
		storecategorydto.setStore_idx(store_idx);
		storecategorydto.setOpt_idx(category1);
		category_dao.storejoin(storecategorydto);
		storecategorydto.setOpt_idx(category2);
		category_dao.storejoin(storecategorydto);
		storecategorydto.setOpt_idx(category3);
		category_dao.storejoin(storecategorydto);
		storecategorydto.setOpt_idx(category4);
		category_dao.storejoin(storecategorydto);
	}
}

