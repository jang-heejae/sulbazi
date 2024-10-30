package com.sulbazi.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreMenuDTO;
import com.sulbazi.member.StoreService;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

@Controller
public class AdminController {
	@Autowired AdminService admin_ser;
	@Autowired StoreService store_ser;
	@Autowired PhotoService photo_ser;
	Logger log= LoggerFactory.getLogger(getClass());
	
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
	
	@GetMapping(value="/adminUserList.ajax")  
	@ResponseBody
	public Map<String, Object> adminUserList(String page, String cnt, String category, String keyword){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return admin_ser.adminUserList(page_, cnt_, category, keyword); 
	}
	
	@RequestMapping(value="/adminUserDetail.go")
	public String adminUserDetail(String user_id, Model model) {
		admin_ser.adminUserDetail(user_id, model);
		return "admin/adminUserDetail";
	}

	@RequestMapping(value="/adminStoreList.go")
	public String adminStoreList() {
		return "admin/adminStoreList";
	}
	
	@GetMapping(value="/adminStoreList.ajax")  
	@ResponseBody
	public Map<String, Object> adminStoreList(String page, String cnt, String category, String keyword){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return admin_ser.adminStoreList(page_, cnt_, category, keyword); 
	}
	
	@RequestMapping(value="/adminStoreDetail.go")
	public String adminStoreDetail(int store_idx, Model model) {
		model.addAttribute("store_idx", store_idx);
		List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);//활성화된 카테고리
		model.addAttribute("options", options);
		StoreDTO storedto = store_ser.mystore(store_idx); 
	    List<Integer> selectedValues = store_ser.mystoreopt(store_idx);
	    PhotoDTO mystorebestphoto = photo_ser.mystorebestphoto(store_idx);
	    List<PhotoDTO> mystorephoto = photo_ser.mystorephoto(store_idx);
	    List<StoreMenuDTO> storeAlcohol = store_ser.getStoreAlcohol(store_idx);
	    List<StoreMenuDTO> storeMenu = store_ser.getStoreMenuById(store_idx);
	    List<PhotoDTO> files= store_ser.fileList(store_idx);
	    model.addAttribute("files",files);
	    model.addAttribute("mystorebestphoto", mystorebestphoto);
	    model.addAttribute("mystorephoto", mystorephoto);
	    model.addAttribute("selectedValues", selectedValues);
	    model.addAttribute("storedto", storedto);
	    model.addAttribute("storeAlcohol",storeAlcohol);
	    model.addAttribute("storeMenu",storeMenu);
		return "admin/adminStoreDetail";
	}
}
