package com.sulbazi.chat;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChatRoomService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomDAO chatroom_dao;
	@Autowired ChatPartiDAO chatparti_dao;
	
	/* 개인 채팅방 리스트 */
	public List<UserChatroomDTO> chatlist() {
		return chatroom_dao.chatlist();
	}
	
	/* 개인 채팅방 리스트 - 검색결과 */
	public List<UserChatroomDTO> search(String query) {
		return chatroom_dao.search(query);
	}
	
	/* 개인 채팅방 생성 */	
	public int chatcreate(UserChatroomDTO userchatroomdto, Model model, String userId) {
		
		int row = chatroom_dao.chatcreate(userchatroomdto);
		
		if(row>0) {
	
			int idx = userchatroomdto.getUserchat_idx();
		
			model.addAttribute("idx", idx);
			model.addAttribute("msg", "방이 개설되었습니다.");
			logger.info("방금 insert한 idx : "+idx);
			
//			chatroom_dao.createuser(idx, userId);
//			chatparti_dao.createparti(idx, userId);
			
		}		
		return row;
	}
	
	/* 생성한 채팅방 수정 */	
	public void updatechatroom(Map<String, String> params) {
		chatroom_dao.updatechatroom(params);
	}

	/* 공지 등록, 수정 */
	public void updatenotice(String notice, int userchat_idx) {
		chatroom_dao.updatenotice(notice, userchat_idx);
	}
	
	/* 개인 채팅방 삭제(비공개) */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public boolean deleteroom(int userchat_idx, String user_id) {
		
		boolean success = false;
		int row = chatroom_dao.deletechatroom(userchat_idx);
		
		if(row>0) {
			int chatroom_idx = userchat_idx;
			logger.info("방 비공개 됨");
			if(chatparti_dao.userroomout(user_id, chatroom_idx)) {
				success = true;
			}
			
		}else {
			logger.info("비공개 안됨");
		}
		return success;
	}
	
	/* 개인 채팅방 참여 */
	/* 방 정보 가져오기 */
	public List<UserChatroomDTO> roominfo(int idx) {
		return chatroom_dao.roominfo(idx);
	}
	/* 현재 인원수 추가 */
	public void roomin(int idx) {
		chatroom_dao.roomin(idx);
	}
	/* 입장 가능 인원 수 */
	public Integer current(int idx) {
		return chatroom_dao.current(idx);
	}
	
	/* 내가 참여중인 채팅방 목록 */
	public List<UserChatroomDTO> myroomlist(String user_id) {
		return chatroom_dao.myroomlist(user_id);
	}
	
	
	
	/* ************************  지역 채팅  *************************** */
	
	/* 지역 채팅방 리스트 */	
	public List<LocalChatroomDTO> localchatlist() {
		return chatroom_dao.localchatlist();
	}
	
	/* 지역 채팅방 정보 */
	public List<LocalChatroomDTO> localroominfo(int idx) {
		return chatroom_dao.localroominfo(idx);
	}


	


	


	










		 



	
	
}
