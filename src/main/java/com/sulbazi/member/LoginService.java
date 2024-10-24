package com.sulbazi.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired LoginDAO login_dao;
	Logger logger = LoggerFactory.getLogger(getClass());

	public String login(String id, String pw, String opt) {
		String log = "";
		String row = login_dao.login(id, pw, opt);
		if(opt.equals("user_log")) {
			if(row != null) {
				log = "user";				
			}
		}else if(opt.equals("store_log")) {
			if(row != null) {
				log = "store";
			}
		}else if(opt.equals("admin_log")) {
			if(row != null) {
				log = "admin";				
			}
		}
		return log;
	}
	
	public String userfindpwdo(String id, String email) {
		String msg = "일반 사용자 비밀번호 찾기 실패";
		if(login_dao.userfindpw(id, email) != null) {
			msg = "일반 사용자 비밀번호 찾기 성공";
		}
		logger.info(msg);		
		return msg;
	}

	public String storefindpwdo(String store_number) {
		String msg = "매장 사용자 비밀번호 찾기 실패";
		if(login_dao.storefindpwdo(store_number) != null) {
			msg = "매장 사용자 비밀번호 찾기 성공";
		}
		logger.info(msg);	
		return msg;
	}

	public void changeuserpw(String id, String newPassword) {
		login_dao.changeuserpw(id, newPassword);
	}

	public void changestorepw(String store_number, String newPassword) {
		login_dao.changestorepw(store_number, newPassword);
	}

	public String userfindiddo(String email) {
		return login_dao.userfindiddo(email);
	}

	public String storefindiddo(String number) {
		return login_dao.storefindiddo(number);
	}
}
