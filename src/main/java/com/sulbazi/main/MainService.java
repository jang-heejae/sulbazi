package com.sulbazi.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.chat.ChatPartiService;
import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.member.StoreDAO;
import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreService;
import com.sulbazi.member.UserDAO;
import com.sulbazi.member.UserDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

@Service
public class MainService {
	@Autowired
	MainDAO main_dao;
	@Autowired
	StoreDAO store_dao;
	@Autowired
	PhotoService photo_ser;
	@Autowired
	StoreService store_ser;
	@Autowired
	ChatRoomService chatroom_ser;
	@Autowired
	ChatPartiService chatparti_ser;
	@Autowired
	UserDAO user_dao;
	Logger log = LoggerFactory.getLogger(getClass());

	/*
	 * public void mainPage(Model model) { List<StoreDTO> storeList =
	 * main_dao.mainStore(); // 상위 4개 store 정보 //log.info("storeList:{}"+storeList);
	 * Map<Integer, PhotoDTO> map = new HashMap<Integer, PhotoDTO>(); // 각 store에 대한
	 * 사진 리스트 추가 for (StoreDTO store : storeList) { PhotoDTO photoDto =
	 * photo_ser.mainStore(store.getStore_idx()); map.put(store.getStore_idx(),
	 * photoDto); //log.info("store_idx:{}"+store.getStore_idx());
	 * //log.info("new_filename:{}"+photoDto.getNew_filename()); }
	 * model.addAttribute("files", map); // store_idx별로 저장하여 JSP에서 사용 가능
	 * model.addAttribute("info", storeList); // 전체 store 정보 추가
	 * 
	 * List<UserChatroomDTO> userchatList = main_dao.mainChat(); Map<String,
	 * UserDTO> profile = new HashMap<String, UserDTO>();// 각 user_id에 맞는 프로필 사진을 담을
	 * 리스트
	 * 
	 * // 2. 각 user_id에 맞는 user_photo 조회 for (UserChatroomDTO ucd : userchatList) {
	 * String user_id = ucd.getUser_id(); UserDTO userProfile =
	 * main_dao.profile(user_id); if (userProfile != null) { profile.put(user_id,
	 * userProfile); //log.info("user_id: {}", user_id);
	 * //log.info("user_photo: {}", userProfile.getUser_photo());
	 * //log.info("user_nickname: {}", userProfile.getUser_nickname()); } }
	 * model.addAttribute("profiles", profile); model.addAttribute("chatRoom",
	 * userchatList);
	 * 
	 * List<BoardDTO> boardList = main_dao.mainBoard(); Map<Integer, StoreDTO> board
	 * = new HashMap<Integer, StoreDTO>();
	 * 
	 * for (BoardDTO boardDTO : boardList) { int store_idx =
	 * boardDTO.getStore_idx(); StoreDTO storeDto = main_dao.storeInfo(store_idx);
	 * board.put(store_idx, storeDto); } model.addAttribute("storeInfo", board);
	 * model.addAttribute("boards", boardList);
	 * 
	 * }
	 */

	public Map<String, Object> mainPage() {
		Map<String, Object> response = new HashMap<>();
		
		List<StoreDTO> storeList = main_dao.mainStore();
		Map<Integer, PhotoDTO> map = new HashMap<Integer, PhotoDTO>(); 
			for (StoreDTO store : storeList) { 
				PhotoDTO photoDto =  photo_ser.mainStore(store.getStore_idx());
				map.put(store.getStore_idx(), photoDto); 
				}

		response.put("files", map);
		response.put("stores", storeList);

		List<UserChatroomDTO> userchatList = main_dao.mainChat();
		Map<String, UserDTO> profile = new HashMap<String, UserDTO>();
		for (UserChatroomDTO ucd : userchatList) {
			String user_id = ucd.getUser_id();
			UserDTO userProfile = main_dao.profile(user_id); 
			if (userProfile != null) {
                profile.put(user_id, userProfile);
            }
		}
		response.put("profiles", profile);
		response.put("chatRooms", userchatList);

		List<BoardDTO> boardList = main_dao.mainBoard();

		Map<Integer, StoreDTO> bstore = new HashMap<Integer, StoreDTO>();
		  for (BoardDTO boardDTO : boardList) { 
			  int store_idx = boardDTO.getStore_idx(); 
			  StoreDTO storeDto = main_dao.storeInfo(store_idx);
			  bstore.put(store_idx, storeDto); 
			  } 
		  response.put("storeInfo", bstore);
		  response.put("boards", boardList);
		
		return response;
	}

}
