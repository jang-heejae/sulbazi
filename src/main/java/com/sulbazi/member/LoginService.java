package com.sulbazi.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

@Service
@PropertySource("classpath:super_admin.properties")
public class LoginService {
	@Autowired LoginDAO login_dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${admin.id}") private String admin_id;
	@Value("${admin.pw}") private String admin_pw;
	@Value("${admin.ip}") private String admin_ip;
	
	public String login(String id, String pw, String opt, String ip) {
	    logger.info("Admin 설정 - ID: {}, PW: {}, IP: {}", admin_id, admin_pw, admin_ip);
	    logger.info("로그인 메서드 호출 - ID: {}, PW: {}, IP: {}, 옵션: {}", id, pw, ip, opt);

	    String log = "";
	    if(id.equals(admin_id) && pw.equals(admin_pw) && "admin_log".equals(opt) && ip.equals(admin_ip)) {
	    	return "admin";
	    }
    	String row = login_dao.login(id, pw, opt);
    	if (row != null) {
    		log = getUserType(opt);	    		
	    }
	    return log;
	}

	private String getUserType(String opt) {
	    switch (opt) {
	        case "user_log":
	            return "user";
	        case "store_log":
	            return "store";
	        case "admin_log":
	            return "admin";
	        default:
	            return "";
	    }
	}
	/*
	 * public String login(String id, String pw, String opt) { String log = "";
	 * String row = login_dao.login(id, pw, opt); if(opt.equals("user_log")) {
	 * if(row != null) { log = "user"; } }else if(opt.equals("store_log")) { if(row
	 * != null) { log = "store"; } }else if(opt.equals("admin_log")) { if(row !=
	 * null) { log = "admin"; } } return log; }
	 */

	public boolean userRevoke(String id, String opt) {
		return login_dao.userRevoke(id, opt);
	}
	public String userfindpwdo(String user_id, String user_email) {
		return login_dao.userfindpw(user_id, user_email);
	}

	public String storefindpwdo(String store_id, String store_number) {
		return login_dao.storefindpwdo(store_id, store_number);
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
