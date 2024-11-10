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
	 
	@RequestMapping(value="/adminDetail.go")
	public String adminDetail() {
		return "admin/adminDetail";
	}
	 
	// 관리자 리스트
	@GetMapping(value="/adminList.go")
	public String adminListGo() {
		return "admin/adminList";
	}
	// 관리자 추가
	@PostMapping(value="/adminAdd.do")
	public String adminAdd(@RequestParam Map<String, String>param, Model model) {
		String msg = admin_ser.adminAdd(param);
		model.addAttribute("result", msg);
		return "admin/adminList";
	}
	// 관리자 추가시 바로 리스트로 뿌리기
	@GetMapping(value="/adminList.ajax")
	@ResponseBody
	public Map<String, Object>adminList(){
		return admin_ser.adminList();
	}
	// 관리자 비밀번호 변경 페이지
	@RequestMapping(value="/adminUpdate.do")
	public String adminChange(String admin_id, Model model) {
		AdminDTO dto = admin_ser.adminChange(admin_id);
		model.addAttribute("info", dto);
		return "admin/adminUpdate";
	}
	// 관리자 비밀번호 변경 하고 바로 뿌리기
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
	// 관리자가 보는 회원 리스트 가기
	@RequestMapping(value="/adminUserList.go")
	public String adminUserList() {
		return "admin/adminUserList";
	}
	// 관리자가 보는 회원 리스트 뿌리기
	@GetMapping(value="/adminUserList.ajax")  
	@ResponseBody
	public Map<String, Object> adminUserList(String page, String cnt, String category, String keyword){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return admin_ser.adminUserList(page_, cnt_, category, keyword); 
	}
	// 관리자가 보는 회원 상세보기 가기
	@RequestMapping(value="/adminUserDetail.go")
	public String adminUserDetail(String user_id, Model model) {
		admin_ser.adminUserDetail(user_id, model);
		return "admin/adminUserDetail";
	}
	// 관리자가 보는 매장 리스트 가기
	@RequestMapping(value="/adminStoreList.go")
	public String adminStoreList() {
		return "admin/adminStoreList";
	}
	// 관리자가 보는 매장 리스트 뿌리기
	@GetMapping(value="/adminStoreList.ajax")  
	@ResponseBody
	public Map<String, Object> adminStoreList(String page, String cnt, String category, String keyword){
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return admin_ser.adminStoreList(page_, cnt_, category, keyword); 
	}
	// 관리자가 보는 매장 상세보기 가기
	@RequestMapping(value="/adminStoreDetail.go")
	public String adminStoreDetail(int store_idx, Model model) {
		int idx = store_idx;
		model.addAttribute("store_idx", idx);
		
		StoreDTO storeDetail = store_ser.getStoreDetail(idx);
		model.addAttribute("storedto", storeDetail);

		PhotoDTO mybp= store_ser.getStorePhoto(idx);
		model.addAttribute("mystorebestphoto", mybp);
        
		List<PhotoDTO> mysp= store_ser.getStorePhotos(idx);
		model.addAttribute("mystorephoto", mysp);

		List<Integer> selectedValues = store_ser.mystoreopt(idx);
		model.addAttribute("selectedValues",selectedValues);
          
		List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);
        model.addAttribute("options",options);
        
        List<StoreMenuDTO> storeMenu = store_ser.getStoreMenuById(idx);
        List<PhotoDTO> menufiles= store_ser.fileList(idx);
        model.addAttribute("storeMenu", storeMenu);
        model.addAttribute("menuphoto", menufiles);

        List<StoreMenuDTO> storeAlcohol = store_ser.getStoreAlcohol(idx);    
        List<PhotoDTO> drinkfiles= store_ser.alcoholFileList(idx);
        model.addAttribute("storeAlcohol", storeAlcohol);
        model.addAttribute("drinkphoto", drinkfiles);

		return "admin/adminStoreDetail";
	}
}
