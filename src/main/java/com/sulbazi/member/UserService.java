package com.sulbazi.member;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

import com.sulbazi.category.CategoryService;
import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;
import com.sulbazi.main.MainDAO;
import com.sulbazi.photo.PhotoDTO;

@Service
public class UserService {
	@Autowired UserDAO user_dao;
	@Autowired CategoryService category_ser;
	@Autowired ChatRoomService chatroom_ser;
	@Autowired MainDAO main_dao;
	Logger log = LoggerFactory.getLogger(getClass());
	@Value("${upload.path}") private String bpath;
	
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

	public int overlay(String user_nickname) {
		return user_dao.overlay(user_nickname);
	}

	public void userMyChat(String user_id, Model model) {
		UserDTO userDto = user_dao.getUserInfo(user_id);
	    model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList);
		List<UserChatroomDTO> userchatList = chatroom_ser.myroomlist(user_id);
		model.addAttribute("chatRoom", userchatList);
	}

	public void userReview(String user_id, Model model) {
		UserDTO userDto = user_dao.getUserInfo(user_id);
	    model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList);
		
	}

	public void userBookmark(String user_id, Model model) {
		UserDTO userDto = user_dao.getUserInfo(user_id);
	    model.addAttribute("info", userDto);
		List<UserDTO> userList = user_dao.files(user_id);
		model.addAttribute("files", userList);
		List<BookMarkDTO> bookList = user_dao.userBookmark(user_id);
		Map<Integer, StoreDTO> store = new HashMap<Integer, StoreDTO>();
		for (BookMarkDTO bmDto : bookList) {
			int store_idx = bmDto.getStore_idx();
			StoreDTO storeDto = main_dao.storeInfo(store_idx);
			store.put(store_idx, storeDto);
		}
		model.addAttribute("storeInfo", store);
		model.addAttribute("bookmark", bookList);
		 
		
	}
}
