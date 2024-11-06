package com.sulbazi.chat;

import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Service
public class SseService {

    // 메세지, 유저리스트, 공지사항 이벤트를 위한 SseEmitter
    private final CopyOnWriteArrayList<SseEmitter> emittersForAll = new CopyOnWriteArrayList<>();
    // 강퇴 이벤트를 위한 SseEmitter
    private final CopyOnWriteArrayList<SseEmitter> emittersForKick = new CopyOnWriteArrayList<>();

    // 연결 처리 메서드 - 메세지, 유저리스트, 공지사항
    public SseEmitter connectAll() {
        SseEmitter emitter = new SseEmitter(3600000L); // 1시간 제한
        emittersForAll.add(emitter);

        emitter.onCompletion(() -> emittersForAll.remove(emitter));
        emitter.onTimeout(() -> emittersForAll.remove(emitter));

        return emitter;
    }

    // 연결 처리 메서드 - 강퇴 알림
    public SseEmitter connectKick() {
        SseEmitter emitter = new SseEmitter(3600000L); // 1시간 제한
        emittersForKick.add(emitter);

        emitter.onCompletion(() -> emittersForKick.remove(emitter));
        emitter.onTimeout(() -> emittersForKick.remove(emitter));

        return emitter;
    }

    // 메세지, 유저리스트, 공지사항을 모든 클라이언트에게 전송
    public void sendMessageToAll(String message) {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("newMessage").data(message));
            } catch (Exception e) {
                emittersForAll.remove(emitter);
            }
        }
    }

    // 유저 리스트 업데이트 알림 전송
    public void notifyNewUser() {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("newuser").data("리스트 업데이트"));
            } catch (Exception e) {
                emittersForAll.remove(emitter);
            }
        }
    }

    // 방 정보 업데이트 전송
    public void updateRoom(String updateRoom) {
    	for (SseEmitter emitter : emittersForAll) {
    		try {
    			emitter.send(SseEmitter.event().name("updateRoom").data(updateRoom));
    		} catch (Exception e) {
    			emittersForAll.remove(emitter);
    		}
    	}
    }
    
    // 공지사항 업데이트 전송
    public void updateNotice(String updatedNotice) {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("noticeUpdate").data(updatedNotice));
            } catch (Exception e) {
                emittersForAll.remove(emitter);
            }
        }
    }

    // 강퇴된 사용자에게 강퇴 알림 전송
    public void notifyKick(String userId) {
        for (SseEmitter emitter : emittersForKick) {
            try {
                emitter.send(SseEmitter.event().name("kick").data(userId + "님이 강퇴되었습니다."));
            } catch (Exception e) {
                emittersForKick.remove(emitter);
            }
        }
    }
}


