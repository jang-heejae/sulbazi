package com.sulbazi.member;


public class StoreDTO {

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
	public String getStore_address() {
		return store_address;
	}
	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}
	public String getStore_time() {
		return store_time;
	}
	public void setStore_time(String store_time) {
		this.store_time = store_time;
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

}

