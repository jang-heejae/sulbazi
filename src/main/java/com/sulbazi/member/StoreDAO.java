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

	List<PhotoDTO> getStorePhoto(int idx);

	BoardDTO getBoard(int idx);

	List<PhotoDTO> alcoholFileList(int idx);

	List<StoreMenuDTO> getStoreAlcohol(int idx);

	Object bookmarkCheck(String loginId, int storeidx);
	

}
