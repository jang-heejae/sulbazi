package com.sulbazi.chat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
        if (userId == null) {
            // 로그인되지 않은 경우 예외 처리 또는 리다이렉션
            throw new IllegalStateException("로그인된 사용자가 없습니다.");
        }
        return sseService.connectKick(userId);  // 강퇴 알림을 위한 SSE 연결
    }
    
}
