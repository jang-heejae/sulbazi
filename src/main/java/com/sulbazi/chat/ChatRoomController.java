package com.sulbazi.chat;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatRoomController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomService chatroom_ser;
	
	/* 개인 채팅방 리스트 */
	
	@RequestMapping(value ="/userchatlist.go")
	public String chatlist(Model model) {
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.chatlist();
		model.addAttribute("list", userchat_list);
		logger.info("userchat_list :"+ userchat_list);
		
		return "chat/userChatList";
	}
	
	/*
	 * @GetMapping(value ="/chatlist.ajax")
	 * 
	 * @ResponseBody public String chatlist(Model model, UserChatroomDTO
	 * userchatroomdto) {
	 * 
	 * String page = "chat/userChatList"; model.addAttribute("chatlist",
	 * chatroom_ser.chatlist(userchatroomdto));
	 * 
	 * return "chat/userChatList"; }
	 */
//	@RequestMapping(value="/chatlist.ajax")
//	@ResponseBody
//	public Map<String, Object> chatlist(){
//		
//		/*
//		 * int page_ = Integer.parseInt(page); int cnt_ = Integer.parseInt(cnt);
//		 */
//		return chatroom_ser.chatlist();
//	}
	
	/* 유저 채팅방 개설 */
	
	@RequestMapping(value="/userchatroom.do")
	public String chatcreate(UserChatroomDTO userchatroomdto) {
	
		chatroom_ser.chatcreate(userchatroomdto);
		 
		 System.out.print("idx :"+userchatroomdto.getUserchat_idx());
		 System.out.print("date :"+userchatroomdto.getUserchat_state());
		 System.out.print("title :"+userchatroomdto.getUserchat_subject());
		 System.out.print("pe :"+userchatroomdto.getCurrent_people());
		 
		 return "chat/userChatRoom";
	}
	
	/* 지역 채팅방 리스트 */
	
	@RequestMapping(value ="/localchatlist.go")
	public String localchatlist(Model model) {
		
		List<UserChatroomDTO> localchat_list = chatroom_ser.localchatlist();
		model.addAttribute("list", localchat_list);
		logger.info("userchat_list :"+ localchat_list);
		
		return "chat/localChatList";
	}
}
