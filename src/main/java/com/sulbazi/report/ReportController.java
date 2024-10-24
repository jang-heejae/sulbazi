package com.sulbazi.report;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
public class ReportController {
	@Autowired ReportService report_ser;
	
	@RequestMapping(value="/reportList.go")
	public String report() {
		return "admin/reportList";
	}

	/*
	 * @GetMapping(value="/reportList.ajax")
	 * 
	 * @ResponseBody public Map<String, Object> reportList(String page, String cnt){
	 * int page_ = Integer.parseInt(page); int cnt_ = Integer.parseInt(cnt); return
	 * report_ser.reportList(page_, cnt_); }
	 */
	/*
	 * @GetMapping(value="/reportList.ajax")
	 * 
	 * @ResponseBody public Map<String, Object> reportList(String page, String cnt,
	 * String status, String category){ int page_ = Integer.parseInt(page); int cnt_
	 * = Integer.parseInt(cnt); return report_ser.reportList(page_, cnt_, status,
	 * category); }
	 */
	@RequestMapping(value="/reportDetail.go")
	public String reportDetail(Model model, String report_idx) {
		ReportDTO report_dto = report_ser.reportDetail(report_idx);
		model.addAttribute("info", report_dto);
		return "admin/reportDetail";
	}
	@PostMapping(value="/reportWrite.ajax")
	@ResponseBody
	public Map<String, Object> reportWrite(Map<String, String>param,
			HttpSession session){
		param.put("admin_id", (String) session.getAttribute("loginId"));
		int idx = report_ser.reportWrite(param);
		String page = "";
		boolean suc = false;
		if(idx != 0) {
			suc = true;
			page = "/reportDetail.go?idx="+idx;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", suc);
		map.put("link", page);
		return map;
	}
}
