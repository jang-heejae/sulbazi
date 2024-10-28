package com.sulbazi.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
