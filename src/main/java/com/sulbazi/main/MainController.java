package com.sulbazi.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class MainController {
	@Autowired MainService main_ser; 
	
	@RequestMapping(value={"/", "/main.go"})
	public String main() {
		return "main/main";
	}
	@RequestMapping(value="/mainPage.go")
	public String mainPage(Model model) {
		return "main/mainPage";
	}
	@RequestMapping(value="/adminMain.go")
	public String admin(Model model) {
		main_ser.mainStore(model);
		return "main/adminMainPage";
	}
	

}
