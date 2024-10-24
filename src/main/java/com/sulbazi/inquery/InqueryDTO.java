package com.sulbazi.inquery;

import java.util.Date;

public class InqueryDTO {

	private int inquery_idx;
	private String inquery_content;
	private String inquery_subject;
	private Date inquery_date;
	private boolean inquery_state;
	private String id_category;
	private String id_write;
	
	
	public int getInquery_idx() {
		return inquery_idx;
	}
	public void setInquery_idx(int inquery_idx) {
		this.inquery_idx = inquery_idx;
	}
	public String getInquery_content() {
		return inquery_content;
	}
	public void setInquery_content(String inquery_content) {
		this.inquery_content = inquery_content;
	}
	public String getInquery_subject() {
		return inquery_subject;
	}
	public void setInquery_subject(String inquery_subject) {
		this.inquery_subject = inquery_subject;
	}
	public Date getInquery_date() {
		return inquery_date;
	}
	public void setInquery_date(Date inquery_date) {
		this.inquery_date = inquery_date;
	}
	public boolean getInquery_state() {
		return inquery_state;
	}
	public void setInquery_state(boolean inquery_state) {
		this.inquery_state = inquery_state;
	}
	public String getId_category() {
		return id_category;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public String getId_write() {
		return id_write;
	}
	public void setId_write(String id_write) {
		this.id_write = id_write;
	}
	
	
}
