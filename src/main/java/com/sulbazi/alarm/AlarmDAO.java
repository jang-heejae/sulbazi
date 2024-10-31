package com.sulbazi.alarm;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;

@Mapper
public interface AlarmDAO {

	UserChatroomDTO userchatroominfo(String chatroomboss);

	PartiDTO partiinfo(PartiDTO partidto);

	AlarmCategoryDTO categoryalarminfo(int i);

	PartiDTO partiexist(PartiDTO partidto);

	int alarminsert(String user_id, int alarm_category_idx);

	InqueryDTO inquiryinfoidx(int inquery_idx);

	UserChatroomDTO userchatroominfoidx(int chatroom_idx);
	

}