package com.sulbazi.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;

@Mapper
public interface StoreDAO {

	StoreDTO getStoreDetail(int idx);

	List<PhotoDTO> fileList(int idx);

	List<StoreMenuDTO> getStoreMenuById(int idx);


	List<Integer> storenamesearch(String keyword);

	List<Integer> storemenusearch(String keyword);

	List<Integer> storeaddrsearch(String keyword);

	List<StoreDTO> storesearch(Integer storeidx);

	PhotoDTO getStorePhoto(int idx);

	BoardDTO getBoard(int idx);

	List<PhotoDTO> alcoholFileList(int idx);

	List<StoreMenuDTO> getStoreAlcohol(int idx);

	int bookmarkCheckCount(Map<String, Object> map);

	List<PhotoDTO> getStorePhotos(int idx);

	int storeBookmarkCheck(int store_idx);

	void updateStoreFavoriteCount(int store_idx, int bookmark_user);

	List<Integer> stCategory(int idx);

	CategoryOptDTO storeByCategoryopt(Integer integer);

	int delBookmark(Map<String, Object> map);

	int bookmarkCheck(Map<String, Object> map);

	List<StoreDTO> findStoresInArea(Map<String, Object> params);
	
	int countStoresInArea(Map<String, Object> params);

	List<PhotoDTO> findPhotosForStores(List<StoreDTO> stores);

	List<StoreCategoryDTO> findStoreCategorys(List<StoreDTO> stores);

	List<CategoryOptDTO> findCategotyOpts(List<StoreCategoryDTO> storeCategorys);

	List<CategoryOptDTO> OptionsCategoryState(int categorystate);

	List<BoardDTO> storemyboard(int store_idx);

	int storeidx(String attribute);

	StoreDTO mystore(int store_idx);

	List<Integer> mystoreopt(int storeIdx);

	int mystoreupdate(StoreDTO storedto);






	

}
