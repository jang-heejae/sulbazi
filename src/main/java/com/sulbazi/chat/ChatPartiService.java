package com.sulbazi.chat;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.sulbazi.alarm.AlarmDAO;

@Service
public class ChatPartiService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatPartiDAO chatparti_dao;
	@Autowired AlarmDAO alarm_dao;
	private Map<String, SseEmitter> sseEmitters = new ConcurrentHashMap<String, SseEmitter>();
	
	
	/* 개인 채팅방 참여 */
	public void userparti(String userId, int idx, String id) {
		int row = chatparti_dao.userparti(userId, idx);
		
		if(row>0) {			
			alarm_dao.partialarm(id);
		}
	}
	
	/* 방에 참여중인 총 사용자 */
	public Integer usertotal(int idx) {
		return chatparti_dao.usertotal(idx);
	}
	
	/* 방에 참여중인 사용자 - 개인 */
	public List<PartiDTO> userlist(int idx) {
		return chatparti_dao.userlist(idx);
	}
	public List<PartiDTO> userlistajax(int chatroom_idx) {
		return chatparti_dao.userlistajax(chatroom_idx);
	}
	
	/* 개인 채팅방에서 나가면 참여상태 false */
	public void userroomout(String userId, int chatroom_idx) {
		chatparti_dao.userroomout(userId, chatroom_idx);
	}
	
	/* 개인 채팅방 강퇴 */
	public boolean kickuser(Map<String, String> params) {
		int row = chatparti_dao.kickuser(params);
		
		// 퇴장 시키면 알람보내기
		if(row>0) {
			alarm_dao.kickuser(params);
		}
		return row > 0;
	}
	
	 // SSE 등록 메서드
    public SseEmitter registerSse(String userId) {
        SseEmitter emitter = new SseEmitter();
        sseEmitters.put(userId, emitter);
        emitter.onCompletion(() -> sseEmitters.remove(userId));
        emitter.onTimeout(() -> sseEmitters.remove(userId));
        return emitter;
    }
    
    // 강퇴 알림 메서드
    public void notifyUserOfKick(String userId) {
        SseEmitter emitter = sseEmitters.get(userId);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().name("kick").data("강퇴 당했다~~"));
                emitter.complete();
            } catch (Exception e) {
                emitter.completeWithError(e);
            }
        }
    }
	
	
	
	
	/* 지역 채팅방 참여 */
	public void localparti(String userId, int idx) {
		
		// 이미 insert된 사용자 찾아서 상태 변경 0 -> 1
		int row = chatparti_dao.localreparti(userId, idx);
		
		// 없으면 새로 insert
		if(row == 0) {
			chatparti_dao.insertlocalparti(userId, idx);
		}
	}
	
	/* 방에 참여중인 사용자 - 지역 */
	public List<PartiDTO> localuserlist(int idx) {
		return chatparti_dao.localuserlist(idx);
	}
	public List<PartiDTO> localuserlistajax(int localchat_idx) {
		return chatparti_dao.localuserlistajax(localchat_idx);
	}
	
	/* 지역 채팅방에서 나가면 참여상태 false */
	public void localroomout(String userId, int chatroom_idx) {
		chatparti_dao.localroomout(userId, chatroom_idx);
	}

	

	
	

	






}
