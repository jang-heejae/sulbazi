package com.sulbazi.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JoinDAO {
	
	int storeJoin(StoreDTO dto);
}
