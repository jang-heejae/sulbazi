package com.sulbazi.admin;

import java.util.Date;

public class AdminDTO {
	private String admin_id;
	private String admin_name;
	private String admin_pw;
	private Date admin_doc;
	public String getAdmin_id() {
		return admin_id;
	} 
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getAdmin_pw() {
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
	public Date getAdmin_doc() {
		return admin_doc;
	}
	public void setAdmin_doc(Date admin_doc) {
		this.admin_doc = admin_doc;
	}
}
