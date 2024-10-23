package com.sulbazi.category;

public class CategoryOptDTO {
	private int opt_idx;
	private int category_idx;
	private String opt_name;
	private boolean category_state;
	public int getOpt_idx() {
		return opt_idx;
	}
	public void setOpt_idx(int opt_idx) {
		this.opt_idx = opt_idx;
	}
	public int getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}
	public String getOpt_name() {
		return opt_name;
	}
	public void setOpt_name(String opt_name) {
		this.opt_name = opt_name;
	}
	public boolean isCategory_state() {
		return category_state;
	}
	public void setCategory_state(boolean category_state) {
		this.category_state = category_state;
	}
}
