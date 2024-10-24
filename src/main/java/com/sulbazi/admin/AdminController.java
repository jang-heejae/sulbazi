package com.sulbazi.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdminController {
	@Autowired AdminService admin_ser;
	@RequestMapping(value="/adminMain.go")
	public String admin() {
		return "main/adminMain";
	}
	@RequestMapping(value="/adminList.go")
	public String adminListGo() {
		return "admin/adminList";
	}
	
	@PostMapping(value="/adminAdd.do")
	public String adminAdd(@RequestParam Map<String, String>param, Model model) {
		String msg = admin_ser.adminAdd(param);
		model.addAttribute("result", msg);
		return "admin/adminList";
	}
	@GetMapping(value="/adminList.ajax")
	@ResponseBody
	public Map<String, Object>adminList(){
		return admin_ser.adminList();
	}
	@RequestMapping(value="/adminUpdate.do")
	public String adminChange(String admin_id, Model model) {
		AdminDTO dto = admin_ser.adminChange(admin_id);
		model.addAttribute("info", dto);
		return "admin/adminUpdate";
	}
	@PostMapping(value="/adminUpdate.ajax")
	@ResponseBody 
    public Map<String, Object> adminUpdate(@RequestParam Map<String, Object>param) {
        Map<String, Object> response = new HashMap<String, Object>();
            if (admin_ser.adminUpdate(param)) {
                response.put("success", true);
                response.put("message", "비밀번호 변경 성공");
            } else {
                response.put("success", false);
                response.put("message", "비밀번호 변경 실패");
            }
        return response; 
    }
	@RequestMapping(value="/adminUserList.go")
	public String adminUserList() {
		return "admin/adminUserList";
	}
	@RequestMapping(value="/adminStoreList.go")
	public String adminStoreList() {
		return "admin/adminStoreList";
	}
}
