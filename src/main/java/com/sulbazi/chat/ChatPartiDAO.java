package com.sulbazi.chat;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatPartiDAO {

	/* 각 개인 채팅방의 참여 상태 - 채팅방 리스트 */
	Integer userchek(String user_id, int chatroom_idx);

	/* 개인 채팅방 참여 여부 */
	List<PartiDTO> roomin(String userId, int idx);
	
	/* 개인 채팅방 참여 */
	int userparti(String userId, int idx);
	
	/* 방에 참여중인 총 사용자 */
	Integer usertotal(int idx);
	
	/* 방에 참여중인 사용자 - 개인 */
	List<PartiDTO> userlist(int idx);
	List<PartiDTO> userlistajax(int chatroom_idx);
	
	/* 채팅방 개설 후 참여 */
	int createparti(int idx, String userId);
	
	/* 개인 채팅방에서 나가기 */
	boolean userroomout(String user_id, int chatroom_idx);
	
	/* 개인 채팅방 강퇴 */
	int kickuser(Map<String, String> params);
	

	
	
	
	
	/* 지역 채팅방 참여자 총 인원 */
	List<PartiDTO> localtotal(int chatroom_idx);
	
	/* 지역 채팅방 참여 상태 확인 */
	int localreparti(String userId, int idx);
	
	/* 지역 채팅방 참여 */
	int insertlocalparti(String userId, int idx);

	/* 지역 채팅방에서 나가면 참여상태 false */
	int localroomout(String user_id, int chatroom_idx);
	
	/* 방에 참여중인 사용자 - 지역 */
	List<PartiDTO> localuserlist(int idx);
	List<PartiDTO> localuserlistajax(int localchat_idx);


	

	




	
	
	
	
	
	
	



}
