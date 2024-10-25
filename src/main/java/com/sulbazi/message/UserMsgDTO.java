package com.sulbazi.message;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class UserMsgDTO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private int usermsg_idx;
	private int userchat_idx;
	private String user_id;
	private Date usermsg_time;
	private String usermsg_content;
	
	
	public int getUsermsg_idx() {
		return usermsg_idx;
	}
	public void setUsermsg_idx(int usermsg_idx) {
		this.usermsg_idx = usermsg_idx;
	}
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
	public Date getUsermsg_time() {
		return usermsg_time;
	}
	public void setUsermsg_time(Date usermsg_time) {
		this.usermsg_time = usermsg_time;
	}
	public String getUsermsg_content() {
		return usermsg_content;
	}
	public void setUsermsg_content(String usermsg_content) {
		this.usermsg_content = usermsg_content;
	}
	
}
