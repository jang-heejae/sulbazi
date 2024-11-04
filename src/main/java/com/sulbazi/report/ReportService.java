package com.sulbazi.report;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sulbazi.admin.AdminDAO;
import com.sulbazi.member.UserDAO;

@Service
public class ReportService {
	@Autowired ReportDAO report_dao;
	@Autowired RevokeService revoke_ser;
	@Autowired RevokeDAO revoke_dao;
	@Autowired AdminDAO admin_dao;
	@Autowired UserDAO user_dao;
	Logger log = LoggerFactory.getLogger(getClass());
	
 
	 public Map<String, Object> reportList(int page, int cnt) { 
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 int totalPages = report_dao.allCount(cnt);
	   
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("totalPages", totalPages);
		 map.put("list", report_dao.reportList(limit, offset));
		 return map;
	 }

	public ReportDTO reportDetail(String report_idx) {
		return report_dao.reportDetail(report_idx);
	}
	
	@Transactional // 관리자 신고에 답변달기
	public ProcessDTO processWrite(Map<String, String> param, int report_idx, String reported_id) {
	    ProcessDTO pro_dto = new ProcessDTO();
	    log.info("pro_write service reported_id: " + reported_id);
	    log.info("pro_write service param: {}", param);
	    log.info("pro_write service revoke_stop: {}", param.get("revoke_stop"));

	    pro_dto.setAdmin_id(param.get("admin_id"));
	    pro_dto.setProcess_content(param.get("process_content"));
	    pro_dto.setReport_idx(report_idx);
	    String processResult = param.get("cate_opt");
	    int revokeIdx = 0;

	    if ("revoke".equals(processResult)) {
	        pro_dto.setProcess_result("이용 제한");
	        revokeIdx = revoke_ser.revoke(param, reported_id); // revoke_idx 값을 받음
	    } else {
	        pro_dto.setProcess_result("반려");
	        revokeIdx = revoke_ser.revoke(param, reported_id);
	    }

	    pro_dto.setRevoke_idx(revokeIdx); // revoke_idx 설정
	    report_dao.processWrite(pro_dto);
	    report_dao.updateReportResult(report_idx, true);
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("reported_id", reported_id);
	    
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    try {
			params.put("startDate", dateFormat.parse(param.get("revoke_start")));
			params.put("stopDate", dateFormat.parse(param.get("revoke_stop")));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    params.put("today", LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant());

	    // DAO 호출하여 user 테이블 업데이트
	    revoke_dao.revokeUpdate(params);

	    int process_idx = pro_dto.getProcess_idx();
	    log.info("pro_write service process_idx: " + process_idx);
	    log.info("pro_write service revoke_idx: " + revokeIdx);
	    return pro_dto;
	}

	public Map<String, Object> process(int report_idx) { 
	    // ProcessDTO 가져오기
	    List<ProcessDTO> processList = report_dao.getProcessesByReportIdx(report_idx);
	    
	    // 통합 리스트 초기화
	    List<Map<String, Object>> combinedList = new ArrayList<>();

	    for (ProcessDTO process : processList) {
	        Map<String, Object> combinedData = new HashMap<>();
	        combinedData.put("process_result", process.getProcess_result());
	        combinedData.put("process_content", process.getProcess_content());
	        combinedData.put("process_date", process.getProcess_date());
	        combinedData.put("admin_id", process.getAdmin_id());
	        // admin_id로 admin_name 가져오기
	        String admin_name = admin_dao.getAdminNameById(process.getAdmin_id());
	        combinedData.put("admin_name", admin_name);
	        
	        // revoke_idx를 사용하여 revoke 정보를 가져오기
	        if (process.getRevoke_idx() != 0) {
	            log.info("revoke_idx: " + process.getRevoke_idx());
	            RevokeDTO revoke = revoke_dao.getRevokeByIdx(process.getRevoke_idx());
	            if (revoke != null) {
	                combinedData.put("revoke_start", revoke.getRevoke_start());
	                combinedData.put("revoke_stop", revoke.getRevoke_stop());
	            } else {
	            	combinedData.put("revoke_start", "N/A");
	                combinedData.put("revoke_stop", "N/A");
	            }
	        }
	        combinedList.add(combinedData);
	    }
	    Map<String, Object> map = new HashMap<>();
	    map.put("list", combinedList); // 통합 리스트 반환
	    log.info("뿌리는 정보: " + map);
	    return map; 
	}


	public List<ReportDTO> getAllReports() {
		return report_dao.getAllReports();
	}

	public List<ReportDTO> getReportsByState(int state) {
		return report_dao.getReportsByState(state);
	}

	
	
	
	// 채팅 신고 기능
	// 개인, 지역 채팅방 메세지 신고
	@Transactional
	public void usermsgreport(String reported_id, String reporting_id, String report_category, int reported_idx, String report_content) {
		int row = report_dao.usermsgreport(reported_id, reporting_id, report_category, reported_idx, report_content);
		if(row>0) {
			user_dao.report(reporting_id);
			user_dao.reported(reported_id);
		}
	}
	//리뷰 신고
	public int reportReview(Map<String, String> params) {
		int row = report_dao.reportReview(params);
		//유저 테이블 신고횟수 업데이트
		int dao = report_dao.userReportedCount(params);
		
		return row;
	}

}
