package com.sulbazi.message;

import java.sql.Time;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LocalMsgDTO {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int localmsg_idx;
	private int localchat_idx;
	private String user_id;
	private Time localmsg_time;
	private String localmsg_content;
	
	
	public int getLocalmsg_idx() {
		return localmsg_idx;
	}
	public void setLocalmsg_idx(int localmsg_idx) {
		this.localmsg_idx = localmsg_idx;
	}
	public int getLocalchat_idx() {
		return localchat_idx;
	}
	public void setLocalchat_idx(int localchat_idx) {
		this.localchat_idx = localchat_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Time getLocalmsg_time() {
		return localmsg_time;
	}
	public void setLocalmsg_time(Time localmsg_time) {
		this.localmsg_time = localmsg_time;
	}
	public String getLocalmsg_content() {
		return localmsg_content;
	}
	public void setLocalmsg_content(String localmsg_content) {
		this.localmsg_content = localmsg_content;
	}
	
	


}
