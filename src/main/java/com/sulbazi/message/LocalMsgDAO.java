package com.sulbazi.message;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LocalMsgDAO {

	String localreportedIdx(int reported_idx);

}
