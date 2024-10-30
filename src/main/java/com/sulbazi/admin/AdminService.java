package com.sulbazi.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.member.UserDAO;
import com.sulbazi.member.UserDTO;

@Service
public class AdminService {
	@Value("${upload.path}") private String bpath;
	@Autowired AdminDAO admin_dao;
	@Autowired UserDAO user_dao;
	Logger log= LoggerFactory.getLogger(getClass());

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
	public Map<String, Object> adminUserList(int page, int cnt, String category, String keyword) {
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 
		 Map<String, Object> param = new HashMap<String, Object>();
		 param.put("limit", limit);
		 param.put("offset", offset);
		 param.put("category", category);
		 param.put("keyword", keyword);
		 int totalPages = admin_dao.userCount(cnt);
	  
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("totalPages", totalPages);
		 map.put("list", admin_dao.adminUserList(param));
		 return map;
	}
	public Map<String, Object> adminStoreList(int page, int cnt, String category, String keyword) {
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 
		 Map<String, Object> param = new HashMap<String, Object>();
		 param.put("limit", limit);
		 param.put("offset", offset);
		 param.put("category", category);
		 param.put("keyword", keyword);
		 int totalPages = admin_dao.storeCount(cnt);
	  
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("totalPages", totalPages);
		 map.put("list", admin_dao.adminStoreList(param));
		 return map;
	}

	public void adminUserDetail(String user_id, Model model) {
	    // 1. User 정보 가져오기
	    UserDTO userDto = admin_dao.getUserInfo(user_id);
	    if (userDto != null) {
	        model.addAttribute("info", userDto);

	        // 2. Revoke 정보 가져오기 (user_revoke가 1인 경우만)
	        if (userDto.getUser_revoke() == 1) {
	            List<HashMap<String, Object>> revokeDetails = admin_dao.getRevokeInfo(user_id);
	            if (!revokeDetails.isEmpty()) {
	                HashMap<String, Object> revokeDetail = revokeDetails.get(0);
	                model.addAttribute("revoke_start", revokeDetail.get("revoke_start"));
	                model.addAttribute("revoke_stop", revokeDetail.get("revoke_stop"));
	            }
	        }

	        List<HashMap<String, Object>> allCategories = user_dao.getAllCategories();
		    model.addAttribute("allCategories", allCategories);
		    
	        List<HashMap<String, Object>> userCategories  = user_dao.getUserCategories(user_id);
	        model.addAttribute("categories", userCategories);

	    }
	    // 4. 파일 정보 가져오기
	    List<UserDTO> files = user_dao.files(user_id);
	    model.addAttribute("files", files);
	    log.info("user_photo{}:"+files);
	}
	
}
