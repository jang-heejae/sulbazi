package com.sulbazi.category;

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
public class CategoryController {
@Autowired CategoryService category_ser;
	
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
		return "admin/categoryAdd";
	 }
}
