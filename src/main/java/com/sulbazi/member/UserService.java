package com.sulbazi.member;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class UserService {
	@Autowired UserDAO user_dao;
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

}
