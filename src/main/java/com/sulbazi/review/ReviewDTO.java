package com.sulbazi.review;

import java.sql.Date; 
import java.sql.Timestamp;

public class ReviewDTO {
	// 공통 컬럼 review_idx 3테이블 조인용 리뷰 ,유저 , 매장댓글 
	
    private int review_idx;         
    private String user_id;         
    private int store_idx;          
    private String review_content;  
    private Timestamp review_date;  
    private float starpoint;        
    private boolean review_state;
    
    
    //유저 테이블 컬럼
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
	
	//리뷰 매장 댓글 컬럼
    private Timestamp comm_date; 
    private String comm_content;
    
    // 리뷰 좋아요 수를 저장하는 컬럼 
    private int like_count;
    
    // 리뷰에 등록된 카테고리 이름들 가져오는 컬럼
    private String opt_names;
    
    
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Timestamp getReview_date() {
		return review_date;
	}
	public void setReview_date(Timestamp review_date) {
		this.review_date = review_date;
	}
	public float getStarpoint() {
		return starpoint;
	}
	public void setStarpoint(float starpoint) {
		this.starpoint = starpoint;
	}
	public boolean isReview_state() {
		return review_state;
	}
	public void setReview_state(boolean review_state) {
		this.review_state = review_state;
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
	public Timestamp getComm_date() {
		return comm_date;
	}
	public void setComm_date(Timestamp comm_date) {
		this.comm_date = comm_date;
	}
	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public String getOpt_names() {
		return opt_names;
	}
	public void setOpt_names(String opt_names) {
		this.opt_names = opt_names;
	}

    
	
    
    
    
    
    

    
	
}
