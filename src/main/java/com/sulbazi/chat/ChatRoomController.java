package com.sulbazi.chat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatRoomController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomService chatroom_ser;
	
	/* 개인 채팅방 리스트 */
	
	@RequestMapping(value ="/userchatlist.go")
	public String chatlist(HttpSession session, Model model) {
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.chatlist();
		model.addAttribute("list", userchat_list);
		logger.info("userchat_list :"+ userchat_list);
		logger.info("세션아이디 : "+session.getAttribute("loginId"));
		
		return "chat/userChatList";
	}
	
	/* 유저 채팅방 개설 */
	
	@PostMapping(value="/userchatroom.do")
	public String chatcreate(HttpSession session, UserChatroomDTO userchatroomdto, Model model) {
		
		String page;
		
		String userId = (String) session.getAttribute("loginId"); // 세션에서 로그인 아이디
		if(userId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {		
			int row = chatroom_ser.chatcreate(userchatroomdto, model);
			
			if(row>0) {
				page = "/chat/userChatRoom";
			}else {
				session.setAttribute("session", "방 생성 불가 : 개설된 방이 있습니다.");
				page = "redirect:./userchatlist.go";
			}
		}
		return page;
	}

	
	/* 개인 채팅방 참여 */
	@RequestMapping(value="/userchatroom.go")
	public String chatroom(HttpSession session, Model model) {
		
		String userId = (String) session.getAttribute("loginId");
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.chatroom(userId);
		model.addAttribute("list", userchat_list);
		
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
	
	/* 지역 채팅방 입장 */
	@RequestMapping(value="/localchatroom.go")
	public String localchatgo() {
		return "chat/localChatList";
	}
}
