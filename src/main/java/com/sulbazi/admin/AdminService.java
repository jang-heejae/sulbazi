package com.sulbazi.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.member.UserDAO;
import com.sulbazi.member.UserDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.report.RevokeDTO;

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

	        // 3. 카테고리 정보 가져오기
	        List<HashMap<String, Object>> categoryDetails = admin_dao.getUserCategories(user_id);
	        model.addAttribute("categories", categoryDetails);
	        log.info("categories{}:"+categoryDetails);
	        System.out.println("Category Detail: " + categoryDetails);
	    }

	    // 4. 파일 정보 가져오기
	    List<UserDTO> files = user_dao.files(user_id);
	    model.addAttribute("files", files);
	    log.info("user_photo{}:"+files);
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
