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

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;


@Controller
public class InqueryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryService inquery_ser;
	@Autowired PhotoService photo_ser;
		
	
	@RequestMapping(value="/userinquery.go")
	public String userinquery() {
		return "inquery/inqueryUserList";
	}
	
	@PostMapping(value="/userinqueryWrite.do")
	public String userinquerywrite(MultipartFile[] inqueryfiles, @RequestParam Map<String, String> params, 
											Model model, HttpSession session) {
		logger.info("params: {}", params);
		logger.info("file count:"+inqueryfiles.length);
		inquery_ser.userinquerywrite(inqueryfiles, params, session);
		return "inquery/inqueryUserList";
	}
	
	@GetMapping(value="/inqueryuserList.ajax")
	@ResponseBody
	public Map<String, Object> userlistinquery(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		logger.info(id);
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = inquery_ser.userlistinquery(id);
		map.put("list", list);
		return map;
	}
	
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
	
	
	@GetMapping(value="/inqueryList.do")
	@ResponseBody
	public Map<String, Object> admininquerylist(Model model, HttpSession session) {
		logger.info("문의리스트 관리자컨트롤러");
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = inquery_ser.admininquerylist();
		map.put("inquerylist", inquerylist);
		return map;
	}
	
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
	
	
	@PostMapping(value="/inquerySearch.ajax")
	@ResponseBody
	public Map<String, Object> inquerysearch(@RequestParam Map<String, String> params) {
		logger.info("params: {}",params);
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = inquery_ser.inquerysearch(params);
		map.put("inquerylist", inquerylist);
		return map;
	}
	
	
	@GetMapping(value="/inqueryuserDetail.go")
    public String userinquerydetail(@RequestParam("inqueryIdx") int inqueryIdx, Model model, HttpSession session) {
		String page= "login";
		if(session.getAttribute("loginId") == null) {
			model.addAttribute("result", "로그인이 필요한 서비스");
		}else {
			InqueryDTO userinquerydetail = null;
			List<AnswerDTO> answer = null;
			List<PhotoDTO> userinquerydetailphoto = null;
			page="redirect:/inquery/inqueryUserList";
			userinquerydetail = inquery_ser.userinquerydetail(inqueryIdx);
			answer = inquery_ser.answer(inqueryIdx);
			List<String> answeradmin = inquery_ser.answeradmin(inqueryIdx);
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

	
	@GetMapping(value="/inqueryDetail.go")
    public String admininquerydetail(@RequestParam("inqueryIdx") int inqueryIdx, Model model, HttpSession session) {
		String page= "login";
		if(session.getAttribute("loginId") == null) {
			model.addAttribute("result", "로그인이 필요한 서비스");
		}else {
			InqueryDTO userinquerydetail = null;
			List<PhotoDTO> userinquerydetailphoto = null;
			page="redirect:/inquery/inqueryList";
			userinquerydetail = inquery_ser.userinquerydetail(inqueryIdx); //문의 상세
			userinquerydetailphoto = photo_ser.inqueryphoto(inqueryIdx); //문의 사진
			if(userinquerydetail != null) {
				page="inquery/inqueryUserDetail";
				model.addAttribute("userinquerydetail",userinquerydetail);
				// model.addAttribute("userinquerydetailadmin", userinquerydetailadmin);
				// model.addAttribute("inquerydetailadmin", inquerydetailadmin);
				model.addAttribute("userinquerydetailphoto", userinquerydetailphoto);
			}
		}
		return page;
    }

	
}
