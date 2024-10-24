package com.sulbazi.member;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.photo.PhotoService;
@Controller
public class JoinController {
	@Autowired JoinService join_ser;
	@Autowired PhotoService photo_ser;
	
	   Logger logger = LoggerFactory.getLogger(getClass());

	   @RequestMapping(value="/storeJoin.go")
	   public String storejoin() {
	      return "member/storeJoin";
	   }


		 @PostMapping(value="/storeJoin.ajax")
		 @ResponseBody
		 public Map<String, Object> storeJoin(MultipartFile[] files, @RequestParam Map<String, String> param) { 
			 Map<String, Object> map = new HashMap<String, Object>();
			 try {
				 join_ser.storeJoin(files, param); 		
				 map.put("success", true); 
				 map.put("link", "./login.go");
			} catch (Exception e) {
				map.put("success", false);
	            map.put("message", "오류가 발생했습니다: " + e.getMessage());
			}
			 return map; 
		 }

		/*
		 * @PostMapping(value="/storeJoin.ajax")
		 * 
		 * @ResponseBody public Map<String, Object> storeJoin( MultipartFile[] files,
		 * 
		 * @RequestParam Map<String, String> param) { StoreDTO dto = new StoreDTO();
		 * dto.setStore_id(param.get("store_id"));
		 * dto.setStore_pw(param.get("store_pw"));
		 * dto.setStore_name(param.get("store_name"));
		 * dto.setStore_number(param.get("store_number"));
		 * dto.setStore_phone(param.get("store_phone"));
		 * dto.setStore_time(param.get("store_time"));
		 * dto.setStore_address(param.get("store_address")); int store_idx =
		 * dto.getStore_idx(); join_ser.storeJoin(dto); try { for (MultipartFile file :
		 * files) { if(!file.isEmpty()) { photo_ser.fileSave(files, store_idx, 1); } } }
		 * catch (IOException e) { e.printStackTrace(); logger.info("{}:",e); }
		 * Map<String, Object> map = new HashMap<String, Object>(); map.put("success",
		 * true); map.put("link", "redirect:/login.go"); return map; }
		 */
	   

}
