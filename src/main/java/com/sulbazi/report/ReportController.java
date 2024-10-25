package com.sulbazi.report;

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

@Controller
public class ReportController {
	@Autowired ReportService report_ser;
	Logger log = LoggerFactory.getLogger(getClass());
	
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

	@GetMapping(value="/reportDetail.go")
	public String reportDetail(Model model, String report_idx) {
		ReportDTO report_dto = report_ser.reportDetail(report_idx);
		model.addAttribute("info", report_dto);
		return "admin/reportDetail";
	}
	@PostMapping(value="processWrite.do")
	public String processWrite(@RequestParam Map<String, String>param, Model model, HttpSession session, int report_idx, String reported_id) {
		param.put("admin_id", (String) session.getAttribute("loginId"));
		log.info("pro_write contrl report_idx: "+report_idx);
		log.info("pro_write contrl admin_id: "+param.get("admin_id"));
		report_ser.processWrite(param, report_idx, reported_id);
		ProcessDTO pro_dto = new ProcessDTO();
		model.addAttribute("info", pro_dto);
		log.info("pro_write contrl : "+param);
		return "admin/reportDetail";
	}
	
	@GetMapping(value="/process.ajax")
	@ResponseBody
	public Map<String, Object> process(){
		return report_ser.process();
	}
}
