package com.sulbazi.alarm;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlarmDAO {

	// 채팅방 참여신청 알림
	int partialarm(String id);
	
	// 강퇴 알림
	int kickuser(Map<String, String> params);

}
