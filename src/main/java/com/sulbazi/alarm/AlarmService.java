package com.sulbazi.alarm;

<<<<<<< HEAD
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

=======
>>>>>>> origin/master
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;

@Service
public class AlarmService {

<<<<<<< HEAD
	
	@Autowired AlarmDAO alarm_dao;
	
	
	Logger logger = LoggerFactory.getLogger(getClass());

	//즐겨찾기 매장 홍보게시물 알림
	public void bookmarknew() {
		
		
	}
	
	//대화방 강제 퇴장 당함 알림
	public Map<String, String> chatroomout(String chatroomboss,String my_id) {
		logger.info(chatroomboss);
		logger.info(my_id);
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();//대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(my_id);
		//수정 필요(아마도)
		Map<String, String> chatroom = new HashMap<String, String>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO kickalarm = alarm_dao.categoryalarminfo(2); //강퇴알림 전체
			String alarm = kickalarm.getAlarm_content(); //강퇴알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(2);
			insertalarm.setUser_id(my_id);
			alarm_dao.alarminsert(insertalarm);
			chatroom.put("chatroomname", chatroomname);
			chatroom.put("alarm", alarm);
			
		}
		return chatroom;
	}

    
    
	//대화방 거절 당함 알림
	public Map<String, String> chatroomdeny(String chatroomboss, String my_id) {
		logger.info(chatroomboss);
		logger.info(my_id);
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);
		int chatroom_idx = userchatroomdto.getUserchat_idx();//대화방 idx
		logger.info(""+chatroom_idx);
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(my_id);
		//수정 필요(아마도)
		Map<String, String> chatroom = new HashMap<String, String>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO denyalarm = alarm_dao.categoryalarminfo(3); //거절알림 전체
			String alarm = denyalarm.getAlarm_content(); //거절알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(3);
			insertalarm.setUser_id(my_id);
			alarm_dao.alarminsert(insertalarm);
			chatroom.put("chatroomname", chatroomname);
			chatroom.put("alarm", alarm);	
		}
		return chatroom;
	}
	
	
	//대화방 참여 수락되었을때 알림
	public Map<String, String> chatroomin(String chatroomboss,String my_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(my_id); //신청자 id
		partidto.setParti_state(1); //참여 상태
		Map<String, String> chatroom = new HashMap<String, String>();
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 1이라면 
			AlarmCategoryDTO chatinalarm = alarm_dao.categoryalarminfo(5);
			String alarm = chatinalarm.getAlarm_content();
			String chatroomname = userchatroomdto.getUserchat_subject();
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(5);
			insertalarm.setUser_id(my_id);
			alarm_dao.alarminsert(insertalarm);
			chatroom.put("alarm", alarm);
			chatroom.put("chatroomname", chatroomname);
			
		}
		return chatroom;
	}
	
	
	//내 대화방 참여 수락/거절 선택 알림
	public Map<String, String> chatroommanager(String user_id, String my_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(my_id);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(user_id); //신청자 id
		partidto.setParti_state(0); //참여 상태
		Map<String, String> chatroom = new HashMap<String, String>();
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 0이라면 
			AlarmCategoryDTO choosealarm = alarm_dao.categoryalarminfo(1);
			String alarm = choosealarm.getAlarm_content();
			String chatroomname = userchatroomdto.getUserchat_subject();
			AlamDTO insertalarm = new AlamDTO();
			insertalarm.setAlarm_category_idx(1);
			insertalarm.setUser_id(my_id);
			alarm_dao.alarminsert(insertalarm);
			chatroom.put("alarm", alarm);
			chatroom.put("chatroomname", chatroomname);
			
		}
		return chatroom;
	}
	
	// 관리자(문의 답변) 알림
	public Map<String, String> inquiryanswer(int inquery_idx) {
		Map<String, String> inqueryanswer = new HashMap<String, String>();
		InqueryDTO answerinquery = alarm_dao.inquiryinfoidx(inquery_idx);
		String inquerysubject = answerinquery.getInquery_subject();
		if(alarm_dao.inquiryinfoidx(inquery_idx) != null) {
		AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(6);
		String inqueryalarm = alarm.getAlarm_content();

		inqueryanswer.put("inquerysubject", inquerysubject) ;
		inqueryanswer.put("inqueryalarm", inqueryalarm) ;
		}
		return inqueryanswer;
	}



	
=======
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AlarmDAO alarm_dao;
	
	public void partialarm(String id) {
		alarm_dao.partialarm(id);		
	}

>>>>>>> origin/master
}

