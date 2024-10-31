package com.sulbazi.report;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class RevokeService {
	@Autowired RevokeDAO revoke_dao;
	Logger log = LoggerFactory.getLogger(getClass());
	
	public int revoke(Map<String, String> param, String reported_id) {
	    log.info("revoke ser param: " + param);
	    log.info("revoke ser reported_id: " + reported_id);

	    RevokeDTO revoke_dto = new RevokeDTO();
	    revoke_dto.setAdmin_id(param.get("admin_id"));
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    try {
			revoke_dto.setRevoke_start(dateFormat.parse(param.get("revoke_start")));
			revoke_dto.setRevoke_stop(dateFormat.parse(param.get("revoke_stop")));
		} catch (ParseException e) {
			e.printStackTrace(); 
		}
	    revoke_dto.setUser_id(reported_id);

	    revoke_dao.revoke(revoke_dto);
	    return revoke_dto.getRevoke_idx(); // 방금 삽입된 revoke의 idx를 반환합니다.
	}

	
	 @Scheduled(cron = "0 0 0 * * ?")  // 매일 자정에 실행 
	 public void revokeSchedule() {
		 List<String> userIds = revoke_dao.userIds(); // 모든 user_id를 가져오는 DAO 메서드
		 LocalDate today = LocalDate.now();
	  
		 for (String userId : userIds) { // 오늘 날짜와 revoke의 시작일 및 종료일을 비교하는 로직
			 revoke_dao.revokeSchedule(userId, today); 
		 } 
	 }
	 
}
