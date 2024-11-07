package com.sulbazi.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
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
	public String userReviewGo(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userReviewGo(userId, model);
		return "user/userReview";
	}
	@GetMapping(value="/userReview.ajax")
	@ResponseBody
	public Map<String, Object> userReview(String user_id, String cnt, String page) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return user_ser.userReview(user_id, cnt_, page_);
	}
	@RequestMapping(value="/MyBookmark.go")
	public String MyBookmark(String user_id, Model model, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user_ser.userBookmark(userId, model);
		return "user/MyBookmark";
	} 
    @RequestMapping(value="/userAlarm.go")
    public String useralarm() {
    	return "user/userAlarm";
    }
    

    @GetMapping(value="/userPopup.go")
    public String userDetail(String user_nickname, Model model) {
       log.info("가져온 유저 idx : " + user_nickname);
       Map<String, Object> response = user_ser.userDetail(user_nickname);
       model.addAttribute("info", response.get("info"));
       model.addAttribute("category", response.get("category"));
       return "user/userPopup";
    }
    //유저 아이콘 이미지 불러오는 함수
    @GetMapping(value = "userLikeFind.ajax")
    @ResponseBody
    public Map<String, Object> userLike(@RequestParam Map<String, Object> params) {
    	int row = user_ser.userLike(params);
    	if (row == 0) {
    	    row = 0; // 혹은 다른 기본 값으로 설정
    	}
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("success", row);
    	
    	return map;
    }
    
    //유저 좋아요 눌럿을때 나오는 함수
    @GetMapping(value = "insertLike.ajax")
    @ResponseBody
    public Map<String, Object> insertLike(@RequestParam Map<String, Object> params) {
    	int row = user_ser.insertLike(params);
    	System.out.println("이종원 유저좋아요 확인 : "+params.get("userId"));
    	System.out.println("이종원 유저좋아요 확인 로그인: "+params.get("loginId"));
    	if (row == 0) {
    	    row = 0; // 혹은 다른 기본 값으로 설정
    	}
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("success", row);
    	
    	return map;
    }
    //유저 좋아요 눌럿을때 나오는 함수2
    @PostMapping(value = "profile2.ajax")
    @ResponseBody
    public Map<String, Object> profile2(@RequestParam Map<String, Object> params) {
    	int row = user_ser.insertLike(params);
    	System.out.println("이종원 유저좋아요 확인 : "+params.get("userId"));
    	System.out.println("이종원 유저좋아요 확인 로그인: "+params.get("loginId"));
    	if (row == 0) {
    		row = 0; // 혹은 다른 기본 값으로 설정
    	}
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("success", row);
    	
    	return map;
    }

    
    //종원 유저 찾기
    @PostMapping(value="/letItgo.ajax")
    @ResponseBody
    public Map<String, Object> userGetDO(@RequestParam Map<String, Object> params){
    	UserDTO user = user_ser.letItgo(params);
    	int userLike = user_ser.userLike(params);
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("user", user);
    		map.put("userLike", userLike);
    	return map;
    }
    
	
}
