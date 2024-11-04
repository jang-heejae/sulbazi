package com.sulbazi.alarm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.chat.ChatPartiDAO;
import com.sulbazi.chat.ChatRoomDAO;
import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;
import com.sulbazi.member.BookMarkDTO;

@Service
public class AlarmService {

	
	@Autowired AlarmDAO alarm_dao;
	@Autowired ChatPartiDAO chatparti_dao;
	@Autowired ChatRoomDAO chatroom_dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());


	
	//결국 sse
    private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();

    public SseEmitter connect(String userId) {
        SseEmitter emitter = new SseEmitter();
        emitters.put(userId, emitter);

        emitter.onCompletion(() -> emitters.remove(userId));
        emitter.onTimeout(() -> emitters.remove(userId));

        return emitter;
    }

    public void sendNotification(String userId, Map<String, Object> notification) {
        SseEmitter emitter = emitters.get(userId);
        if (emitter != null) {
            try {
                emitter.send(notification);
            } catch (Exception e) {
                emitters.remove(userId);
            }
        }
    }


	//즐겨찾기 매장 홍보게시물 알림
	public Map<String, Object> bookmarknew(String user_id) {
		logger.info("내 id"+user_id);
		BoardDTO boarddto = alarm_dao.storeboardinfo(); //매장 새 게시물 정보
		int storeboardidx = boarddto.getStore_idx(); //게시물 매장 idx
		logger.info("게시물매장idx:"+storeboardidx);
		List<BookMarkDTO> bookmarks =alarm_dao.bookmarkinfo(user_id); // 나의 북마크 목록
		Map<String, Object> chatroom = new HashMap<String, Object>();
		for (BookMarkDTO bookmark : bookmarks) {
			int storeidx = bookmark.getStore_idx(); //즐겨찾기 매장 idx 리스트
			String storename = alarm_dao.storename(storeidx); //매장 이름
			logger.info("즐찾매장idx:"+storeidx);
			if(storeboardidx == storeidx) {
				AlarmCategoryDTO bookmarkalarm = alarm_dao.categoryalarminfo(4);
				String alarm = bookmarkalarm.getAlarm_content();
				AlamDTO insertalarm = new AlamDTO();
				insertalarm.setAlarm_category_idx(4);
				insertalarm.setUser_id(user_id);
				insertalarm.setAlarm_subject(storename);
				alarm_dao.alarminsert(insertalarm);
				int alarm_idx= insertalarm.getAlarm_idx();
				chatroom.put("alarm_idx", alarm_idx); //알림 idx
				chatroom.put("chatroomname", storename); //게시판 제목
				chatroom.put("alarm", alarm); //알림 내용
			}
		}
		return chatroom;
	}
	
	
	
	//대화방 강제 퇴장 당함 알림
	public Map<String, Object> chatroomout(String chatroomboss,String my_id) {
		logger.info(chatroomboss);
		logger.info(my_id);
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();//대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(my_id);
		//수정 필요(아마도)
		Map<String, Object> chatroom = new HashMap<String, Object>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO kickalarm = alarm_dao.categoryalarminfo(2); //강퇴알림 전체
			String alarm = kickalarm.getAlarm_content(); //강퇴알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(2);
			insertalarm.setUser_id(my_id);
			insertalarm.setAlarm_subject(chatroomname);
			alarm_dao.alarminsert(insertalarm);
			int alarm_idx= insertalarm.getAlarm_idx();
			chatroom.put("alarm_idx", alarm_idx);
			chatroom.put("chatroomname", chatroomname);
			chatroom.put("alarm", alarm);
			
		}
		return chatroom;
	}

    
    
	//대화방 거절 당함 알림
	public Map<String, Object> chatroomdeny(String chatroomboss, String my_id) {
		logger.info(chatroomboss);
		logger.info(my_id);
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);
		int chatroom_idx = userchatroomdto.getUserchat_idx();//대화방 idx
		logger.info(""+chatroom_idx);
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(my_id);
		
		// 거절되면 parti 테이블에서 삭제
		chatparti_dao.handleDeny(chatroom_idx,my_id);
		
		//수정 필요(아마도)
		Map<String, Object> chatroom = new HashMap<String, Object>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO denyalarm = alarm_dao.categoryalarminfo(3); //거절알림 전체
			String alarm = denyalarm.getAlarm_content(); //거절알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(3);
			insertalarm.setUser_id(my_id);
			insertalarm.setAlarm_subject(chatroomname);
			alarm_dao.alarminsert(insertalarm);
			int alarm_idx= insertalarm.getAlarm_idx();
			chatroom.put("alarm_idx", alarm_idx);
			chatroom.put("chatroomname", chatroomname);
			chatroom.put("alarm", alarm);	
		}
		return chatroom;
	}
	
	
	//대화방 참여 수락되었을때 알림
	public Map<String, Object> chatroomin(String chatroomboss,String my_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(my_id); //신청자 id
		partidto.setParti_state(1); //참여 상태
		
		int roomidx = partidto.getChatroom_idx();
		String user_id = partidto.getUser_id();
		
		// 수락되면 parti 테이블 state = 1 하고 userchat 테이블에 +parti 테이블 count
		chatparti_dao.handleAccept(roomidx,user_id);
		Integer total = chatparti_dao.usertotal(roomidx);
		chatroom_dao.roomin(total,roomidx);
		
		Map<String, Object> chatroom = new HashMap<String, Object>();
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 1이라면 
			AlarmCategoryDTO chatinalarm = alarm_dao.categoryalarminfo(5);
			String alarm = chatinalarm.getAlarm_content();
			String chatroomname = userchatroomdto.getUserchat_subject();
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(5);
			insertalarm.setUser_id(my_id);
			insertalarm.setAlarm_subject(chatroomname);
			alarm_dao.alarminsert(insertalarm);
			int alarm_idx= insertalarm.getAlarm_idx();
			chatroom.put("alarm_idx", alarm_idx);
			chatroom.put("alarm", alarm);
			chatroom.put("chatroomname", chatroomname);
			
		}
		return chatroom;
	}
	
	
	//내 대화방 참여 수락/거절 선택 알림
	public Map<String, Object> chatroommanager(String getuser_id, String user_id) {
		logger.info("발신자:"+user_id);
		logger.info("방장:"+getuser_id);
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(getuser_id);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		logger.info("chatroom_idx:"+chatroom_idx);
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(user_id); //신청자 id
		partidto.setParti_state(0); //참여 상태
		logger.info("참여신청 대화방 : {}"+partidto.getChatroom_idx());
		logger.info("참여 희망자 : {}"+partidto.getUser_id());
		logger.info("참여 상태 : {}"+partidto.getParti_state());

		logger.info("참여 상태 : {}"+partidto);
		Map<String, Object> chatroom = new HashMap<String, Object>();
		logger.info("partidto : {}"+alarm_dao.partiinfo(partidto));
		
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 0이라면 
			AlarmCategoryDTO choosealarm = alarm_dao.categoryalarminfo(1);
			String alarm = choosealarm.getAlarm_content();
			logger.info("alarm:"+alarm);
			String chatroomname = userchatroomdto.getUserchat_subject();
			logger.info("chatroomname:"+chatroomname);
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(1);
			insertalarm.setUser_id(getuser_id);
			insertalarm.setAlarm_subject(chatroomname);
			alarm_dao.alarminsert(insertalarm);
			insertalarm.getAlarm_idx();
			int alarm_idx= insertalarm.getAlarm_idx();
			chatroom.put("alarm_idx", alarm_idx);
			chatroom.put("alarm", alarm);
			chatroom.put("chatroomname", chatroomname);
			
		}
		return chatroom;
	}
	
	// 관리자(문의 답변) 알림
	public Map<String, Object> inquirynewanswer(int inquery_idx) {
		Map<String, Object> chatroom = new HashMap<String, Object>();
		InqueryDTO answerinquery = alarm_dao.inquiryinfoidx(inquery_idx);
		String inquerysubject = answerinquery.getInquery_subject(); //문의 제목
		String id_write = answerinquery.getId_write(); //문의 작성자 아이디
		if(answerinquery != null) {
		AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(6);
		String inqueryalarm = alarm.getAlarm_content();//알림내용
		AlamDTO insertalarm = new AlamDTO();
		insertalarm.setAlarm_category_idx(6);
		insertalarm.setUser_id(id_write);
		insertalarm.setAlarm_subject(inquerysubject);
		alarm_dao.alarminsert(insertalarm);
		insertalarm.getAlarm_idx();
		int alarm_idx= insertalarm.getAlarm_idx();
		chatroom.put("alarm_idx", alarm_idx);
		chatroom.put("chatroomname", inquerysubject) ;//문의 이름
		chatroom.put("alarm", inqueryalarm) ;//알림 내용
		}
		return chatroom;
	}



	public int readalarm(int alarm_idx) {
		int row = alarm_dao.readalarm(alarm_idx);
		return row;
	}

	//기존 안읽은 알림 가져오기 (페이지 로드시)
	public List<Map<String, Object>> getNotificationsByReceiverId(String receiverId) {
		List<Map<String, Object>> notificationsList = new ArrayList<>(); // 알림을 담을 리스
		List<AlamDTO> alarm_contents = alarm_dao.alarmreadornot(0,receiverId); //안읽은 나의 알림 가져오기
		for (AlamDTO content : alarm_contents) { 
			Map<String, Object> chatroom = new HashMap<String, Object>();
			int alarmcategory = content.getAlarm_category_idx();
			int alarm_idx = content.getAlarm_idx();
			AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(alarmcategory);
			String alarmmsg = alarm.getAlarm_content();
			chatroom.put("alarm", alarmmsg); //알림 내용
			chatroom.put("chatroomname", content.getAlarm_subject()); //알림 위치??어디 알림인지
			chatroom.put("alarm_idx", alarm_idx); //알림 idx
			
			 notificationsList.add(chatroom);
		} 
		return notificationsList; // 모든 알림 리스트 반환
	}

}

