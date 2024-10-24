package com.sulbazi.member;


import java.util.List;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.photo.PhotoDTO;


@Service
public class StoreService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired StoreDAO store_dao;
	
	public StoreDTO getStoreDetail(int idx) {
		StoreDTO sd = store_dao.getStoreDetail(idx);
		
		return sd;
	}


	public List<PhotoDTO> fileList(int idx) {
		return store_dao.fileList(idx);
	}


	public List<StoreMenuDTO> getStoreMenuById(int idx) {
		return store_dao.getStoreMenuById(idx);
	}



	
	public Map<String, Object> storenamesearch(String keyword, Model model) {
		logger.info("매장이름키워드서비스");
		logger.info(keyword);
		List<Integer> namesearch = store_dao.storenamesearch(keyword);
		logger.info("필터링된 매장 idx" + namesearch);
		
		List<StoreDTO> filteringstorelist ; 
		Map<String, Object> map = new HashMap<String, Object>();
		 List<StoreDTO> accumulatedFilteringStoreList = new ArrayList<>();
		 
		 for (Integer storeidx : namesearch) { 
			 logger.info("하나하나 분리: {}", storeidx); 
			 filteringstorelist =store_dao.storesearch(storeidx);
			 logger.info("list: {}", filteringstorelist); 
			 
			 accumulatedFilteringStoreList.addAll(filteringstorelist);
			 
			 model.addAttribute("filteringstorelist", accumulatedFilteringStoreList);
			 map.put("searchresult", accumulatedFilteringStoreList);
		 }		 
		 return map;
	}

	public Map<String, Object> storemenusearch(String keyword, Model model) {
		logger.info("매장메뉴키워드서비스");
		logger.info(keyword);
		List<Integer> menusearch = store_dao.storemenusearch(keyword);
		logger.info("필터링된 매장 idx" + menusearch);
		
		List<StoreDTO> filteringstorelist ; 
		Map<String, Object> map = new HashMap<String, Object>();
		List<StoreDTO> accumulatedFilteringStoreList = new ArrayList<>();
		 
		 for (Integer storeidx : menusearch) { 
			 logger.info("하나하나 분리: {}", storeidx); 
			 filteringstorelist =store_dao.storesearch(storeidx);
			 logger.info("list: {}", filteringstorelist); 
			 
			 accumulatedFilteringStoreList.addAll(filteringstorelist);
			 
			 model.addAttribute("filteringstorelist", accumulatedFilteringStoreList);
			 map.put("searchresult", accumulatedFilteringStoreList);
		 }		 
		 return map;
	}

	public Map<String, Object> storeaddrsearch(String keyword, Model model) {
		logger.info("매장메뉴키워드서비스");
		logger.info(keyword);
		List<Integer> addrsearch = store_dao.storeaddrsearch(keyword);
		logger.info("필터링된 매장 idx" + addrsearch);
		
		List<StoreDTO> filteringstorelist ; 
		Map<String, Object> map = new HashMap<String, Object>();
		List<StoreDTO> accumulatedFilteringStoreList = new ArrayList<>();
		 
		 for (Integer storeidx : addrsearch) { 
			 logger.info("하나하나 분리: {}", storeidx); 
			 filteringstorelist =store_dao.storesearch(storeidx);
			 logger.info("list: {}", filteringstorelist); 
			 
			 accumulatedFilteringStoreList.addAll(filteringstorelist);
			 
			 model.addAttribute("filteringstorelist", accumulatedFilteringStoreList);
			 map.put("searchresult", accumulatedFilteringStoreList);
		 }		 
		 return map;
	}
}
