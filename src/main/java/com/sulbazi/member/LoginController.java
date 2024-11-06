package com.sulbazi.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sulbazi.chat.ChatRoomService;
import com.sulbazi.chat.UserChatroomDTO;

@Controller
public class LoginController {
	@Autowired LoginService login_ser;
	@Autowired ChatRoomService chatroom_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/login.go")
	public String login() {
		return "member/login";
	}
	@PostMapping(value="/login.do")
	public String login(HttpServletRequest req, Model model, HttpSession session) {
	    String page = "redirect:/login.go";
	    String id = req.getParameter("id");
	    String pw = req.getParameter("pw");
	    String ip = req.getRemoteAddr();
	    logger.info("ip 주소"+ip);
	    String opt = req.getParameter("option");
	    
	    String loggedInId = (String) session.getAttribute("loginId");
	    if (loggedInId != null && loggedInId.equals(id)) {
	        session.setAttribute("msg", "이미 로그인된 아이디입니다.");
	        return page;
	    }
	    
	    String loginResult = login_ser.login(id, pw, opt, ip);
	    if (loginResult.equals("user") || loginResult.equals("store") || loginResult.equals("admin")) {
	        if (userRevoke(id, opt)) { 
	        	session.setAttribute("msg", "이용이 제한되었습니다.");
	            page = "redirect:/revokeLogin.go";
	        } else {
	            session.setAttribute("loginId", id);
	            session.setAttribute("opt", opt);
	            if (loginResult.equals("user")) {	        		
	                page = "redirect:/mainPage.go";
	            } else if (loginResult.equals("store")) {
	                page = "redirect:/storeMain.go";
	            } else if (loginResult.equals("admin")) {
	                page = "redirect:/adminMain.go";
	            }
	        }
	    }else {
	    	session.setAttribute("msg", "아이디와 비밀번호를 확인하세요.");
	    }
	    logger.info("로그인 시도 - ID: {}, 옵션: {}, 결과: {}", id, opt, loginResult);
	    logger.info("로그옵션:{}"+ session.getAttribute("opt"));
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
	public String logout(Model model, HttpSession session, HttpServletResponse response) {
	    // 세션에서 로그인 정보 제거
	    session.invalidate(); // 전체 세션 무효화 (또는 removeAttribute 사용)
	    
	    // 캐시 방지 헤더 추가
	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
	    response.setDateHeader("Expires", 0); // Proxies.
	    
	    model.addAttribute("result", "로그아웃 되었습니다.");
	    return "redirect:/main.go";
	}
	@RequestMapping(value="/findpw.go")
	public String findpwgo() {
		return "member/findPw";
	}
	
	@PostMapping(value="/userfindpw.do")
	public String userfindpwdo(String user_id, String user_email, Model model) {
		logger.info("변경할 비밀번호의 일반 사용자 이름, 이메일 : " + user_id + user_email);
		String page = "";
		if (login_ser.userfindpwdo(user_id, user_email) != null) {
			model.addAttribute("findtype", "user");
			model.addAttribute("identifier", user_id);
			page = "member/changePw";
		}else {
			model.addAttribute("msg", "해당 아이디와 이메일로 등록된 비밀번호가 없습니다.");
			page = "member/login";
		}
		return page;
	}
	
	@PostMapping(value="/storefindpw.do")
	public String storefindpwdo(String store_id, String store_number, Model model) {
		logger.info("변경할 비밀번호의 매장 사용자 사업자 번호 : " + store_number);
		String page = "";
		if (login_ser.storefindpwdo(store_id, store_number) != null) {
			model.addAttribute("findtype", "store");
			model.addAttribute("identifier", store_id);
			page = "member/changePw";
		}else {
			model.addAttribute("msg", "해당 아이디와 이메일로 등록된 비밀번호가 없습니다.");
			page = "member/login";
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
