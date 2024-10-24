package com.sulbazi.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.board.BoardDTO;
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

	int bookmarkCheck(String user_id, int store_idx);

	int bookmarkCheckCount(String user_id, int store_idx);

	int delBookmark(String user_id, int store_idx);

	List<PhotoDTO> getStorePhotos(int idx);

	int storeBookmarkCheck(int store_idx);

	void updateStoreFavoriteCount(int store_idx, int bookmark_user);




	

}
