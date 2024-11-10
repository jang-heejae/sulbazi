package com.sulbazi.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;
 
@Controller
public class MainController {
	@Autowired MainService main_ser;
	@Autowired ChatRoomService chatroom_ser;
	
	@RequestMapping(value={"/", "/main.go", "/mainPage.go"})
	public String userMainPage(Model model, HttpSession session) {
		
		String user_id = (String) session.getAttribute("loginId");
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.myroomlist(user_id);
		model.addAttribute("listroom", userchat_list);
		
		return "main/mainPage";
	}
	@RequestMapping(value="/storeMain.go")
	public String storeMainPage() {
		return "main/storeMainPage";
	}
	@RequestMapping(value="/adminMain.go")
	public String adminMainPage() {
		return "main/adminMainPage";
	}
	
	@GetMapping(value="/main.ajax")
	@ResponseBody
	public Map<String, Object> mainPage() {
		return main_ser.mainPage();
	}

}
