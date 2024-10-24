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


@Controller
public class InqueryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryService inquery_ser;

	@RequestMapping(value="/userinquery.go")
	public String userinquery() {
		return "inquery/inqueryUserList";
	}
	
	@PostMapping(value="/userinquerywsrite.do")
	public String userinquerywrite(MultipartFile[] inqueryfiles, @RequestParam Map<String, String> params, 
											Model model, HttpSession session) {
		logger.info("params: {}", params);
		logger.info("file count:"+inqueryfiles.length);
		inquery_ser.userinquerywrite(inqueryfiles, params, session);
		return "inquery/inqueryUserList";
	}
	
	@GetMapping(value="userlistinquery.ajax")
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
	public String admininquerylist(Model model, HttpSession session) {
		logger.info("문의리스트 관리자컨트롤러");
		String page="main/main";
		if(!session.getAttribute("opt").equals("admin_log")) {
			model.addAttribute("result", "로그인이 필요한 서비스 입니다");
		}else {
			List<InqueryDTO> inquerylist = inquery_ser.admininquerylist();
			logger.info("list: {}",inquerylist);
			model.addAttribute("inquerylist", inquerylist);
			page="inquery/inqueryList";
		}
		return page;
	}
	
}
