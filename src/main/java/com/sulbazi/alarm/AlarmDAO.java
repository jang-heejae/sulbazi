package com.sulbazi.alarm;

import java.util.List;
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

	// 채팅방 참여신청 알림
	int partialarm(String id);
	
	// 강퇴 알림
	int kickuser(Map<String, String> params);

	int alarminsert(AlamDTO insertalarm);

	int readalarm(int alarm_idx);

	BoardDTO storeboardinfo();

	List<BookMarkDTO> bookmarkinfo(String user_id);

	String storename(int storeidx);

	List<AlamDTO> alarmreadornot(int i, String receiverId);
	
	
}

