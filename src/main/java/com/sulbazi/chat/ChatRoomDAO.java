package com.sulbazi.chat;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRoomDAO {

	/* 개인 채팅방 리스트 */
	List<UserChatroomDTO> chatlist();

	/* 개인 채팅방 리스트 - 검색결과 */
	List<UserChatroomDTO> search(String query);
	
	/* 개인 채팅방 생성 */
	int chatcreate(UserChatroomDTO userchatroomdto);
	
	/* 생성한 채팅방 수정 */
	int updatechatroom(Map<String, String> params);
	
	/* 공지 등록, 수정 */
	int updatenotice(String notice, int userchat_idx);
	
	/* 개인 채팅방 삭제(비공개) */
	int deletechatroom(int userchat_idx);
	
	/* 개인 채팅방 참여 */
	/* 내가 참여중인 채팅방 목록 */
	List<UserChatroomDTO> myroomlist(String user_id);
	/* 방 정보 가져오기 */
	List<UserChatroomDTO> roominfo(int idx);
	/* 입장 가능 인원 수 */
	int current(int idx);
	
	
	/* 지역 채팅방 리스트 */
	List<UserChatroomDTO> localchatlist();

	/* 채팅룸 안에서 지역 채팅방 목록 */
	List<LocalChatroomDTO> localroom();



	









	

	

}
