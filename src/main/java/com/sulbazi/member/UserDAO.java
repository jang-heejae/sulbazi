package com.sulbazi.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.review.ReviewDTO;

@Mapper
public interface UserDAO {

	List<UserDTO> files(String user_id);
 
	UserDTO getUserInfo(String user_id);

	List<HashMap<String, Object>> getUserCategories(String user_id);

	List<HashMap<String, Object>> getAllCategories();

	boolean userUpdateCate(String user_id, String value);

	int userUpdate(UserDTO userDto);

	int overlay(String user_nickname);
	
	List<Map<String, Object>> storeOptName(String user_id);
	
	
	// 채팅 신고 기능
	// 신고한 횟수
	int report(String reporting_id, int reporting);

	// 신고당한 횟수
	int reported(String reported_id, int reported);

	// 채팅방 주인(닉네임, 사진)
	UserDTO user(String user_id);
	
	
	
	List<BookMarkDTO> userBookmark(String userId);

	
}
