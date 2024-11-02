package com.sulbazi.main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.UserDTO;

@Mapper
public interface MainDAO { 
 
	List<StoreDTO> mainStore();

	List<UserChatroomDTO> mainChat();

	UserDTO profile(String user_id);

	List<BoardDTO> mainBoard();

	StoreDTO storeInfo(int store_idx);

}
