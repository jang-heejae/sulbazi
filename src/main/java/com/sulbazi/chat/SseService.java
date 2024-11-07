package com.sulbazi.chat;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Service
public class SseService {

    // 메세지, 유저리스트, 공지사항 이벤트를 위한 SseEmitter
    private final CopyOnWriteArrayList<SseEmitter> emittersForAll = new CopyOnWriteArrayList<>();
    
    // 강퇴 이벤트를 위한 SseEmitter
    private final Map<String, SseEmitter> emittersForKick = new ConcurrentHashMap<String, SseEmitter>();

    
    // 연결 처리 메서드 - 메세지, 유저리스트, 공지사항
    public SseEmitter connectAll() {
        SseEmitter emitter = new SseEmitter(3600000L); // 1시간 제한
        emittersForAll.add(emitter);

        emitter.onCompletion(() -> emittersForAll.remove(emitter));
        emitter.onTimeout(() -> emittersForAll.remove(emitter));

        return emitter;
    }

    // 연결 처리 메서드 - 강퇴 알림
    public SseEmitter connectKick(String userId) {
        SseEmitter emitter = new SseEmitter(3600000L); // 1시간 제한
        emittersForKick.put(userId, emitter); // userId와 emitter를 맵에 추가

        emitter.onCompletion(() -> emittersForKick.remove(userId)); // 연결이 완료되면 제거
        emitter.onTimeout(() -> emittersForKick.remove(userId)); // 타임아웃 시 제거

        return emitter;
    }

    // 새로고침 알림을 모든 사용자에게 전송
    public void notifyAllUsersToReload() {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("reload").data("reload"));
            } catch (Exception e) {
            	emittersForAll.remove(emitter);  // 오류 발생 시 해당 emitter 제거
            }
        }
    }
    
    // 메세지 모든 클라이언트에게 전송
    public void sendMessageToAll(String message) {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("newMessage").data(message));
            } catch (Exception e) {
                emittersForAll.remove(emitter);
            }
        }
    }

 	// 공지사항 업데이트 시 모든 클라이언트에게 전송
    public void sendNoticeUpdate(String updatedNotice) {
        for (SseEmitter emitter : emittersForAll) {
            try {
                emitter.send(SseEmitter.event().name("noticeUpdate").data(updatedNotice));
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
    public void updateRoom(Map<String, String> params) {
    	for (SseEmitter emitter : emittersForAll) {
    		try {
    			emitter.send(SseEmitter.event().name("updateRoom").data(params));
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

//    // 강퇴된 사용자에게 알림을 전송
//    public void notifyKick(String userId) {
//        SseEmitter emitter = emittersForKick.get(userId); // 해당 사용자에 대한 emitter를 찾음
//        if (emitter != null) {
//            try {
//                emitter.send(SseEmitter.event().name("kick").data(userId + "씨는 강퇴야"));
//
//            } catch (Exception e) {
//                emittersForKick.remove(userId); // 전송 실패 시 해당 emitter 제거
//            }
//        }
//    }
    	public void notifyKick(String userId) {
    	// 강퇴된 사용자에게 알림 전송
        SseEmitter emitterForKickedUser = emittersForKick.get(userId); 
        if (emitterForKickedUser != null) {
            try {
                // 강퇴된 사용자에게 알림 전송
                emitterForKickedUser.send(SseEmitter.event().name("kick").data(userId + "씨는 강퇴되었습니다."));
            } catch (Exception e) {
                emittersForKick.remove(userId); // 전송 실패 시 해당 emitter 제거
            }
        }

        // 다른 사용자들에게 새로고침 알림 전송
        for (SseEmitter emitter : emittersForAll) {
            try {
                // 강퇴된 사용자 외의 모든 사용자에게 새로고침 알림 전송
                emitter.send(SseEmitter.event().name("reload").data("강퇴된 사용자에게 알림이 갱신되었습니다."));
            } catch (Exception e) {
                emittersForAll.remove(emitter); // 오류 발생 시 해당 emitter 제거
            }
        }
    }
    
}


