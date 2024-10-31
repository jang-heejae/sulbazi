package com.sulbazi.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.remoting.jaxws.SimpleHttpServerJaxWsServiceExporter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

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
	
	private final CopyOnWriteArrayList<SseEmitter> emitters = new CopyOnWriteArrayList<>();


	/* 개인 채팅방 참여자 리스트 - SSE */
	@GetMapping(value="/sse/list")
    @ResponseBody
    public SseEmitter userlistsse() {
        SseEmitter emitter = new SseEmitter(0L);
        emitters.add(emitter);

        emitter.onCompletion(() -> emitters.remove(emitter));
        emitter.onTimeout(() -> emitters.remove(emitter));

        return emitter;
    }
	
	
	/* 개인 채팅방 참여자 리스트 - ajax */
	@GetMapping(value="/userlist.ajax")
	@ResponseBody
	public List<PartiDTO> userlistajax(@RequestParam("chatroom_idx") int chatroom_idx) {
	    List<PartiDTO> participants = chatparti_ser.userlistajax(chatroom_idx);
	    
	    // 모든 연결된 클라이언트에게 새 유저 이벤트 전송
	    for (SseEmitter emitter : emitters) {
	        try {
	            emitter.send(SseEmitter.event()
	                .name("newuser")
	                .data("새 유저가 도착했습니다."));
	        } catch (Exception e) {
	            emitters.remove(emitter);
	        }
	    }
	    
	    return participants; // 리스트 반환
	}
	
	/* 개인 채팅방에서 나가면 참여상태 false */
	@PostMapping(value="/userroomout.ajax")
	@ResponseBody
	public String userroomout(HttpSession session, @RequestParam int chatroom_idx) {
		
		String userId = (String) session.getAttribute("loginId");
		
		chatparti_ser.userroomout(userId, chatroom_idx);
		
		return "success";
	}
	
	/* 개인 채팅방 강퇴 */
	@PostMapping(value="/kickuser.ajax")
	@ResponseBody
	public Map<String, Object> kickuser(@RequestParam Map<String, String> params) {
		
		boolean success = chatparti_ser.kickuser(params);
		
		 if (success) {
			 chatparti_ser.notifyUserOfKick(params.get("user_id"));
		 }
		 
		Map<String, Object> response = new HashMap<String, Object>();
	    response.put("redirect", success); // 클라이언트에게 리다이렉션 요청
	    
	    return response;
	}
	
	/* 강퇴당한 사용자 페이지 강제 이동 */
	@GetMapping("/subscribe")
	public SseEmitter subscribe(HttpSession session) {
	    String userId = (String) session.getAttribute("loginId");
	    return chatparti_ser.registerSse(userId);
	}
	
	
	
	
	
	
	
	
	/* 지역 채팅방 참여자 리스트 */
	@GetMapping(value="/localuserlist.ajax")
	@ResponseBody
	public List<PartiDTO> localuserlistajax(@RequestParam("localchat_idx") int localchat_idx) {
	    return chatparti_ser.localuserlistajax(localchat_idx);
	}
	
	
	
	/* 지역 채팅방에서 나가면 참여상태 false */
	@PostMapping(value="/localroomout.ajax")
	@ResponseBody
	public String localroomout(HttpSession session, @RequestParam int chatroom_idx) {
		
		String userId = (String) session.getAttribute("loginId");
		
		chatparti_ser.localroomout(userId, chatroom_idx);
		return "success";
	}
	
	
}
