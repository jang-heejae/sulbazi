package com.sulbazi.alarm;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class AlarmController {

    @Autowired
    private AlarmService alarm_ser;

    Logger logger = LoggerFactory.getLogger(getClass());

    //즐겨찾기 매장 홍보게시물 알림
    @PostMapping(value="/bookmarknew.ajax")
    public String  bookmarknew() {
    	
    	
    	
    	
    	
    	
    	return null;
    }
    
    
    
    
    //대화방 강제 퇴장 당함 알림
    @PostMapping(value="/chatroomout.ajax")
    public String chatroomout(@RequestParam("chatroom_idx") int chatroom_idx,
            @RequestParam("user_id") String user_id, 
            Model model){
    	logger.info(""+chatroom_idx);
    	logger.info(""+user_id);
    	Map<String, String> chatroomout =  alarm_ser.chatroomout(chatroom_idx, user_id);
    	model.addAttribute("chatroomout", chatroomout);
    	return "user/userAlarm";
    }
    
    //대화방 거절 당함 알림
    @PostMapping(value="/chatroomdeny.ajax")
    public String chatroomdeny(){
    	return null;
    }
    
    
    //대화방 참여 수락되었을때 알림
    @PostMapping(value="/chatroomin.ajax")
    public String chatroomin(){
    	return null;
    }
    
    
    //내 대화방 참여 수락/거절 선택 알림
    @PostMapping(value="/chatroommanager.ajax")
    public String chatroommanager(){
    	return null;
    }
    
    
    // 관리자(문의 답변) 알림
    @PostMapping(value="/inquiryanswer.ajax")
    public String inquiryanswer(){
    	return null;
    }
}

