package com.sulbazi.report;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportDAO {
	
	/*
	 * List<ReportDTO> reportList(int limit, int offset, String status, String
	 * category);
	 * 
	 * int allCount(String status, String category);
	 */

	 int allCount(int cnt_);
	 
	 List<HashMap<String, Object>> reportList(int limit, int offset);

	ReportDTO reportDetail(String report_idx);

	int reportWrite(ProcessDTO pro_dto);

}
