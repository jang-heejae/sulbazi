package com.sulbazi.member;


import java.util.List;


import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.category.CategoryDTO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;


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

	public Map<String, Object> storemenusearch(String keyword,int page,int cnt) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		
		logger.info("매장메뉴키워드서비스");
		logger.info(keyword);
		List<Integer> menusearch = store_dao.storemenusearch(keyword);
		logger.info("필터링된 매장 idx" + menusearch);
		
		int totalPages = (int) Math.ceil((double) menusearch.size() / cnt);
		
		
		List<StoreDTO> filteringstorelist ; 
		Map<String, Object> map = new HashMap<String, Object>();
		List<StoreDTO> accumulatedFilteringStoreList = new ArrayList<>();
		 
		 for (Integer storeidx : menusearch) { 
			 logger.info("하나하나 분리: {}", storeidx); 
			 filteringstorelist =store_dao.storesearch(storeidx);
			 logger.info("list: {}", filteringstorelist); 
			 
			 accumulatedFilteringStoreList.addAll(filteringstorelist);
			 
		 }	
		 
		 
		 accumulatedFilteringStoreList.sort(
				    Comparator.comparingDouble(StoreDTO::getStar_average).reversed() // 별점 높은 순
				              .thenComparingInt(StoreDTO::getReview_total).reversed() // 리뷰 수 높은 순
				              .thenComparingInt(StoreDTO::getStore_idx) // store_idx 오름차순
				);
		 int toIndex = Math.min(offset + limit, accumulatedFilteringStoreList.size());
		 List<StoreDTO> paginatedList = accumulatedFilteringStoreList.subList(offset, toIndex);
		 
		 List<PhotoDTO> photoList = store_dao.findPhotosForStores(paginatedList);
		 List<CategoryOptDTO> categoryOpts = store_dao.findStoreCategorys(paginatedList);
		 List<StoreCategoryDTO> storeCategorys = store_dao.storeHelpMeIdx(paginatedList);
		 
		 map.put("searchresult", paginatedList);
		 map.put("totalPages", totalPages);
		 map.put("photos", photoList);
		 map.put("categoryOpts", categoryOpts);
		 map.put("storeCategorys", storeCategorys);
		
		 logger.info("map 종원 {}:",map);
		 
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


	public boolean mystoreupdate(Map<String, String> params, int idx) {
		StoreDTO storedto = new StoreDTO();
		storedto.setStore_idx(idx);
		storedto.setStore_pw(params.get("store_pw"));
		storedto.setStore_name(params.get("store_name"));
		storedto.setStore_phone(params.get("store_phone"));
		storedto.setStore_address(params.get("store_address"));
		storedto.setStore_time(params.get("store_time"));
		int row = store_dao.mystoreupdate(storedto);
		boolean success = false;
		if(row != 0) {
			success = true;
		}
		return success;
	}

	public List<CategoryOptDTO> findStoreCategorys(List<StoreDTO> stores) {
		return store_dao.findStoreCategorys(stores);
	}


	public List<StoreCategoryDTO> storeHelpMeIdx(List<StoreDTO> stores) {
		return  store_dao.storeHelpMeIdx(stores);
	}

	public List<StoreMenuDTO> storemenulist(int store_idx) {
		return store_dao.storemenulist(store_idx);
	}



	public List<StoreMenuDTO> storealcholmenulist(int store_idx) {
		return store_dao.storealcholmenulist(store_idx);
		   }


	public boolean menuupdate(String menu_name, String menu_price, String menu_idx) {
		boolean success = false;
		int row = store_dao.menuupdate(menu_name,menu_price,menu_idx);
		if(row != 0) {
			success = true;
		}
		return success;
	}


	public boolean menudelete(String menu_idx) {
		boolean success = false;
		int row = store_dao.menuudelete(menu_idx);
		if(row != 0) {
			success = true;
		}
		return false;
	}

	
	public int menuinsert(MultipartFile[] files,int store_idx, Map<String, String> params) {
		StoreMenuDTO store_menu = new StoreMenuDTO();
		PhotoService photo_ser = new PhotoService();
		store_menu.setMenu_name(params.get("menu_name"));//메뉴 이름
		store_menu.setMenu_price(params.get("menu_price"));//메뉴 가격
		store_menu.setStore_idx(store_idx);
		store_menu.setMenu_category(params.get("menu_category"));
		int row = store_dao.menuinsert(store_menu);
		int photofolderidx = store_menu.getMenu_idx();
		logger.info("방금 insert 한"+photofolderidx);//폴더 idx
		if (photofolderidx>0 && row>0) {
			photo_ser.menuphotoFile(files,photofolderidx,params);
		}
		return photofolderidx;
	}

}




