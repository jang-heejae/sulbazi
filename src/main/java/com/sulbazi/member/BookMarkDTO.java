package com.sulbazi.member;

import java.time.LocalDateTime;

public class BookMarkDTO {
	
	private int bookmark_idx;
	private int user_id;
	private String store_idx;
	private LocalDateTime bookmark_date;
	public int getBookmark_idx() {
		return bookmark_idx;
	}
	public void setBookmark_idx(int bookmark_idx) {
		this.bookmark_idx = bookmark_idx;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(String store_idx) {
		this.store_idx = store_idx;
	}
	public LocalDateTime getBookmark_date() {
		return bookmark_date;
	}
	public void setBookmark_date(LocalDateTime bookmark_date) {
		this.bookmark_date = bookmark_date;
	}

	
}
