package com.sulbazi.alarm;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.chat.PartiDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.inquery.InqueryDTO;
import com.sulbazi.member.BookMarkDTO;

@Mapper
public interface AlarmDAO {


	UserChatroomDTO userchatroominfo(String chatroomboss);

	PartiDTO partiinfo(PartiDTO partidto);

	AlarmCategoryDTO categoryalarminfo(int i);

	PartiDTO partiexist(PartiDTO partidto);

	InqueryDTO inquiryinfoidx(int inquery_idx);

	UserChatroomDTO userchatroominfoidx(int chatroom_idx);


	
	// 강퇴 알림
	int kickuser(Map<String, String> params);

	int alarminsert(AlamDTO insertalarm);

	int readalarm(int alarm_idx);

	BoardDTO storeboardinfo();

	BookMarkDTO bookmarkinfo(String user_id);

	String storename(int storeidx);

}

