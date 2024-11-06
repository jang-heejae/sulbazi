package com.sulbazi.main;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class MainController {
	@Autowired MainService main_ser;
	
	@RequestMapping(value={"/", "/main.go", "/mainPage.go"})
	public String mainPage(Model model, HttpSession session) {
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
