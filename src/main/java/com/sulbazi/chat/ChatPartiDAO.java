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
	
	/* 개인 채팅방 참여 수락 됨 */
	int handleAccept(int roomidx, String user_id);
	
	/* 개인 채팅방 참여 거절 됨 */
	int handleDeny(int chatroom_idx, String my_id);
	
	/* 방에 참여중인 총 사용자 */
	Integer usertotal(int idx);
	
	/* 방에 참여중인 사용자 - 개인 */
	List<PartiDTO> userlistajax(int chatroom_idx);
	
	/* 채팅방 개설 후 참여 */
	int createparti(int idx, String userId);
	
	/* 개인 채팅방에서 나가기 */
	int userroomout(String user_id, int chatroom_idx);
	
	/* 개인 채팅방 강퇴 */
	int kickuser(String user_id, int chatroom_idx);
	
	/* 참여 신청 취소 */
	int cancelparti(String user_id, int chatroom_idx);


	
	
	
	
	/* 지역 채팅방 참여자 총 인원 */
	List<PartiDTO> localtotal(int chatroom_idx);
	
	/* 지역 채팅방 참여 상태 확인 */
	int localreparti(String userId, int idx);
	
	/* 지역 채팅방 참여 */
	int insertlocalparti(String userId, int idx);

	/* 지역 채팅방에서 나가면 참여상태 false */
	int localroomout(String user_id, int chatroom_idx);
	
	/* 방에 참여중인 사용자 - 지역 */
	List<PartiDTO> localuserlistajax(int localchat_idx);




	


	

	

	




	
	
	
	
	
	
	



}
