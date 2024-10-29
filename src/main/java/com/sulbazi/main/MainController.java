package com.sulbazi.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping(value={"/", "/main.go"})
	public String main() {
		return "main/main";
	}
	@RequestMapping(value="/mainPage.go")
	public String mainPage() {
		return "main/mainPage";
	}
	@RequestMapping(value="/adminMain.go")
	public String admin() {
		return "main/adminMainPage";
	}
}
