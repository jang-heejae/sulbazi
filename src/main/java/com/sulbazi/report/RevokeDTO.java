package com.sulbazi.report;

import java.sql.Date;

public class RevokeDTO {
	private int revoke_idx;
	private String user_id;
	private String admin_id;
	private Date revoke_start;
	private Date revoke_stop;
	private Date revoke_handle;
	public int getRevoke_idx() {
		return revoke_idx;
	}
	public void setRevoke_idx(int revoke_idx) {
		this.revoke_idx = revoke_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public Date getRevoke_start() {
		return revoke_start;
	}
	public void setRevoke_start(Date revoke_start) {
		this.revoke_start = revoke_start;
	}
	public Date getRevoke_stop() {
		return revoke_stop;
	}
	public void setRevoke_stop(Date revoke_stop) {
		this.revoke_stop = revoke_stop;
	}
	public Date getRevoke_handle() {
		return revoke_handle;
	}
	public void setRevoke_handle(Date revoke_handle) {
		this.revoke_handle = revoke_handle;
	}
	
}
