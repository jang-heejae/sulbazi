package com.sulbazi.report;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReportService {
	@Autowired ReportDAO report_dao;
	@Autowired RevokeDAO revoke_dao;
	

	 public Map<String, Object> reportList(int page, int cnt) { 
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 int totalPages = report_dao.allCount(cnt);
	  
	 Map<String, Object> map = new HashMap<String, Object>();
	 map.put("totalPages", totalPages); map.put("list",
	 report_dao.reportList(limit, offset)); return map; }

	/*
	 * public Map<String, Object> reportList(int page, int cnt, String status,
	 * String category) { int limit = cnt; int offset = (page - 1) * cnt;
	 * 
	 * List<ReportDTO> list = report_dao.reportList(limit, offset, status,
	 * category); int totalPages = (int) Math.ceil((double)
	 * report_dao.allCount(status, category) / cnt);
	 * 
	 * Map<String, Object> map = new HashMap<>(); map.put("totalPages", totalPages);
	 * map.put("list", list); return map; }
	 */
	

	public ReportDTO reportDetail(String report_idx) {
		return report_dao.reportDetail(report_idx);
	}
	
	@Transactional
	public int reportWrite(Map<String, String> param) {
		ProcessDTO pro_dto = new ProcessDTO();
		ReportDTO report_dto = new ReportDTO();
		pro_dto.setAdmin_id(param.get("admin_id"));
		pro_dto.setProcess_content(param.get(("process_content")));
		pro_dto.setProcess_result(param.get("process_result"));
		int report_idx = report_dto.getReport_idx();
		String reported_id = report_dto.getReported_id();
		pro_dto.setReport_idx(report_idx);
		if("revoke".equals(param.get("process_result")) && "revoke" != null) {
			revoke(reported_id, param);
		}
		int row = report_dao.reportWrite(pro_dto);
		return row;
	}

	private void revoke(String reported_id, Map<String, String> param) {
		RevokeDTO revoke_dto = new RevokeDTO();
		String revoke_start = param.get("revoke_start");
		String revoke_stop = param.get("revoke_stop");
		Date startDate = Date.valueOf(revoke_start);
		Date stopDate = Date.valueOf(revoke_stop);
		revoke_dto.setAdmin_id(param.get("admin_id"));
		revoke_dto.setRevoke_start(startDate);
		revoke_dto.setRevoke_stop(stopDate);
		revoke_dto.setUser_id(reported_id);
		revoke_dao.revoke(revoke_dto);
	}

}
