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

import com.sulbazi.board.BoardDTO;
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


	public PhotoDTO getStorePhoto(int idx) {
		return store_dao.getStorePhoto(idx);
	}


	public BoardDTO getBoard(int idx) {
		return store_dao.getBoard(idx);
	}


	public List<PhotoDTO> alcoholFileList(int idx) {
		return store_dao.alcoholFileList(idx);
	}


	public List<StoreMenuDTO> getStoreAlcohol(int idx) {
		return store_dao.getStoreAlcohol(idx);
	}

	public Map<String, Object> bookmarkCheck(String loginId, int storeidx) {
		int store_idx = storeidx;
		String user_id= loginId;
		Map<String, Object> map = new HashMap<String, Object>();
		if (store_dao.bookmarkCheckCount(user_id,store_idx) == 0) {
			map.put("bookmark",store_dao.bookmarkCheck(user_id,store_idx));
		}else {
			int del = store_dao.delBookmark(user_id,store_idx);
		}
		
		int bookmark_user = store_dao.storeBookmarkCheck(store_idx);
		if ( bookmark_user >= 0) {
			store_dao.updateStoreFavoriteCount(store_idx,bookmark_user);
		}
		
		return map;
	}


	public List<PhotoDTO> getStorePhotos(int idx) {
		return store_dao.getStorePhotos(idx);
	}



}
