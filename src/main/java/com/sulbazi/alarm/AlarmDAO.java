package com.sulbazi.alarm;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;

@Mapper
public interface AlarmDAO {

<<<<<<< HEAD
	UserChatroomDTO userchatroominfo(String chatroomboss);

	PartiDTO partiinfo(PartiDTO partidto);

	AlarmCategoryDTO categoryalarminfo(int i);

	PartiDTO partiexist(PartiDTO partidto);

	int alarminsert(String user_id, int alarm_category_idx);

	InqueryDTO inquiryinfoidx(int inquery_idx);

	UserChatroomDTO userchatroominfoidx(int chatroom_idx);
	

}
=======
	// 채팅방 참여신청 알림
	int partialarm(String id);
	
	// 강퇴 알림
	int kickuser(Map<String, String> params);

}
>>>>>>> origin/master
