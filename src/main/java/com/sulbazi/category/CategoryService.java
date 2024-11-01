package com.sulbazi.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sulbazi.member.StoreDAO;
import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreService;
import com.sulbazi.photo.PhotoDTO;

@Service
public class CategoryService {
	
	@Autowired CategoryDAO category_dao;
	@Autowired StoreDAO store_dao;

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
	public Map<String,Object> storefiltering(Map<String, String> params) {
		logger.info("매장 필터링 서비스");
		logger.info(""+params);
		int idx_1= Integer.parseInt(params.get("alchol")) ;
		int idx_2=Integer.parseInt(params.get("food"));
		int idx_3=Integer.parseInt(params.get("mood"));
		int idx_4=Integer.parseInt(params.get("visit"));
		
		int cnt = Integer.parseInt(params.get("cnt")); 
		int page = Integer.parseInt(params.get("page")); 
		
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		
		logger.info(""+idx_1);
		//매장 별점 리뷰 idx 순 offset limt 한거 5개씪
		List<StoreDTO> filteringstoreidx= category_dao.storefiltering(idx_1,idx_2,idx_3,idx_4,offset,limit);
		//토탈 페이지 가져온거
		int totalPages = category_dao.getTotalPages(idx_1,idx_2,idx_3,idx_4);
		int totalStores = (int) Math.ceil((double) totalPages / cnt); 
		
		
		List<PhotoDTO> photoList = store_dao.findPhotosForStores(filteringstoreidx);
		List<CategoryOptDTO> categoryOpts = store_dao.findStoreCategorys(filteringstoreidx);
		List<StoreCategoryDTO> storeCategorys = store_dao.storeHelpMeIdx(filteringstoreidx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("storeList", filteringstoreidx);
		map.put("totalPages", totalStores);
		map.put("photos", photoList);
		map.put("categoryOpts", categoryOpts);
		map.put("storeCategorys", storeCategorys);
		
		return map;
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
	

	@Transactional
	public void mystoreoptupdate(Map<String, String> params, int idx) {
		category_dao.deletemystoreopt(idx);
		int alchol = Integer.parseInt(params.get("alchol"));
		int food = Integer.parseInt(params.get("food"));
		int mood = Integer.parseInt(params.get("mood"));
		int visit = Integer.parseInt(params.get("visit"));
		category_dao.updatemystoreopt(alchol, idx);
		category_dao.updatemystoreopt(food, idx);
		category_dao.updatemystoreopt(mood, idx);
		category_dao.updatemystoreopt(visit, idx);
	}


	public void userUpdate(Map<String, String> param, String user_id) {
	    logger.info("cateup param:" + param);
	    logger.info("cateup user_id:" + user_id);

	    try {
	        // 각 opt_name에 대한 처리
	        String[] optNames = {"opt_name1", "opt_name2", "opt_name3", "opt_name4"};
	        for (int i = 0; i < optNames.length; i++) {
	            String opt_name_value = param.get(optNames[i]);
	            if (opt_name_value != null && !opt_name_value.isEmpty()) {
	                int opt_idx = category_dao.updateOpt(opt_name_value);
	                if (opt_idx != 0) {
	                    // 기존 항목이 있는지 확인
	                    boolean exists = category_dao.userUpdate(user_id, opt_idx);
	                    if (exists) {
	                        // 기존 항목이 있으면 업데이트
	                        category_dao.userUpdateCate(user_id, opt_idx);
	                        logger.info("Updated user_id: " + user_id + ", opt_idx: " + opt_idx + ", opt_name: " + opt_name_value);
	                    } else {
	                        // 기존 항목이 없으면 삽입
	                        category_dao.userInsertCate(user_id, opt_idx);
	                        logger.info("Inserted user_id: " + user_id + ", opt_idx: " + opt_idx + ", opt_name: " + opt_name_value);
	                    }
	                } else {
	                    logger.error("옵션 이름으로부터 opt_idx를 찾지 못했습니다: opt_name=" + opt_name_value);
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	public int insertOption(int purposeValue, int moodValue, int idx) {
		return category_dao.insertOption(purposeValue,moodValue,idx);
	}
}

