package com.sulbazi.chat;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatPartiController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPartiService chatparti_ser;
	
	/* 지역 채팅방에서 나가면 참여상태 false */
	@PostMapping(value="/localroomout.ajax")
	@ResponseBody
	public String localroomout(HttpSession session, @RequestParam int roomIdx) {
		
		String userId = (String) session.getAttribute("loginId");
		
		chatparti_ser.localroomout(userId, roomIdx);
		return "success";
	}
}
