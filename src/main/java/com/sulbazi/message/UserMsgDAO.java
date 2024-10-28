package com.sulbazi.message;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.UserDTO;

@Mapper
public interface UserMsgDAO {
	
	/* 채팅방 참여 시 해당방 메세지 출력 */
	List<UserMsgDTO> usermsg(int idx); 

	/* 채팅방에서 각 메세지 작성한 id가지고 닉네임 뽑기 */
	UserDTO getUserById(String messageUserId); 
	
}
