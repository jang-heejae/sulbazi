package com.sulbazi.chat;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LocalChatroomDTO {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int localchat_idx;
	private String local_category;
	
	
	public int getLocalchat_idx() {
		return localchat_idx;
	}
	public void setLocalchat_idx(int localchat_idx) {
		this.localchat_idx = localchat_idx;
	}
	public String getLocal_category() {
		return local_category;
	}
	public void setLocal_category(String local_category) {
		this.local_category = local_category;
	}
	
}
