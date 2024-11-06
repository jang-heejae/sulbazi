package com.sulbazi.main;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;
 
@Controller
public class MainController {
	@Autowired MainService main_ser;
	@Autowired ChatRoomService chatroom_ser;
	
	@RequestMapping(value={"/", "/main.go", "/mainPage.go"})
	public String mainPage(Model model, HttpSession session) {
		
		String user_id = (String) session.getAttribute("loginId");
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.myroomlist(user_id);
		model.addAttribute("list", userchat_list);

		main_ser.mainPage(model);
		return "main/mainPage";
	}
	@RequestMapping(value="/storeMain.go")
	public String storeMainPage(Model model) {
		main_ser.mainPage(model);
		return "main/storeMainPage";
	}
	@RequestMapping(value="/adminMain.go")
	public String adminMainPage(Model model) {
		main_ser.mainPage(model);
		return "main/adminMainPage";
	}
	

}
