package com.sulbazi.chat;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.message.UserMsgDTO;

@Service
public class ChatRoomService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomDAO chatroom_dao;
	
	/* 개인 채팅방 리스트 */
	
	public List<UserChatroomDTO> chatlist() {
		return chatroom_dao.chatlist();
	}
	
	/* 유저 채팅방 개설 */
	
	public int chatcreate(UserChatroomDTO userchatroomdto, Model model) {
		
		int row = chatroom_dao.chatcreate(userchatroomdto);
		
		if(row>0) {
	
			int idx = userchatroomdto.getUserchat_idx();
			model.addAttribute("roomidx", idx);
			
			logger.info("방금 insert한 idx : "+idx);
			
		}
		
		return row;
		
	}

	/* 개인 채팅방 참여 */
	
	public List<UserChatroomDTO> chatroom(String userId) {
		return chatroom_dao.chatroom(userId);
	}
	
	/* 지역 채팅방 리스트 */
	
	public List<UserChatroomDTO> localchatlist() {
		return chatroom_dao.localchatlist();
	}

	public List<LocalChatroomDTO> localroom() {
		return chatroom_dao.localroom();
	}





		 



	
	
}
