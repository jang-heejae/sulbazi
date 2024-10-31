package com.sulbazi.message;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
public class MessageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MessageService msg_ser;
	
	
	// SSE
	private final CopyOnWriteArrayList<SseEmitter> emitters = new CopyOnWriteArrayList<>();

    @GetMapping(value="/sse/connect")
    @ResponseBody
    public SseEmitter connect() {
        SseEmitter emitter = new SseEmitter(0L);
        emitters.add(emitter);

        emitter.onCompletion(() -> emitters.remove(emitter));
        emitter.onTimeout(() -> emitters.remove(emitter));

        return emitter;
    }
	
	// 개인 채팅방
	// 메세지 전송
    @PostMapping(value="/sendMessage.ajax")
    @ResponseBody
    public String sendmsg(@RequestParam String user_id, @RequestParam String usermsg_content, @RequestParam int userchat_idx, Model model) {
        msg_ser.sendmsg(user_id, usermsg_content, userchat_idx, model);
        
        // 모든 연결된 클라이언트에게 새 메시지 이벤트 전송
        for (SseEmitter emitter : emitters) {
            try {
                emitter.send(SseEmitter.event()
                    .name("newMessage")
                    .data("새 메시지가 도착했습니다."));
            } catch (Exception e) {
                emitters.remove(emitter);
            }
        }
        
        return "success";
    }
    
    // 메세지 로드
    @GetMapping(value="/loadMessages.ajax")
    @ResponseBody
    public List<UserMsgDTO> getmsg(@RequestParam int userchat_idx) {
        return msg_ser.getmsg(userchat_idx);
    }

    
    // 지역 채팅방
    // 메세지 전송
    @PostMapping(value="/localsendMessage.ajax")
    @ResponseBody
    public String localsendmsg(@RequestParam String user_id, @RequestParam String localmsg_content, @RequestParam int localchat_idx, Model model) {
        msg_ser.localsendmsg(user_id, localmsg_content, localchat_idx, model);
        return "success";
    }
    
    // 메세지 로드
    @GetMapping(value="/localloadMessages.ajax")
    @ResponseBody
    public List<UserMsgDTO> getlocalmsg(@RequestParam int localchat_idx) {
        return msg_ser.getlocalmsg(localchat_idx);
    }
    
}
