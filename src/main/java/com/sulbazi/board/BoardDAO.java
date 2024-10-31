package com.sulbazi.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {


	List<HashMap<String, Object>> boardlistgo();

	int count(int cnt);

	BoardDTO detail(String board_idx);

	boolean isLiked(BoardLikeDTO likeDTO);

	void deleteLike(BoardLikeDTO likeDTO);

	void insertLike(BoardLikeDTO likeDTO);

	int getstore_idx(String store_id);

	boolean boardWriteajax(BoardDTO boardDTO);

	String selectidx(int store_idx);

	boolean updateajax(BoardDTO boardDTO);

	int bHit(String board_idx);

	int del(String board_idx);




}
