package com.sulbazi.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired LoginDAO login_dao;
	
	public String login(String id, String pw, String opt) {
	    String log = "";
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
}
