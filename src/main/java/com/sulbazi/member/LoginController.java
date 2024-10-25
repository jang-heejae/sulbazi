package com.sulbazi.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@Autowired LoginService login_ser;
	
	@RequestMapping(value="/login.go")
	public String login() {
		return "member/login";
	}
	
	@PostMapping(value="/login.do")
	public String login(HttpServletRequest req, Model model, HttpSession session) {
		String page = "";
		String msg = "아이디, 비밀번호를 확인하세요.";
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String opt = req.getParameter("option");
		if(login_ser.login(id, pw, opt).equals("user")) {
			session.setAttribute("loginId", id);
			session.setAttribute("opt", opt);
			page = "redirect:/main.go";
		}else if(login_ser.login(id, pw, opt).equals("store")) {
			session.setAttribute("loginId", id);
			session.setAttribute("opt", opt);
			page = "redirect:/storeMain.go";
		}else if(login_ser.login(id, pw, opt).equals("admin")) {
			session.setAttribute("loginId", id);
			session.setAttribute("opt", opt);
			page = "redirect:/adminMain.go";
		}
		model.addAttribute("msg", msg);
		return page;
	}
	@RequestMapping(value="/logout.go")
	public String logout(Model model, HttpSession session) {
		session.removeAttribute("loginId");
		model.addAttribute("result", "로그아웃 되었습니다.");
		return "redirect:/main.go";
	}
}
