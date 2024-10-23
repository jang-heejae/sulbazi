package com.sulbazi.chat;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class UserChatroomDTO {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userchat_idx;
	private String user_id;
	private String userchat_subject;
	private Date userchat_date;
	private int userchat_state;
	private int current_people;
	private int max_people;
	private String notice;
	
	
	public int getUserchat_idx() {
		return userchat_idx;
	}
	public void setUserchat_idx(int userchat_idx) {
		this.userchat_idx = userchat_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUserchat_subject() {
		return userchat_subject;
	}
	public void setUserchat_subject(String userchat_subject) {
		this.userchat_subject = userchat_subject;
	}
	public Date getUserchat_date() {
		return userchat_date;
	}
	public void setUserchat_date(Date userchat_date) {
		this.userchat_date = userchat_date;
	}
	public int getUserchat_state() {
		return userchat_state;
	}
	public void setUserchat_state(int userchat_state) {
		this.userchat_state = userchat_state;
	}
	public int getCurrent_people() {
		return current_people;
	}
	public void setCurrent_people(int current_people) {
		this.current_people = current_people;
	}
	public int getMax_people() {
		return max_people;
	}
	public void setMax_people(int max_people) {
		this.max_people = max_people;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	
	
	
}
