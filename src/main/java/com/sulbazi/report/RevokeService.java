package com.sulbazi.report;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RevokeService {
	@Autowired RevokeDAO revoke_dao;
	Logger log = LoggerFactory.getLogger(getClass());
	
	void revoke(String reported_id, Map<String, String> param) {
		log.info("revoke ser param : "+param);
		RevokeDTO revoke_dto = new RevokeDTO();
		String revoke_start = param.get("revoke_start");
		String revoke_stop = param.get("revoke_stop");
		Date startDate = Date.valueOf(revoke_start);
		Date stopDate = Date.valueOf(revoke_stop);
		LocalDate today = LocalDate.now();
		revoke_dto.setAdmin_id(param.get("admin_id"));
		revoke_dto.setRevoke_start(startDate);
		revoke_dto.setRevoke_stop(stopDate);
		revoke_dto.setUser_id(reported_id);
		revoke_dao.revoke(revoke_dto);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("starDate", startDate);
		map.put("stopDate", stopDate);
		map.put("reported_id", reported_id);
		map.put("today", today);
		log.info("revoke ser revoke dto : "+revoke_dto);
		log.info("revoke ser revoke map : "+map);
		revoke_dao.revokeUpdate(map);
	}

}
