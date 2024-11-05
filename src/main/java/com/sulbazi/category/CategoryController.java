package com.sulbazi.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreService;

@Controller
public class CategoryController {
	
@Autowired CategoryService category_ser;
@Autowired StoreService store_ser;
	
Logger logger = LoggerFactory.getLogger(getClass());
 
	@RequestMapping(value="/categoryUpdate.go")
	public String goaddcate() {
		return "admin/categoryUpdate";
	}
	@GetMapping(value="/categoryList.ajax")
	@ResponseBody
	public Map<String, Object>categoryList(){
		return category_ser.categoryList();
	}
	@RequestMapping(value="/categoryAdd.go")
	public String categoryUpdate() {
		return "admin/categoryAdd";
	}
	@PostMapping(value="/categoryAdd.do")
	public String categoryAdd(@RequestParam Map<String, String>param, Model model) {
		String msg = category_ser.categoryAdd(param);
		model.addAttribute("list", msg); 
		return "admin/categoryUpdate";
	 }
	@PostMapping(value="/categoryState.ajax")
	@ResponseBody
	public Map<String, Object>categoryState(@RequestParam Map<String, Object>param){
		Map<String, Object> response = new HashMap<String, Object>();
		String category = (String) param.get("category");
		String state = (String) param.get("state");
		boolean success = category_ser.categoryState(category, state);
		response.put("success", success);
		response.put("success", false);
		return response;
	}
	

	
	 //매장 리스트 필터링
	  
	  @PostMapping(value="/filtering.ajax")
	  @ResponseBody 
	  public Map<String,Object> storefiltering(@RequestParam Map<String, String> params,Model model) {
	  
	  logger.info("매장 필터링 컨트롤러"); 
	 

	  
	  return category_ser.storefiltering(params );  
	  }
	  
	 
}
