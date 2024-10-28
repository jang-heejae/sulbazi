package com.sulbazi.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.member.UserDAO;
import com.sulbazi.member.UserDTO;
import com.sulbazi.photo.PhotoDTO;

@Service
public class AdminService {
	@Autowired AdminDAO admin_dao;
	@Autowired UserDAO user_dao;

	public String adminAdd(Map<String, String> param) {
		String msg = "실패";
		if(admin_dao.adminAdd(param) > 0) {
			msg = "성공";
		}
		return msg;
	}
	public Map<String, Object> adminList() {
		List<AdminDTO> list = admin_dao.adminList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	public AdminDTO adminChange(String admin_id) {
		return admin_dao.adminChange(admin_id);
	}
	public boolean adminUpdate(Map<String, Object>param) {
		return admin_dao.adminUpdate(param) > 0 ? true : false;
	}
	public Map<String, Object> adminUserList(int page, int cnt) {
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 int totalPages = admin_dao.userCount(cnt);
	  
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("totalPages", totalPages);
		 map.put("list", admin_dao.adminUserList(limit, offset));
		 return map;
	}
	public void adminUserDetail(String user_id, Model model) {
		UserDTO userDto = admin_dao.adminUserDetail(user_id);
		List<PhotoDTO> files = user_dao.files(user_id);
		model.addAttribute("info", userDto);
		model.addAttribute("files", files);
	} 
	
	public Map<String, Object> adminStoreList(int page, int cnt) {
		int limit = cnt;
		 int offset = (page-1) * cnt;
		 int totalPages = admin_dao.storeCount(cnt);
	  
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("totalPages", totalPages);
		 map.put("list", admin_dao.adminStoreList(limit, offset));
		 return map;
	}
}
