package com.sulbazi.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StoreDAO {

	List<Integer> storenamesearch(String keyword);

	List<Integer> storemenusearch(String keyword);

	List<Integer> storeaddrsearch(String keyword);

	List<StoreDTO> storesearch(Integer storeidx);
	
}
