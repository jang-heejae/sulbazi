package com.sulbazi.member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.photo.PhotoDTO;

@Mapper
public interface UserDAO {

	List<UserDTO> files(String user_id);

	UserDTO getUserInfo(String user_id);

	List<HashMap<String, Object>> getUserCategories(String user_id);

	List<HashMap<String, Object>> getAllCategories();

	boolean userUpdateCate(String user_id, String value);

	int userUpdate(UserDTO userDto);

	int overlay(String user_nickname);
}
