package com.sulbazi.photo;

public class PhotoDTO {

	
	private int photo_idx;
	private int photo_category_idx;
	private String new_filename;
	private int photo_folder_idx;

	public int getPhoto_idx() {
		return photo_idx;
	}
	public void setPhoto_idx(int photo_idx) {
		this.photo_idx = photo_idx;
	}

	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public int getPhoto_folder_idx() {
		return photo_folder_idx;
	}
	public void setPhoto_folder_idx(int photo_folder_idx) {
		this.photo_folder_idx = photo_folder_idx;
	}

	public int getPhoto_category_idx() {
		return photo_category_idx;
	}
	public void setPhoto_category_idx(int photo_category_idx) {
		this.photo_category_idx = photo_category_idx;
	}
	
}

