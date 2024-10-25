package com.sulbazi.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRoomDAO {

	/* 개인 채팅방 리스트 */
	List<UserChatroomDTO> chatlist();

	/* 개인 채팅방 생성 */
	int chatcreate(UserChatroomDTO userchatroomdto);
	
	/* 개인 채팅방 참여 */
	List<UserChatroomDTO> chatroom(String userId); /* 채팅룸 안에서 내가 참여중인 채팅방 목록 */
	
	/* 지역 채팅방 리스트 */
	List<UserChatroomDTO> localchatlist();

	/* 지역 채팅방 참여 */
	List<LocalChatroomDTO> localroom(); /* 채팅룸 안에서 지역 채팅방 목록 */






	

	

}
