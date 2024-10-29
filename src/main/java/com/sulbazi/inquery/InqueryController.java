package com.sulbazi.inquery;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.admin.AdminDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;


@Controller
public class InqueryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryService inquery_ser;
	@Autowired PhotoService photo_ser;
		
	//문의페이지 이동
	@RequestMapping(value="/userinquery.go")
	public String userinquery() {
		return "inquery/inqueryUserList";
	}
	
	//문의 글 작성(사용자)
	@PostMapping(value="/userinqueryWrite.do")
	public String userinquerywrite(MultipartFile[] inqueryfiles, @RequestParam Map<String, String> params, 
											Model model, HttpSession session) {
		logger.info("params: {}", params);
		logger.info("file count:"+inqueryfiles.length);
		inquery_ser.userinquerywrite(inqueryfiles, params, session);
		return "inquery/inqueryUserList";
	}
	
	//사용자 문의 글 리스트 
	@GetMapping(value="/inqueryuserList.ajax")
	@ResponseBody
	public Map<String, Object> userlistinquery(HttpSession session) {
		logger.info("사용자 문의 글 리스트 컨트롤러");
		String id = (String) session.getAttribute("loginId");
		logger.info(id);
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = inquery_ser.userlistinquery(id);
		map.put("list", list);
		return map;
	}
	
	//관리자 문의 글 페이지 이동
	@RequestMapping(value="/inqueryList.go")
	public String admininquerylistgo(Model model,HttpSession session) {
		logger.info("문의리스트가기 관리자컨트롤러");
		String page="main/main";
		if(!session.getAttribute("opt").equals("admin_log")) {
			model.addAttribute("result", "로그인이 필요한 서비스 입니다");
		}else {
			page="inquery/inqueryList";
		}
		return page;
	}
	
	//관리자 문의 글 리스트
	@GetMapping(value="/inqueryList.do")
	@ResponseBody
	public Map<String, Object> admininquerylist(Model model, HttpSession session) {
		logger.info("문의리스트 관리자컨트롤러");
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = inquery_ser.admininquerylist();
		map.put("inquerylist", inquerylist);
		return map;
	}
	
	//문의 글 리스트 필터링
	@GetMapping(value="/inqueryFiltering.ajax")
	@ResponseBody
	public Map<String, Object> inqueryfiltering(String inquerystate) {
		boolean bool=false;
		if(inquerystate.equals("false")) {
			bool = false;
		} else {
			bool = true;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = inquery_ser.inqueryfiltering(bool);
		map.put("inquerylist", inquerylist);
		return map;
	}
	
	//문의 글 사용자 id 검색
	@PostMapping(value="/inquerySearch.ajax")
	@ResponseBody
	public Map<String, Object> inquerysearch(@RequestParam Map<String, String> params) {
		logger.info("params: {}",params);
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = inquery_ser.inquerysearch(params);
		map.put("inquerylist", inquerylist);
		return map;
	}
	
	//사용자 문의 글 상세페이지 이동
	@GetMapping(value="/inqueryuserDetail.go")
    public String userinquerydetail(@RequestParam("inqueryIdx") int inqueryIdx, Model model, HttpSession session) {
		String page= "login";
		if(session.getAttribute("loginId") == null) {
			model.addAttribute("result", "로그인이 필요한 서비스");
		}else {
			InqueryDTO userinquerydetail = null; //문의 글
			List<AnswerDTO> answer = null; //문의 답변
			List<PhotoDTO> userinquerydetailphoto = null; //문의 사진
			page="redirect:/inquery/inqueryUserList";
			userinquerydetail = inquery_ser.userinquerydetail(inqueryIdx);
			answer = inquery_ser.answer(inqueryIdx);
			List<AdminDTO> answeradmin = inquery_ser.answeradmin(inqueryIdx);
			userinquerydetailphoto = photo_ser.inqueryphoto(inqueryIdx);
			if(userinquerydetail != null) {
				page="inquery/inqueryUserDetail";
				model.addAttribute("userinquerydetail",userinquerydetail);
				model.addAttribute("answer", answer);
				model.addAttribute("answeradmin",answeradmin);
				model.addAttribute("userinquerydetailphoto", userinquerydetailphoto);
			}
		}
		return page;
    }

<<<<<<< HEAD
=======
	@GetMapping(value="/inqueryDetail.go")
    public String admininquerydetail(@RequestParam("inqueryIdx") int inqueryIdx, Model model, HttpSession session) {
		logger.info("문의상세가기 관리자컨트롤러");
		String page= "login";
		if(session.getAttribute("loginId") == null) {
			model.addAttribute("result", "로그인이 필요한 서비스");
		}else {
			InqueryDTO userinquerydetail = null; //문의 글
			List<AnswerDTO> answer = null; //문의 답변
			List<PhotoDTO> userinquerydetailphoto = null; //문의 사진
			page="redirect:/inquery/inqueryList";
			userinquerydetail = inquery_ser.userinquerydetail(inqueryIdx);
			answer = inquery_ser.answer(inqueryIdx);
			List<AdminDTO> answeradmin = inquery_ser.answeradmin(inqueryIdx);
			userinquerydetailphoto = photo_ser.inqueryphoto(inqueryIdx);
			if(userinquerydetail != null) {
				page="inquery/inqueryDetail";
				model.addAttribute("userinquerydetail",userinquerydetail);
				model.addAttribute("answer", answer);
				model.addAttribute("answeradmin",answeradmin);
				model.addAttribute("userinquerydetailphoto", userinquerydetailphoto);
			}
		}
		return page;
    }
>>>>>>> origin/master

	@PostMapping(value="/adminanswer.do")
	public String adminanswer(@RequestParam String answer, HttpSession session, @RequestParam int inqueryIdx) {
	    logger.info("답변 등록 컨트롤러");
	    String loginId = (String) session.getAttribute("loginId");
	    logger.info(loginId);
	    logger.info(answer);
	    logger.info("" + inqueryIdx);
	    
	    inquery_ser.adminanswerdo(inqueryIdx, loginId, answer);
	    
	    // 리다이렉트 시 inqueryIdx 파라미터를 함께 전달
	    return "redirect:/inqueryDetail.go?inqueryIdx=" + inqueryIdx;
	}
	
}
