package com.sulbazi.inquery;

import java.sql.Date;

public class AnswerDTO {
	private int answer_idx;
	private int inquery_idx;
	private String admin_id;
	private String answer_content;
	private Date answer_date;
	
	
	public int getAnswer_idx() {
		return answer_idx;
	}
	public void setAnswer_idx(int answer_idx) {
		this.answer_idx = answer_idx;
	}
	public int getInquery_idx() {
		return inquery_idx;
	}
	public void setInquery_idx(int inquery_idx) {
		this.inquery_idx = inquery_idx;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public Date getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}
	
	
	
	
}
