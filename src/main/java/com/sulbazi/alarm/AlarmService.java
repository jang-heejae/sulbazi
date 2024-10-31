package com.sulbazi.alarm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlarmService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AlarmDAO alarm_dao;
	
	public void partialarm(String id) {
		alarm_dao.partialarm(id);		
	}

}
