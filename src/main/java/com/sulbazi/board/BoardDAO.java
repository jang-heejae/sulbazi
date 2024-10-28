package com.sulbazi.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {


	List<HashMap<String, Object>> boardlistgo();

	int count(int cnt);

	BoardDTO detail(String board_idx);



}
