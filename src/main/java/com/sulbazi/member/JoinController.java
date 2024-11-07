package com.sulbazi.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sulbazi.category.CategoryDAO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.CategoryService;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;
@Controller
public class JoinController {
	@Autowired JoinService join_ser;
	@Autowired PhotoService photo_ser;
	@Autowired CategoryService category_ser;
	@Autowired CategoryDAO category_dao;
	
  	Logger logger = LoggerFactory.getLogger(getClass());

   @RequestMapping(value="/storeJoin.go")
   public String storejoin(Model model) {
	   List<CategoryOptDTO> categoryOptList = category_ser.joincategory();
	   model.addAttribute("category", categoryOptList);
      return "member/storeJoin";
   }


	@PostMapping(value="/storeJoin.ajax")
	@ResponseBody
	 public Map<String, Object> storeJoin(
			 MultipartFile[] files,
			 MultipartFile fileone,
			 @RequestParam Map<String, String> param,
			 @RequestParam("latitude") String latitude,
	         @RequestParam("longitude") String longitude) { 
		logger.info("param : {}", param);
		logger.info("lat : {}",latitude);
		logger.info("lon : {}",longitude);
		Map<String, Object> map = new HashMap<String, Object>();
		 try {
			 int store_idx = join_ser.storeJoin(files, fileone, param, latitude, longitude);
			 map.put("success", true); 
			 map.put("link", "menu.go?store_idx="+store_idx);
		} catch (Exception e) {
			map.put("success", false);
            map.put("message", "오류가 발생했습니다: " + e.getMessage());
		}
		 return map; 
	 }
	

	
	@RequestMapping(value="/userjoin.go")
    public String userJoin(Model model) {
		List<CategoryOptDTO> categoryOptList = category_ser.joincategory();
	    model.addAttribute("category", categoryOptList);
        return "member/userJoin";
	}
	
	@PostMapping(value="/userJoin.do")
	public String userJoindo(
			MultipartFile files,
			@RequestParam Map<String, String> params,
			Model model) {
		logger.info("params : {}", params);
		String page = "";
		if(join_ser.userJoindo(files, params) > 0) {
			model.addAttribute("msg", "회원가입에 성공했습니다.");
			page = "member/login";
		}else {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			page = "member/userJoin";
		}
		return page;
	}

	@PostMapping(value="/checkid.ajax")
	@ResponseBody
	public Map<String, Object> checkid(@RequestParam("user_id") String userId) {
		logger.info("checkid : " + userId);
		boolean exists = join_ser.checkid(userId);
		Map<String, Object> response = new HashMap<>();
		response.put("exists", exists);
		logger.info("checkid boolean : " + response);
		return response;
	}
	
	@PostMapping(value="/checkstoreid.ajax")
	@ResponseBody
	public Map<String, Object> checkstoreid(@RequestParam("store_id") String store_id){
		logger.info(store_id);
		boolean exists = join_ser.checkstoreid(store_id);
		logger.info("참트루 : " + exists);
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("exixts", exists);
		return response;
	}
	
	
	@PostMapping(value="/checkEmail.ajax")
	@ResponseBody
	public Map<String, Object> checkemail(@RequestParam("user_email") String userEmail) {
		logger.info("checkemail : " + userEmail);
		boolean exists = join_ser.checkEmail(userEmail);
		Map<String, Object> response = new HashMap<>();
		response.put("exists", exists);
		logger.info("checkemail boolean : " + response);
		return response;
	}
	
	@PostMapping(value="/checknumber.ajax")
	@ResponseBody
	public Map<String, Object> checknumber(@RequestParam("store_number") String storenumber) {
		logger.info("checknumber : " + storenumber);
		boolean exists = join_ser.checknumber(storenumber);
		Map<String, Object> response = new HashMap<>();
		response.put("exists", exists);
		logger.info("checknumber boolean : " + response);
		return response;
	}
	
	@RequestMapping(value="/menu.go")
	public String menu(@RequestParam(value = "store_idx", required = false) Integer store_idx, Model model) {
		model.addAttribute("store_idx", store_idx);
		logger.info("방금 회원가입한 매장 idx : " + store_idx);
		return "member/menu";
	}

	@PostMapping(value="/menu.do")
	@ResponseBody
	public Map<String, Object> menudo(
			MultipartFile file,
			@RequestParam("menu_name") String menu_name,
            @RequestParam("menu_price") String menu_price,
            @RequestParam("menu_category") String menu_category,
            @RequestParam(value = "store_idx", required = false) Integer store_idx){
		logger.info("메뉴이름:"+menu_name+", 메뉴가격:"+menu_price+", 메뉴카테고리:"+menu_category+", store_idx:"+store_idx);
		StoreMenuDTO menuDTO = new StoreMenuDTO();
		menuDTO.setMenu_category(menu_category);
		menuDTO.setMenu_price(menu_price);
		menuDTO.setMenu_name(menu_name);
		menuDTO.setStore_idx(store_idx);
		join_ser.menudo(file, menuDTO);
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		return response;
	}
	
	@GetMapping(value="/menulist")
	@ResponseBody
	public Map<String, Object> menulist(@RequestParam(value = "store_idx", required = false) Integer store_idx){
		logger.info("idx 값:{} ",store_idx);	
		List<PhotoDTO> photodto = photo_ser.menulist(store_idx, 2);
		List<StoreMenuDTO> menudto = join_ser.menulist(store_idx);
		Map<String, Object> map = new HashMap<>();
		map.put("menulist", menudto);
		map.put("menuphoto", photodto);
		return map;
	}
	
}
