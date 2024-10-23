package com.sulbazi.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	@Autowired AdminDAO adamin_dao;

	public String adminAdd(Map<String, String> param) {
		String msg = "실패";
		if(adamin_dao.adminAdd(param) > 0) {
			msg = "성공";
		}
		return msg;
	}
	public Map<String, Object> adminList() {
		List<AdminDTO> list = adamin_dao.adminList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	public AdminDTO adminChange(String admin_id) {
		return adamin_dao.adminChange(admin_id);
	}
	public boolean adminUpdate(Map<String, Object>param) {
		return adamin_dao.adminUpdate(param) > 0 ? true : false;
	} 
}
