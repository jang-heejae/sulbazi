package com.sulbazi.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRoomDAO {

	/* 개인 채팅방 리스트 */
	List<UserChatroomDTO> chatlist();

	/* 개인 채팅방 생성 */
	int chatcreate(UserChatroomDTO dto);

	/* 지역 채팅방 리스트 */
	List<UserChatroomDTO> localchatlist();



	

	

}
