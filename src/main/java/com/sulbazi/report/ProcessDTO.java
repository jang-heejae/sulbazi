package com.sulbazi.report;

import java.sql.Date;

public class ProcessDTO {
	private int process_idx;
	private int report_idx;
	private String admin_id;
	private String process_content;
	private Date process_date;
	private String process_result;
	private int revoke_idx;
	public int getRevoke_idx() {
		return revoke_idx;
	}
	public void setRevoke_idx(int revoke_idx) {
		this.revoke_idx = revoke_idx;
	}
	public int getProcess_idx() {
		return process_idx;
	}
	public void setProcess_idx(int process_idx) {
		this.process_idx = process_idx;
	}
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getProcess_content() {
		return process_content;
	}
	public void setProcess_content(String process_content) {
		this.process_content = process_content;
	}
	public Date getProcess_date() {
		return process_date;
	}
	public void setProcess_date(Date process_date) {
		this.process_date = process_date;
	}
	public String getProcess_result() {
		return process_result;
	}
	public void setProcess_result(String process_result) {
		this.process_result = process_result;
	}
	
}
