package com.sulbazi.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatPartiDAO {

	/* 개인 채팅방 참여 */
	int userparti(String userId, int idx);
	int partialarm(String id);
	
	/* 방에 참여중인 총 사용자 */
	Integer usertotal(int idx);
	
	/* 방에 참여중인 사용자 */
	List<PartiDTO> userlist(int idx);
	
	/* 채팅방 개설 후 참여 */
	int createparti(int idx, String userId);
	
	/* 지역 채팅방 참여 상태 확인 */
	int localreparti(String userId, int idx);
	/* 지역 채팅방 참여 */
	int insertlocalparti(String userId, int idx);

	
	/* 지역 채팅방에서 나가면 참여상태 false */
	int localroomout(String userId, int roomIdx);
	
	



}
