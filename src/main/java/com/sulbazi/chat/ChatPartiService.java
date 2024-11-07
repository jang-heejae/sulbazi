package com.sulbazi.chat;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sulbazi.alarm.AlarmDAO;

@Service
public class ChatPartiService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPartiDAO chatparti_dao;
	@Autowired AlarmDAO alarm_dao;
	@Autowired ChatRoomDAO chatroom_dao;
	
	
	
	/* 개인 채팅방 참여 */
	/* 개인 채팅방 참여 여부 */
	public int roomin(String userId, int idx) {
	    List<PartiDTO> result = chatparti_dao.roomin(userId, idx);
	    logger.info("참여 상태 : "+result);
	    return (result != null && !result.isEmpty()) ? 1 : 0; // 결과가 있으면 1, 없으면 0
	}
	
	/* 각 개인 채팅방의 참여 상태 - 채팅방 리스트 */
	public Integer userchek(String user_id, int chatroom_idx) {
		 Integer partistate = chatparti_dao.userchek(user_id, chatroom_idx);
		 return partistate;
	}
	
	/* 개인 채팅방 참여 신청 */
	public int userparti(String userId, int idx) {
		return chatparti_dao.userparti(userId, idx);		    
	}
	
	/* 방에 참여중인 총 사용자 */
	public Integer usertotal(int idx) {
		return chatparti_dao.usertotal(idx);
	}
	
	/* 방에 참여중인 사용자 - 개인 */
	public List<PartiDTO> userlistajax(int chatroom_idx) {
		return chatparti_dao.userlistajax(chatroom_idx);
	}
	
	/* 개인 채팅방에서 나가기 */
	@Transactional
	public void userroomout(String user_id, int chatroom_idx) {
		int row = chatparti_dao.userroomout(user_id, chatroom_idx);
		if(row > 0) {
			Integer total = chatparti_dao.usertotal(chatroom_idx);
			chatroom_dao.userroomout(total, chatroom_idx);
		}
	}
	
	/* 개인 채팅방 강퇴 */
	@Transactional
	public boolean kickuser(String user_id, int chatroom_idx) {
		boolean success = false;
		
		int row = chatparti_dao.kickuser(user_id, chatroom_idx);
		if(row>0) {
			Integer total = chatparti_dao.usertotal(chatroom_idx);
			chatroom_dao.userroomout(total, chatroom_idx);
			success = true;
		}
		return success;
	}
	
    /*  참여 신청 취소 */
	public int cancelparti(String user_id, int chatroom_idx) {
		return chatparti_dao.cancelparti(user_id, chatroom_idx);
	}
	
	
	
	
	/* ************************  지역 채팅  *************************** */
    
	/* 지역 채팅방 참여 */
	public void localparti(String userId, int idx) {
		
		// 이미 insert된 사용자 찾아서 상태 변경 0 -> 1
		int row = chatparti_dao.localreparti(userId, idx);
		
		// 없으면 새로 insert
		if(row == 0) {
			chatparti_dao.insertlocalparti(userId, idx);
		}
	}
	
	/* 지역 채팅방 참여자 총 인원 */
	public List<PartiDTO> localtotal(int chatroom_idx) {
		return chatparti_dao.localtotal(chatroom_idx);
	}
	
	/* 방에 참여중인 사용자 - 지역 */
	public List<PartiDTO> localuserlistajax(int localchat_idx) {
		return chatparti_dao.localuserlistajax(localchat_idx);
	}
	
	/* 지역 채팅방에서 나가면 참여상태 false */
	public void localroomout(String user_id, int chatroom_idx) {
		chatparti_dao.localroomout(user_id, chatroom_idx);
	}

	

	


	

	
	

	






}
