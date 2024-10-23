package com.sulbazi.report;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReportController {
	@Autowired ReportService report_ser;
	
	@RequestMapping(value="/reportList.go")
	public String report() {
		return "admin/reportList";
	}
	@GetMapping(value="/reportList.ajax")
	@ResponseBody
	public Map<String, Object> reportList(String page, String cnt){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return report_ser.reportList(page_, cnt_);
	}
}
