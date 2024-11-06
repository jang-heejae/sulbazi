package com.sulbazi.alarm;

import java.sql.Time;
import java.time.LocalDate;
import java.util.Date;

public class AlamDTO {

	private int alarm_idx;
	private String user_id;
	private int alarm_category_idx;
	private Time alarm_time;
	private int alarm_read;
	private String alarm_subject;
	
	private int store_idx;
	private String store_id;
	private String store_pw;
	private String store_number;
	private String store_name;
	private String store_phone;
	private String store_time;
	private String store_address;
	private double store_latitude;
	private double store_longitude;
	private int review_total;
	private float star_average;
	private int bookmark_user;
	   
	private String alarm_category;
	private String alarm_content;
		
		

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
	
	public String getChatroomboss() {
		return chatroomboss;
	}
	public void setChatroomboss(String chatroomboss) {
		this.chatroomboss = chatroomboss;
	}
	private String chatroomboss;
	
	private int parti_idx;
	private int parti_state;
	private Time parti_time;
	private String chatroom_category;
	private int chatroom_idx;
	public String getPartiuser() {
		return partiuser;
	}
	public void setPartiuser(String partiuser) {
		this.partiuser = partiuser;
	}
	private String partiuser;
	
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getStore_pw() {
		return store_pw;
	}
	public void setStore_pw(String store_pw) {
		this.store_pw = store_pw;
	}
	public String getStore_number() {
		return store_number;
	}
	public void setStore_number(String store_number) {
		this.store_number = store_number;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_phone() {
		return store_phone;
	}
	public void setStore_phone(String store_phone) {
		this.store_phone = store_phone;
	}
	public String getStore_time() {
		return store_time;
	}
	public void setStore_time(String store_time) {
		this.store_time = store_time;
	}
	public String getStore_address() {
		return store_address;
	}
	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}
	public double getStore_latitude() {
		return store_latitude;
	}
	public void setStore_latitude(double store_latitude) {
		this.store_latitude = store_latitude;
	}
	public double getStore_longitude() {
		return store_longitude;
	}
	public void setStore_longitude(double store_longitude) {
		this.store_longitude = store_longitude;
	}
	public int getReview_total() {
		return review_total;
	}
	public void setReview_total(int review_total) {
		this.review_total = review_total;
	}
	public float getStar_average() {
		return star_average;
	}
	public void setStar_average(float star_average) {
		this.star_average = star_average;
	}
	public int getBookmark_user() {
		return bookmark_user;
	}
	public void setBookmark_user(int bookmark_user) {
		this.bookmark_user = bookmark_user;
	}
	public String getAlarm_category() {
		return alarm_category;
	}
	public void setAlarm_category(String alarm_category) {
		this.alarm_category = alarm_category;
	}
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
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
	public int getParti_idx() {
		return parti_idx;
	}
	public void setParti_idx(int parti_idx) {
		this.parti_idx = parti_idx;
	}
	public int getParti_state() {
		return parti_state;
	}
	public void setParti_state(int parti_state) {
		this.parti_state = parti_state;
	}
	public Time getParti_time() {
		return parti_time;
	}
	public void setParti_time(Time parti_time) {
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
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public LocalDate getBoard_date() {
		return board_date;
	}
	public void setBoard_date(LocalDate board_date) {
		this.board_date = board_date;
	}
	public int getBoard_bHit() {
		return board_bHit;
	}
	public void setBoard_bHit(int board_bHit) {
		this.board_bHit = board_bHit;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public boolean isBoard_state() {
		return board_state;
	}
	public void setBoard_state(boolean board_state) {
		this.board_state = board_state;
	}
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
	public boolean isInquery_state() {
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
	private int board_idx;
	private String board_subject;
	private String board_content;
	private LocalDate board_date;
	private int board_bHit;
	private int like_count;
	private String board_category;
	private boolean board_state;

	private int answer_idx;
	private int inquery_idx;
	private String admin_id;
	private String answer_content;
	private Date answer_date;
	
	
	private String inquery_content;
	private String inquery_subject;
	private Date inquery_date;
	private boolean inquery_state;
	private String id_category;
	private String id_write;
	
	
	public String getAlarm_subject() {
		return alarm_subject;
	}
	public void setAlarm_subject(String alarm_subject) {
		this.alarm_subject = alarm_subject;
	}
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


	private int userchat_idx;
	public int getUserchat_idx() {
		return userchat_idx;
	}
	public void setUserchat_idx(int userchat_idx) {
		this.userchat_idx = userchat_idx;
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
	private String userchat_subject;
	private Date userchat_date;
	private int userchat_state;
	private int current_people;
	private int max_people;
	private String notice;
	
	
}
