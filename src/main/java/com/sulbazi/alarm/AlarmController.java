package com.sulbazi.alarm;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

    //문의 글  알림
    @PostMapping("/inquiryanswer.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> inquirynewanswer(
    		@RequestParam String id_write,@RequestParam int inquery_idx) {
    	logger.info(" 문의 글 쓴 ID"+id_write);
    	logger.info("문의 글 idx"+inquery_idx);
        Map<String, Object> map =  alarm_ser.inquirynewanswer(inquery_idx);
        alarm_ser.sendNotification(id_write, map); // 알림 전송
        return ResponseEntity.ok(map);
    }
    
   //즐겨찾기 새소식
    @PostMapping(value="/bookmarknew.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bookmarknew(@RequestParam String user_id){
    	logger.info("내 id:"+user_id);
    	Map<String, Object> map =  alarm_ser.bookmarknew(user_id);
    	alarm_ser.sendNotification(user_id, map);
    	return ResponseEntity.ok(map);
    }

    //대화방 강제 퇴장 당함 알림
    @PostMapping(value="/chatroomout.ajax")
    @ResponseBody //주의
    public ResponseEntity<Map<String, Object>> chatroomout(@RequestParam String chatroomboss,
    		@RequestParam String user_id){
    	logger.info("강퇴당한 방 방장:"+chatroomboss);
    	logger.info("나 강퇴..."+user_id);
    	Map<String, Object> map =  alarm_ser.chatroomout(chatroomboss, user_id);
    	alarm_ser.sendNotification(user_id, map);
    	return ResponseEntity.ok(map);
    }
    

    //대화방 거절 당함 알림
    @PostMapping(value="/chatroomdeny.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> chatroomdeny(@RequestParam String user_id,
     		@RequestParam String chatroomboss) {
    	logger.info("거절당한 방 방장:"+chatroomboss);
    	logger.info("나 거절..."+user_id);
    	Map<String, Object> map = alarm_ser.chatroomdeny(chatroomboss, user_id);		
    	alarm_ser.sendNotification(user_id, map);
    	return ResponseEntity.ok(map);
    }
    
    
    //대화방 참여 수락되었을때 알림
    @PostMapping(value="/chatroomin.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> chatroomin(@RequestParam String user_id, @RequestParam String chatroomboss) {
    	logger.info("신청 방 방장:"+chatroomboss);
    	logger.info("내 신청"+user_id);
    	Map<String, Object> map = alarm_ser.chatroomin(chatroomboss, user_id);	
    	alarm_ser.sendNotification(user_id, map);	
    	return ResponseEntity.ok(map);
    }
    
    
    //내 대화방 참여 수락/거절 선택 알림
    @PostMapping(value="/chatroommanager.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> chatroommanager(@RequestParam String getuser_id, @RequestParam String user_id) {
    	logger.info("내가 방장:"+getuser_id);
    	logger.info("나에게 온 유저:"+user_id);
    	Map<String, Object> map = alarm_ser.chatroommanager(getuser_id, user_id);		
    	alarm_ser.sendNotification(getuser_id, map);	
    	return ResponseEntity.ok(map);
    }
    
   
    
    
    //공통읽음처리
    @PostMapping(value="/readAlarm.ajax")
    @ResponseBody
    public ResponseEntity<?> readAlarm(@RequestParam("alarm_idx")  int alarm_idx, 
                                        @RequestParam String receiverId) {
        int row = alarm_ser.readalarm(alarm_idx);
        boolean success = false;

        if (row > 0) {
            success = true;	
        }

        // 성공 여부에 따른 ResponseEntity 반환
        if (success) {
            return ResponseEntity.ok().body("알림 읽음 처리 성공");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("알림 읽음 처리 실패");
        }
    }
    
    
    
    
    
}

