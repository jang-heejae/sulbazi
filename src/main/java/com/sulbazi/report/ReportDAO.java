package com.sulbazi.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportDAO {
	
	 int allCount(int cnt_);
	 
	 List<HashMap<String, Object>> reportList(int limit, int offset);

	ReportDTO reportDetail(String report_idx);

	int processWrite(ProcessDTO processDTO);

	List<ProcessDTO> process(String process_idx);

	ReportDTO getReportedIdByReportIdx(int report_idx);

	List<ProcessDTO> getProcessesByReportIdx(int report_idx);

	void updateReportResult(int report_idx, boolean result);

	List<ReportDTO> getAllReports();

	List<ReportDTO> getReportsByState(int state);

	
	
	// 채팅 신고 기능
	// 개인, 지역 채팅방 메세지 신고
	int usermsgreport(String reported_id, String reporting_id, String report_category, int reported_idx,
			String report_content);


}
