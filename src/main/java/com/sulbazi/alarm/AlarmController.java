package com.sulbazi.alarm;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;



@RestController
@RequestMapping("/notifications")
public class AlarmController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
    @Autowired AlarmService alarm_ser;  // 변수명을 alarm_ser로 변경
    
   

        // 알림 전송 메서드
	@PostMapping("/send")
	public ResponseEntity<?> sendNotification(@RequestBody Map<String, Object> notification) {
		String receiverId = (String) notification.get("receiverId");
		alarm_ser.sendNotification(receiverId, notification);
		return ResponseEntity.ok("Notification sent successfully");
	}

	// SseEmitter 연결 메서드
	@GetMapping("/connect/{userId}")
	public SseEmitter connect(@PathVariable String userId) {
		return alarm_ser.connect(userId);
	}

    
    @PostMapping("/inquiryanswer.ajax")
    public void inquirynewanswer(
    		@RequestParam String my_id,@RequestParam int inquery_idx) {
        Map<String, Object> map =  alarm_ser.inquirynewanswer(inquery_idx);
        alarm_ser.sendNotification(my_id, map); // 알림 전송
    }
    
/*    //즐겨찾기 새소식
    

    //대화방 강제 퇴장 당함 알림
    @PostMapping(value="/chatroomout.ajax")
    @ResponseBody //주의
    public Map<String, Object> chatroomout(@RequestParam String chatroomboss,
    		@RequestParam String my_id){
    	logger.info("강퇴당한 방 방장:"+chatroomboss);
    	logger.info("나 강퇴..."+my_id);
    	Map<String, Object> map =  alarm_ser.chatroomout(chatroomboss, my_id);
    	return map;
    }
    

    //대화방 거절 당함 알림
    @PostMapping(value="/chatroomdeny.ajax")
    @ResponseBody
    public Map<String, Object> chatroomdeny(@RequestParam String my_id, @RequestParam String chatroomboss) {
    	logger.info("거절당한 방 방장:"+chatroomboss);
    	logger.info("나 거절..."+my_id);
    	Map<String, Object> map = alarm_ser.chatroomdeny(chatroomboss, my_id);		
    	return map;
    }
    
    
    //대화방 참여 수락되었을때 알림
    @PostMapping(value="/chatroomin.ajax")
    @ResponseBody
    public Map<String, Object> chatroomin(@RequestParam String my_id, @RequestParam String chatroomboss) {
    	logger.info("신청 방 방장:"+chatroomboss);
    	logger.info("내 신청"+my_id);
    	Map<String, Object> map = alarm_ser.chatroomin(chatroomboss, my_id);		
    	return map;
    }
    
    
    //내 대화방 참여 수락/거절 선택 알림
    @PostMapping(value="/chatroommanager.ajax")
    @ResponseBody
    public Map<String, Object> chatroommanager(@RequestParam String my_id, @RequestParam String user_id) {
    	logger.info("내가 방장:"+my_id);
    	logger.info("나에게 온 유저:"+user_id);
    	Map<String, Object> map = alarm_ser.chatroommanager(user_id, my_id);		
    	return map;
    }
    
    
    // 관리자(문의 답변) 알림
    @PostMapping(value="/inquiryanswer.ajax")
    @ResponseBody
    public Map<String, Object> inquiryanswer(@RequestParam int inquery_idx){
    	logger.info("문의 글 idx:"+inquery_idx);
    	Map<String, Object> map = alarm_ser.inquirynewanswer(inquery_idx);
    	return map;
    }
    
    
    //공통읽음처리
    @PostMapping(value="/readAlarm.ajax")
    @ResponseBody
    public boolean readalarm(@RequestParam int alarm_id){
    	int row = alarm_ser.readalarm(alarm_id);
    	boolean success = false;
    	if (row > 0 ) {
    		success = true;	
		}
    	return success;
    }*/
    
    
    
    
    
}

