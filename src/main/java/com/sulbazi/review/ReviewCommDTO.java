package com.sulbazi.review;

import java.sql.Timestamp;

public class ReviewCommDTO {
	
    private int review_idx;
    private int store_idx;  
    private Timestamp comm_date; 
    private String comm_content;
    
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
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
    

	
    
}
