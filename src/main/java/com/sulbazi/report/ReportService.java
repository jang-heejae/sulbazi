package com.sulbazi.report;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService {
	@Autowired ReportDAO report_dao;
	
	public Map<String, Object> reportList(int page_, int cnt_) {
		int limit = cnt_;
		int offset = (page_-1) * cnt_;
		int totalPages = report_dao.allCount(cnt_);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalPages", totalPages);
		map.put("list", report_dao.reportList(limit, offset));
		return map;
	}

}
