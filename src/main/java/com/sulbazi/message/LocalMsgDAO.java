package com.sulbazi.message;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LocalMsgDAO {

	/* 지역 채팅방 입장 시 해당 방 메세지들 출력 */
	List<LocalMsgDTO> localmsg(int idx);

	String localreportedIdx(int reported_idx);
}
