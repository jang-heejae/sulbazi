package com.sulbazi.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
	@Autowired CategoryDAO category_dao;

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
}
