package com.sulbazi.chat;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class PartiDTO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int parti_idx;
	private String user_id;
	private int parti_state;
	private Date parti_time;
	private String chatroom_category;
	private int chatroom_idx;
	
	
	public int getParti_idx() {
		return parti_idx;
	}
	public void setParti_idx(int parti_idx) {
		this.parti_idx = parti_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getParti_state() {
		return parti_state;
	}
	public void setParti_state(int parti_state) {
		this.parti_state = parti_state;
	}
	public Date getParti_time() {
		return parti_time;
	}
	public void setParti_time(Date parti_time) {
		this.parti_time = parti_time;
	}
	public String getChatroom_category() {
		return chatroom_category;
	}
	public void setChatroom_category(String chatroom_category) {
		this.chatroom_category = chatroom_category;
	}
	public int getChatroom_idx() {
		return chatroom_idx;
	}
	public void setChatroom_idx(int chatroom_idx) {
		this.chatroom_idx = chatroom_idx;
	}
	
}
