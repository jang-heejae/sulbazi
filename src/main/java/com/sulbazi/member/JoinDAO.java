package com.sulbazi.member;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JoinDAO {
	
	int storeJoin(StoreDTO dto);

	int userJoindo(UserDTO userDTO);
}
