package com.sulbazi.chat;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatPartiService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPartiDAO chatparti_dao;
	
	/* 개인 채팅방 참여 */
	public void userparti(String userId, int idx, String id) {
		chatparti_dao.userparti(userId, idx);
		chatparti_dao.partialarm(id);
	}
	
	/* 방에 참여중인 총 사용자 */
	public Integer usertotal(int idx) {
		return chatparti_dao.usertotal(idx);
	}
	
	/* 방에 참여중인 사용자 */
	public List<PartiDTO> userlist(int idx) {
		return chatparti_dao.userlist(idx);
	}

	/* 지역 채팅방 참여 */
	public void localparti(String userId, int idx) {
		
		// 이미 insert된 사용자 찾아서 상태 변경 0 -> 1
		int row = chatparti_dao.localreparti(userId, idx);
		
		// 없으면 새로 insert
		if(row == 0) {
			chatparti_dao.insertlocalparti(userId, idx);
		}
	}

	/* 지역 채팅방에서 나가면 참여상태 false */
	public void localroomout(String userId, int roomIdx) {
		chatparti_dao.localroomout(userId, roomIdx);
	}


}
