package com.sulbazi.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@Autowired LoginService login_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	
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
	@RequestMapping(value="/findpw.go")
	public String findpwgo() {
		return "member/findPw";
	}
	
	@PostMapping(value="/userfindpw.do")
	public String userfindpwdo(String id, String email, Model model) {
		logger.info("변경할 비밀번호의 일반 사용자 이름, 이메일 : " + id + email);
		String page = "";
		if (login_ser.userfindpwdo(id, email) != null) {
			model.addAttribute("findtype", "user");
			model.addAttribute("identifier", id);
			page = "member/changePw";
		}else {
			model.addAttribute("msg", "해당 아이디와 이메일로 등록된 비밀번호가 없습니다.");
			page = "member/login";
		}
		return page;
	}
	
	@PostMapping(value="/storefindpw.do")
	public String storefindpwdo(String store_number, Model model) {
		logger.info("변경할 비밀번호의 매장 사용자 사업자 번호 : " + store_number);
		String page = "";
		if (login_ser.storefindpwdo(store_number) != null) {
			model.addAttribute("findtype", "store");
			model.addAttribute("identifier", store_number);
			page = "member/changePw";
		}
		return page;
	}
	
	@PostMapping(value="/changepw.do")
	public String changepwdo(String findtype, String identifier, String newPassword) {
		logger.info("사용자 타입 : " + findtype);
		logger.info("컬럼 : " + identifier);
		logger.info("새 비밀번호 : " + newPassword);
		if (findtype.equals("user")) {
			login_ser.changeuserpw(identifier, newPassword);
		}else if (findtype.equals("store")) {
			login_ser.changestorepw(identifier, newPassword);
		}
		return "member/login";
	}
	
	@RequestMapping(value="/findid.go")
	public String findidgo() {
		return "member/findId";
	}
	
	@PostMapping(value="/userfindid.do")
	public String userfindiddo(String email, Model model) {
		logger.info("확인할 아이디의 일반 사용자 이메일 : " + email);
		String page = "";
		String id = login_ser.userfindiddo(email);
		logger.info("가져온 일반 사용자의 아이디 : " + id);
		if(id != null) {
			model.addAttribute("findtype", "user");
			model.addAttribute("user_id", id);
			page = "member/checkId";
		}else {
			model.addAttribute("msg", "해당 이메일로 등록된 아이디가 없습니다.");
			page = "member/login";
		}
		return page;
	}
	
	@PostMapping(value="/storefindid.do")
	public String storefindiddo(String number, Model model) {
		logger.info("확인할 아이디의 매장 사용자 사업자 번호 : " + number);
		String page = "";
		String sid = login_ser.storefindiddo(number);
		logger.info("가져온 매장 사용자의 아이디 : " + sid);
		if (sid != null) {
			model.addAttribute("findtype", "store");
			model.addAttribute("store_id", sid);
			page = "member/checkId";
		}else {
			model.addAttribute("msg", "해당 사업자 번호로 등록된 아이디가 없습니다.");
			page = "member/login";
		}
		return page;
	}
}
