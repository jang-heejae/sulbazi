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
	    String loginResult = login_ser.login(id, pw, opt);
	    if (loginResult.equals("user") || loginResult.equals("store") || loginResult.equals("admin")) {
	        if (userRevoke(id, opt)) { 
	            msg = "이용이 제한되었습니다.";
	            page = "redirect:/revokeLogin.go";
	        } else {
	            session.setAttribute("loginId", id);
	            session.setAttribute("opt", opt);
	            if (loginResult.equals("user")) {
	                page = "redirect:/main.go";
	            } else if (loginResult.equals("store")) {
	                page = "redirect:/storeMain.go";
	            } else if (loginResult.equals("admin")) {
	                page = "redirect:/adminMain.go";
	            }
	        }
	    }
	    model.addAttribute("msg", msg);
	    return page;
	}
	private boolean userRevoke(String id, String opt) {
	    return login_ser.userRevoke(id, opt);
	}
	@RequestMapping(value="/revokeLogin.go")
	public String revokeLogin() {
		return "member/revokeLogin";
	}
	@RequestMapping(value="/logout.go")
	public String logout(Model model, HttpSession session) {
		session.removeAttribute("loginId");
		model.addAttribute("result", "로그아웃 되었습니다.");
		return "redirect:/main.go";
	}
}
