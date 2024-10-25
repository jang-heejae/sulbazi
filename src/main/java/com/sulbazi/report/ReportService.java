package com.sulbazi.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReportService {
	@Autowired ReportDAO report_dao;
	@Autowired RevokeService revoke_ser;
	@Autowired RevokeDAO revoke_dao;
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
	
	@Transactional
	public int processWrite(Map<String, String> param, int report_idx, String reported_id) {
		ProcessDTO pro_dto = new ProcessDTO();
		pro_dto.setAdmin_id(param.get("admin_id"));
		pro_dto.setProcess_content(param.get(("process_content")));
		pro_dto.setProcess_result(param.get("cate_opt"));
		log.info("pro_write ser param : "+param);
		log.info("pro_write ser report_idx : "+report_idx);
		pro_dto.setReport_idx(report_idx);
		int pro_idx = pro_dto.getProcess_idx();
		if("revoke".equals(param.get("process_result")) && "revoke" != null) {
			revoke_ser.revoke(reported_id, param);
		}
		log.info("pro_write ser report_idx : "+pro_dto.getReport_idx());
		log.info("pro_write ser admin_id : "+pro_dto.getAdmin_id());		
		log.info("pro_write pro_dtp : "+pro_dto);
		/* return report_dao.processWrite(pro_dto, pro_idx, report_idx); */
		return report_dao.processWrite(pro_dto);
	}

	public Map<String, Object> process() {
		List<ProcessDTO> list = report_dao.process();
		List<RevokeDTO> list2 = revoke_dao.process();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("list", list2);
		log.info("pro ser list : "+list);
		log.info("pro ser list2 : "+list);
		return map;
	}

}
