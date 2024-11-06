package com.sulbazi.chat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
public class SseController {

    @Autowired
    private SseService sseService;

    // 메세지, 유저리스트, 공지사항 업데이트 SSE
    @GetMapping("/sse/all")
    public SseEmitter subscribeAll() {
        return sseService.connectAll();  // 메세지, 유저리스트, 공지사항 전송을 위한 SSE 연결
    }

    // 강퇴 알림 SSE
    @GetMapping("/subscribe")
    public SseEmitter subscribeKick(HttpSession session) {
        String userId = (String) session.getAttribute("loginId");
        return sseService.connectKick();  // 강퇴 알림을 위한 SSE 연결
    }
}
