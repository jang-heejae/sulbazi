package com.sulbazi.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired LoginDAO login_dao;

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
}
