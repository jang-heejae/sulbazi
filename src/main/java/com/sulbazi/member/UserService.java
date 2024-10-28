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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.CategoryService;

@Service
public class UserService {
	@Autowired UserDAO user_dao;
	@Autowired CategoryService category_ser;
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

	    return userDTO;
	}
}
