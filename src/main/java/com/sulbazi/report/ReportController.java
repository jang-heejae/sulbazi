package com.sulbazi.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import com.sulbazi.admin.AdminDAO;
import com.sulbazi.message.MessageService;
import com.sulbazi.message.UserMsgDAO;
import com.sulbazi.review.ReviewService;

@Controller
public class ReportController {
	@Autowired ReportService report_ser;
	@Autowired AdminDAO admin_dao;
	@Autowired ReviewService review_ser;
	@Autowired MessageService msg_ser;
	Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/reportList.go")
	public String report() {
		return "admin/reportList";
	}
	// 신고목록 페이지네이션 + 필터링 리스트
	@GetMapping(value="/reportList.ajax")
	@ResponseBody
	public Map<String, Object> reportList(
	    String page, String cnt,
	    @RequestParam(required = false, defaultValue = "all") String reportState,
	    @RequestParam(required = false, defaultValue = "all") String reportCategory
	) {
	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);
	    return report_ser.reportList(page_, cnt_, reportState, reportCategory);
	}
	// 신고 상세보기
	@GetMapping(value="/reportDetail.go")
	public String reportDetail(Model model, String report_idx, HttpSession session) {
		ReportDTO report_dto = report_ser.reportDetail(report_idx);
		model.addAttribute("info", report_dto);
		String admin_id = (String) session.getAttribute("loginId");
		String admin_name = admin_dao.getAdminNameById(admin_id);
	    model.addAttribute("admin_name", admin_name);
	    int reported_idx = report_dto.getReported_idx();
	    String rport_category = report_dto.getReport_category();
	    if ("리뷰".equals(rport_category)) {
	    	String review_content = review_ser.reportedIdx(reported_idx);
	    	model.addAttribute("reported_content", review_content);
	    }else if("개인 메시지".equals(rport_category)) {
	    	String usermsg_content = msg_ser.userreportedIdx(reported_idx);
	    	model.addAttribute("reported_content", usermsg_content);	    	
	    }else if("지역 메시지".equals(rport_category)) {
	    	String localmsg_content = msg_ser.localreportedIdx(reported_idx);
	    	model.addAttribute("reported_content", localmsg_content);
	    }
		return "admin/reportDetail";
	}
	// 신고에 관리자 답변달기
	@GetMapping(value="/processWrite.do")
	public String processWrite(@RequestParam Map<String, String> param, Model model, HttpSession session, int report_idx, String reported_id) {
	    String admin_id = (String) session.getAttribute("loginId");
	    param.put("admin_id", admin_id);
	    log.info("pro_write contrl reported_id: " + reported_id);
	    log.info("pro_write contrl report_idx: " + report_idx);
	    log.info("pro_write contrl admin_id: " + param.get("admin_id"));
	    log.info("pro_write contrl param:{} ", param);

	    ProcessDTO pro_dto = report_ser.processWrite(param, report_idx, reported_id);
	    log.info("pro_write contrl pro_idx: " + pro_dto);

	    return "redirect:/reportDetail.go?report_idx=" + report_idx;
	}
	// 관리자 답변 실시간으로 list 쌓기
	@GetMapping(value="/process.ajax")
	@ResponseBody
	public Map<String, Object> process(int report_idx) {
	    log.info("proajax report_idx: " + report_idx); 
	    return report_ser.process(report_idx);
	}
	
	
	
	
	
	
	
	
	// 채팅 신고 기능
	// 개인 채팅방 메세지 신고
	@PostMapping(value="/reportuser.ajax")
	@ResponseBody
	public String usermsgreport(@RequestParam String reported_id, @RequestParam String reporting_id, 
			@RequestParam String report_category, @RequestParam int reported_idx, @RequestParam String report_content){
		
		report_ser.usermsgreport(reported_id,reporting_id,report_category,reported_idx,report_content);
		
		return "success";
	}
	
	// 지역 채팅방 메세지 신고
	@PostMapping(value="/localreportuser.ajax")
	@ResponseBody
	public String localmsgreport(@RequestParam String reported_id, @RequestParam String reporting_id, 
			@RequestParam String report_category, @RequestParam int reported_idx, @RequestParam String report_content){
		
		report_ser.usermsgreport(reported_id,reporting_id,report_category,reported_idx,report_content);
		
		return "success";
	}
	
}

