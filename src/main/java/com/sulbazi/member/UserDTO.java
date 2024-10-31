package com.sulbazi.member;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class UserDTO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)

	private String user_id;
	private String user_pw;
	private String user_nickname;
	private String user_name;
	private String user_gender;
	private String user_birth;
	private String user_phone;
	private String user_email;
	private int user_revoke;
	private int user_reportno;
	private int user_reportedcases;
	private int user_likecount;
	private String user_photo;
	private Date user_date;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public int getUser_revoke() {
		return user_revoke;
	}
	public void setUser_revoke(int user_revoke) {
		this.user_revoke = user_revoke;
	}
	public int getUser_reportno() {
		return user_reportno;
	}
	public void setUser_reportno(int user_reportno) {
		this.user_reportno = user_reportno;
	}
	public int getUser_reportedcases() {
		return user_reportedcases;
	}
	public void setUser_reportedcases(int user_reportedcases) {
		this.user_reportedcases = user_reportedcases;
	}
	public int getUser_likecount() {
		return user_likecount;
	}
	public void setUser_likecount(int user_likecount) {
		this.user_likecount = user_likecount;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	public Date getUser_date() {
		return user_date;
	}
	public void setUser_date(Date user_date) {
		this.user_date = user_date;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
