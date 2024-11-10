package com.sulbazi.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.StoreDTO;

@Mapper
public interface BoardDAO {

	List<HashMap<String, Object>> boardlistgo(int limit, int offset);
	
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

	List<BoardDTO> getAllcategory();

	int allCount(int cnt_);

	List<BoardDTO> getSearch(String boardCategory, String boardSearch);

	int boardLike(String user_id, int board_idx);

	int boardLikedo(String user_id, int board_idx);

	int boardLikeDel(String user_id, int board_idx);

	int boardCount(int board_idx);

	void boardLikeUpDate(int row, int board_idx);

	StoreDTO storedto(int store_idx);

}
