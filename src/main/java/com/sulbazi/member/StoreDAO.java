package com.sulbazi.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.photo.PhotoDTO;

@Mapper
public interface StoreDAO {

	StoreDTO getStoreDetail(int idx);

	List<PhotoDTO> fileList(int idx);

	List<StoreMenuDTO> getStoreMenuById(int idx);



}
