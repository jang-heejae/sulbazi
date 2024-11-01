package com.sulbazi.board;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class BoardDTO {
	
	private int board_idx;
	private int store_idx;
	private String board_subject;
	private String board_content;
	private LocalDate board_date;
	private int board_bHit;
	private int like_count;
	private String board_category;
	private boolean board_state;
	private String store_id;
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public int getStore_idx() {
		return store_idx;
	}
	public void setStore_idx(int store_idx) {
		this.store_idx = store_idx;
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
	
}
