package com.sulbazi.alarm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;

@Service
public class AlarmService {

	
	@Autowired AlarmDAO alarm_dao;
	

	//즐겨찾기 매장 홍보게시물 알림
	public void bookmarknew() {
		
		
	}
	
	//대화방 강제 퇴장 당함 알림
	public Map<String, String> chatroomout(int chatroom_idx,String user_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfoidx(chatroom_idx);//개설자 대화방 정보
		String chatroomboss = userchatroomdto.getUser_id();//대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(user_id);
		//수정 필요(아마도)
		Map<String, String> chatroomout = new HashMap<String, String>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(2); //강퇴알림 전체
			String kickalarm = alarm.getAlarm_content(); //강퇴알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			alarm_dao.alarminsert(user_id, 2);
			chatroomout.put("chatroomname", chatroomname);
			chatroomout.put("kickalarm", kickalarm);
			
		}
		return chatroomout;
	}

    
    
	//대화방 거절 당함 알림
	public Map<String, String> chatroomdeny(String chatroomboss, String my_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);
		int chatroom_idx = userchatroomdto.getUserchat_idx();//대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx);
		partidto.setUser_id(my_id);
		//수정 필요(아마도)
		Map<String, String> chatroomdeny = new HashMap<String, String>();
		if(alarm_dao.partiexist(partidto) == null) {//존재 유무
			AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(3); //거절알림 전체
			String denyalarm = alarm.getAlarm_content(); //거절알림 내용
			String chatroomname=userchatroomdto.getUserchat_subject();//퇴장 대화방제목
			alarm_dao.alarminsert(my_id, 3);
			chatroomdeny.put("chatroomname", chatroomname);
			chatroomdeny.put("denyalarm", denyalarm);
			
		}
		return chatroomdeny;
	}
	
	
	//대화방 참여 수락되었을때 알림
	public Map<String, String> chatroomin(String chatroomboss,String my_id) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(my_id); //신청자 id
		partidto.setParti_state(1); //참여 상태
		Map<String, String> chatroomin = new HashMap<String, String>();
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 1이라면 
			AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(5);
			String chatin = alarm.getAlarm_content();
			String chatroomname = userchatroomdto.getUserchat_subject();
			alarm_dao.alarminsert(my_id, 5);
			chatroomin.put("chatin", chatin);
			chatroomin.put("chatroomname", chatroomname);
			
		}
		return chatroomin;
	}
	
	
	//내 대화방 참여 수락/거절 선택 알림
	public Map<String, String> chatroommanager(String my_id, String chatroomboss) {
		UserChatroomDTO userchatroomdto = alarm_dao.userchatroominfo(chatroomboss);//개설자 대화방 정보
		int chatroom_idx = userchatroomdto.getUserchat_idx();// 참여신청 대화방 idx
		PartiDTO partidto = new PartiDTO();
		partidto.setChatroom_idx(chatroom_idx); //참여신청 대화방idx
		partidto.setUser_id(my_id); //신청자 id
		partidto.setParti_state(0); //참여 상태
		Map<String, String> chatroomwant = new HashMap<String, String>();
		if(alarm_dao.partiinfo(partidto) != null) { //신청 대화방에서 나의 id가 참여상태 1이라면 
			AlarmCategoryDTO alarm = alarm_dao.categoryalarminfo(1);
			String chatwant = alarm.getAlarm_content();
			String chatroomname = userchatroomdto.getUserchat_subject();
			alarm_dao.alarminsert(my_id, 1);
			chatroomwant.put("chatwant", chatwant);
			chatroomwant.put("chatroomname", chatroomname);
			
		}
		return chatroomwant;
		
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



	
}

