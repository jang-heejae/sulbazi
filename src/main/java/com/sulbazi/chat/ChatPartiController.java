package com.sulbazi.chat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatPartiController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPartiService chatparti_ser;
	
	/* 각 채팅방의 참여자 수 - 채팅방 리스트 */
	@GetMapping(value="/usertotal.ajax")
	@ResponseBody
	public Integer usertotal(@RequestParam int chatroom_idx) {
	    return chatparti_ser.usertotal(chatroom_idx);
	}

	
	
	
	
	
	/* 개인 채팅방 참여자 리스트 */
	@GetMapping(value="/userlist.ajax")
	@ResponseBody
	public List<PartiDTO> userlistajax(@RequestParam("chatroom_idx") int chatroomIdx) {
	    return chatparti_ser.userlistajax(chatroomIdx);
	}
	
	
	
	
	
	/* 지역 채팅방에서 나가면 참여상태 false */
	@PostMapping(value="/localroomout.ajax")
	@ResponseBody
	public String localroomout(HttpSession session, @RequestParam int roomIdx) {
		
		String userId = (String) session.getAttribute("loginId");
		
		chatparti_ser.localroomout(userId, roomIdx);
		return "success";
	}
	
	
}
