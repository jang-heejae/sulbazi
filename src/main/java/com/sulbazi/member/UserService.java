package com.sulbazi.member;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.CategoryDAO;
import com.sulbazi.category.CategoryService;
import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.main.MainDAO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;
import com.sulbazi.review.ReviewDAO;
import com.sulbazi.review.ReviewDTO;

@Service
public class UserService {
	@Autowired UserDAO user_dao;
	@Autowired CategoryService category_ser;
	@Autowired ChatRoomService chatroom_ser;
	@Autowired MainDAO main_dao;
	@Autowired PhotoService photo_ser;
	@Autowired ReviewDAO review_dao;
	Logger log = LoggerFactory.getLogger(getClass());
	@Autowired CategoryDAO category_dao;
	@Value("${upload.path}") private String bpath;
	
	// 일반 회원 마이페이지
	public void userMyPage(String userId, Model model) {
	    UserDTO userDto = user_dao.getUserInfo(userId);
	    model.addAttribute("info", userDto);
	    
	    List<HashMap<String, Object>> allCategories = user_dao.getAllCategories();
	    model.addAttribute("allCategories", allCategories);
	    
        List<HashMap<String, Object>> userCategories  = user_dao.getUserCategories(userId);
        model.addAttribute("categories", userCategories);

	    List<UserDTO> files = user_dao.files(userId);
	    model.addAttribute("files", files);
	}
	// 일반 회원 마이페이지 정보 수정
	@Transactional
	public UserDTO userUpdate(Map<String, String> param, MultipartFile files) {
	    UserDTO userDTO = new UserDTO();
	    userDTO.setUser_id(param.get("user_id"));
	    userDTO.setUser_pw(param.get("user_pw"));
	    userDTO.setUser_nickname(param.get("user_nickname"));
	    userDTO.setUser_phone(param.get("user_phone"));
	    log.info("userDTO :"+userDTO);
	    String photo = "";
	    try {
	        if (files != null && !files.isEmpty()) {
	            String ori = files.getOriginalFilename();
	            int ext = ori.lastIndexOf(".");
	            String extt = ori.substring(ext);
	            photo = UUID.randomUUID() + extt;
	            Path path = Paths.get(bpath + photo);
	            byte[] arr = files.getBytes();
	            Files.write(path, arr);
	            userDTO.setUser_photo(photo);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    user_dao.userUpdate(userDTO);
	    category_ser.userUpdate(param, userDTO.getUser_id());
	    log.info("upSer param :"+param);
	    log.info("upSer user_id :"+userDTO.getUser_id());
	    return userDTO;
	}
	// 닉네임 중복체크
	public int overlay(String user_nickname) {
		return user_dao.overlay(user_nickname);
	}
	// 일반 회원 나의 채팅방
	public void userMyChat(String user_id, Model model) {
		UserDTO userDto = user_dao.getUserInfo(user_id);
	    model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList);
		List<UserChatroomDTO> userchatList = chatroom_ser.myroomlist(user_id);
		model.addAttribute("chatRoom", userchatList);
	}
	
	// 일반 회원 나의 리뷰
	public void userReviewGo(String user_id, Model model) { 
		UserDTO userDto = user_dao.getUserInfo(user_id);
		model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList); 
	}
	public Map<String, Object> userReview(String user_id, int cnt, int page) {
		int limit = cnt;
		int offset = (page -1) * cnt;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("user_id", user_id);
		param.put("cnt", cnt);
		param.put("limit", limit);
		param.put("offset", offset);
		int totalPages = review_dao.allCount(param);
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReviewDTO> review = review_dao.userReview(param);
		map.put("totalPages", totalPages);
		map.put("list", review);
		return map;
	}

	
	 
	// 일반 회원 즐겨찾기 한 매장
	public void userBookmark(String user_id, Model model) {
		UserDTO userDto = user_dao.getUserInfo(user_id);
	    model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList);
		
		List<BookMarkDTO> bookList = user_dao.userBookmark(user_id);
		log.info("bookList: {}", bookList);
		List<StoreDTO> storeList = new ArrayList<StoreDTO>();
		Map<Integer, PhotoDTO> photo = new HashMap<Integer, PhotoDTO>();
		Map<Integer, List<String>> storeOpt = new HashMap<Integer, List<String>>();
		for (BookMarkDTO bmDto : bookList) {
			int store_idx = bmDto.getStore_idx();
			log.info("store_idx: {}"+ store_idx);
			StoreDTO storeDto = main_dao.storeInfo(store_idx);
			storeList.add(storeDto);
			PhotoDTO photoDto = photo_ser.mainStore(store_idx);
			photo.put(store_idx, photoDto);
		}
		List<Map<String, Object>> optName = user_dao.storeOptName(user_id);
		for (Map<String, Object> map : optName) {
			int store_idx = (int) map.get("store_idx");
			String opt_name = (String) map.get("opt_name");
			storeOpt.computeIfAbsent(store_idx, k -> new ArrayList<>()).add(opt_name);
		}
		model.addAttribute("storeOpt", storeOpt);
		model.addAttribute("storePhoto", photo);
		model.addAttribute("storeInfo", storeList);
	}
	
	// 채팅 기능
	// 채팅방 주인(닉네임, 사진)
	public UserDTO user(String user_id) {
		return user_dao.user(user_id);
	}
	// 유저 상세보기
	public Map<String, Object> userDetail(String user_nickname) {
	      Map<String, Object> response = new HashMap<String, Object>();
	      UserDTO userdto = user_dao.userDetail(user_nickname);
	      log.info("userDetail : {}", userdto);
	      response.put("info", userdto);
	      
	      String user_id = userdto.getUser_id();
	      log.info("user_id : " + user_id);
	      
	      List<HashMap<String, Object>> optList = user_dao.getUserCategories(user_id);
	      List<Integer> optIdxList = new ArrayList<Integer>();
	      
	      for(HashMap<String, Object> opt : optList) {
	         optIdxList.add((Integer) opt.get("opt_idx"));
	      }
	      

	      List<HashMap<String, Object>> category = user_dao.userGetCategory(optIdxList);
	      log.info("가져온 카테고리 번호 : {} ", category);
	      response.put("category", category);
	      
	      return response;
	   }
	
	
	//나의 알림 리스트
	public void userAlarmgo(String user_id, Model model) { 
		UserDTO userDto = user_dao.getUserInfo(user_id);
		model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList); 
	}
	
	//좋아요 눌럿는지 찾아보는 메서드
	public int userLike(Map<String, Object> params) {
		
		return user_dao.userLike(params);
	}
	//좋아요 누르는 메서드
	public int insertLike(Map<String, Object> params) {
			int row  = user_dao.userLike(params);
		if (row >=1) {
			int sow = user_dao.userLikeDel(params);
		}else {
			int dow = user_dao.insertLike(params);
		//유저테이블 업데이트 총 라이크 수
		}
		int how = user_dao.userUpdateLike(params);
		return row;
	}
	public UserDTO letItgo(Map<String, Object> params) {
		
		return user_dao.letItgo(params);
	}
	public int gogoLike(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return user_dao.gogoLike(params);
	}
}
