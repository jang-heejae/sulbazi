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
	
	private int answer_idx;
	private String admin_id;
	private String answer_content;
	private Date answer_date;
	
	public int getAnswer_idx() {
		return answer_idx;
	}
	public void setAnswer_idx(int answer_idx) {
		this.answer_idx = answer_idx;
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
	private String admin_name;
	private String admin_pw;
	private Date admin_doc;
	
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
