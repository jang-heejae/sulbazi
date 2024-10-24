package com.sulbazi.inquery;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class InqueryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryService inquery_ser;

	@RequestMapping(value="/userinquery.go")
	public String userinquery() {
		return "inquery/inqueryUserList";
	}
	
	@PostMapping(value="/userinquerywrite.do")
	public String userinquerywrite(MultipartFile[] inqueryfiles, @RequestParam Map<String, String> params, 
											Model model, HttpSession session) {
		logger.info("params: {}", params);
		logger.info("file count:"+inqueryfiles.length);
		inquery_ser.userinquerywrite(inqueryfiles, params, session);
		return "inquery/inqueryUserList";
	}
}
