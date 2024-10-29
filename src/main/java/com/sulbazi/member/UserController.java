package com.sulbazi.member;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserController {
	@Autowired UserService user_ser;
	
	@RequestMapping(value="/userMyPage.go")
	public String userMyPage(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userMyPage(userId, model);
		return "user/userMyPage";
	}
	@RequestMapping(value="/userUpdate.go")
	public String userUpdate(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userMyPage(userId, model);
        return "user/userUpdate"; 
	}
	@PostMapping(value="/userUpdate.do")
	public String userUpdate(MultipartFile files, @RequestParam Map<String, String> param) {
		user_ser.userUpdate(param, files);
        return "redirect:/userMyPage.go?user_id=" + param.get("user_id");
	}
	
}
