package com.sulbazi.alarm;

import java.sql.Time;

public class AlamDTO {

	private int alarm_idx;
	private String	user_id;
	private int alarm_category_idx;
	private Time alarm_time;
	private int alarm_read;
	
	public int getAlarm_idx() {
		return alarm_idx;
	}
	public void setAlarm_idx(int alarm_idx) {
		this.alarm_idx = alarm_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getAlarm_category_idx() {
		return alarm_category_idx;
	}
	public void setAlarm_category_idx(int alarm_category_idx) {
		this.alarm_category_idx = alarm_category_idx;
	}
	public Time getAlarm_time() {
		return alarm_time;
	}
	public void setAlarm_time(Time alarm_time) {
		this.alarm_time = alarm_time;
	}
	public int getAlarm_read() {
		return alarm_read;
	}
	public void setAlarm_read(int alarm_read) {
		this.alarm_read = alarm_read;
	}
	
	
	
}
