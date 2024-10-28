package com.sulbazi.member;


import java.util.List;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.category.CategoryDTO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;


@Service
public class StoreService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired StoreDAO store_dao;
	
	public StoreDTO getStoreDetail(int idx) {
		StoreDTO sd = store_dao.getStoreDetail(idx);
		System.out.println(sd.getStore_idx());
		String storeTime = sd.getStore_time().replace("\n", "<br>");
		sd.setStore_time(storeTime);
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
		System.out.println(store_idx);
		System.out.println(user_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("store_idx", store_idx);
		int s = store_dao.bookmarkCheckCount(map);
		System.out.println(s);
		if ( s == 0) {
			
			map.put("bookmark",store_dao.bookmarkCheck(map));
			
			
		}else {
			int del = store_dao.delBookmark(map);
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

	
	public List<CategoryOptDTO> getStoreExplain(int idx) {
		List<Integer> storeOptidxs = store_dao.stCategory(idx);
		System.out.println(storeOptidxs);
		List<CategoryOptDTO> storeExplain = new ArrayList<>();
		for (Integer integer : storeOptidxs) {
			CategoryOptDTO stwe = store_dao.storeByCategoryopt(integer);
			storeExplain.add(stwe);
		}

		return storeExplain;
	}


	public List<StoreDTO> getStoresInArea(double minLat, double maxLat, double minLng, double maxLng, int page,
			int cnt) {
		
        Map<String, Object> params = new HashMap<>();
        params.put("minLat", minLat);
        params.put("maxLat", maxLat);
        params.put("minLng", minLng);
        params.put("maxLng", maxLng);
        params.put("offset", (page - 1) * cnt);
        params.put("limit", cnt);
        List<StoreDTO> storeList = store_dao.findStoresInArea(params);
        
        
        return storeList;
	}


	public int getTotalPages(double minLat, double maxLat, double minLng, double maxLng, int cnt) {
		
        Map<String, Object> params = new HashMap<>();
        params.put("minLat", minLat);
        params.put("maxLat", maxLat);
        params.put("minLng", minLng);
        params.put("maxLng", maxLng);
        
        int totalStores = store_dao.countStoresInArea(params);
        return (int) Math.ceil((double) totalStores / cnt);  
        
	}


	public List<PhotoDTO> findPhotosForStores(List<StoreDTO> stores) {
		return store_dao.findPhotosForStores(stores);
	}




	public List<CategoryOptDTO> OptionsCategoryState(int categorystate) {
		return store_dao.OptionsCategoryState(categorystate);
	}

	//매장 나의 게시물
	public List<BoardDTO> storemyboard(int store_idx) {
		return store_dao.storemyboard(store_idx);
	}


	public int storeidx(String attribute) {
		return store_dao.storeidx(attribute);
	}


	public StoreDTO mystore(int store_idx) {
		return store_dao.mystore(store_idx);
	}


    public List<Integer> mystoreopt(int storeIdx) {
        return store_dao.mystoreopt(storeIdx);
    }


	public List<CategoryOptDTO> findStoreCategorys(List<StoreDTO> stores) {
		return store_dao.findStoreCategorys(stores);
	}


	public List<StoreCategoryDTO> storeHelpMeIdx(List<StoreDTO> stores) {
		return  store_dao.storeHelpMeIdx(stores);
	}




}
