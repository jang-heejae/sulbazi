package com.sulbazi.chat;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatRoomService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomDAO chatroom_dao;
	
	/* 개인 채팅방 리스트 */

	public List<UserChatroomDTO> chatlist() {
		return chatroom_dao.chatlist();	
	}
	
//	public List<UserChatroomDTO> chatlist(UserChatroomDTO userchatroomdto) {
//		return chatroom_dao.chatlist(userchatroomdto); 
//	}
	
//	public Map<String, Object> chatlist() {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		
//		result.put("chatlist", chatroom_dao.chatlist());
//		
//		return result;
//	}
	
//		List<Chatroom> chatrooms = chatroom_dao.chatlist(); // 모든 채팅방을 가져오는 예시
//
//	    Map<String, Object> result = new HashMap<>();
//	    result.put("chatlist", chatrooms);
//	    
//	    return result;
//	}
	
	/* 유저 채팅방 개설 */
	public void chatcreate(UserChatroomDTO userchatroomdto) {
		
		UserChatroomDTO dto = new UserChatroomDTO();
		dto.setUserchat_subject(userchatroomdto.getUserchat_subject());
		dto.setCurrent_people(userchatroomdto.getCurrent_people());
		
		chatroom_dao.chatcreate(dto);
		
	}
//	public void chatcreate(Map<String, String> param) {
//		
//		UserChatroomDTO dto = new UserChatroomDTO();
//		dto.setUserchat_subject(param.get("userchat_subject"));
//		dto.setCurrent_people(Integer.parseInt(param.get("current_people")));
//		 
//		int row = chatroom_dao.chatcreate(dto); int idx = dto.getUserchat_idx();
//			
//		if(idx>0&&row>0) { 
//			listmsg(idx); 
//		} 
//	}

	/* 지역 채팅방 리스트 */
	
	public List<UserChatroomDTO> localchatlist() {
		return chatroom_dao.localchatlist();
	}
		 



	
	
}
