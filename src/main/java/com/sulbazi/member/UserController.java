package com.sulbazi.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserController {
	@Autowired UserService user_ser;
	Logger log = LoggerFactory.getLogger(getClass());
	
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
		log.info("upCntrl param{}:",param);
		log.info("upCntrl files{}:",files);
        return "redirect:/userMyPage.go?user_id=" + param.get("user_id");
	}
	@GetMapping("/overlay.ajax")
	@ResponseBody
	public Map<String, Object> overlay(String user_nickname) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("overlay", user_ser.overlay(user_nickname));
	    return map;
	}
	@RequestMapping(value="/userMyChat.go")
	public String userMyChat(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userMyChat(userId, model);
		return "user/userMyChat";
	}
	@RequestMapping(value="/userReview.go")
	public String userReview(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userReview(userId, model);
		return "user/userReview";
	}
	@RequestMapping(value="/Mybookmark.go")
	public String MyBookmark(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userBookmark(userId, model);
		return "user/userReview";
	} 
    @RequestMapping(value="/userAlarm.go")
    public String useralarm() {
    	return "user/userAlarm";
    }
	
}
