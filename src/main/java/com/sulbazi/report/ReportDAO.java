package com.sulbazi.report;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportDAO {
	
	 int allCount(int cnt_);
	 
	 List<HashMap<String, Object>> reportList(int limit, int offset);

	ReportDTO reportDetail(String report_idx);

	int processWrite(ProcessDTO pro_dto);

	List<ProcessDTO> process();

}
