package com.sulbazi.member;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JoinDAO {
	
	int storeJoin(StoreDTO dto);

	int userJoindo(UserDTO userDTO);

	boolean checkid(String userId);

	boolean checkEmail(String userEmail);

	boolean checknumber(String storenumber);
}
