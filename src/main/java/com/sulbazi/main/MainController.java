package com.sulbazi.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping(value={"/", "/main.go"})
	public String main() {
		return "main/main";
	}
}
