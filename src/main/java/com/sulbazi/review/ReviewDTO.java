package com.sulbazi.review;

import java.sql.Timestamp;

public class ReviewDTO {
    private int review_idx;         
    private String user_id;         
    private int store_idx;          
    private String review_content;  
    private Timestamp review_date;  
    private float starpoint;        
    private boolean review_state;
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
    
    
    
	
}
