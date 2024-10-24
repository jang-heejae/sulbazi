package com.sulbazi.member;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class StoreController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StoreService store_ser;
	
	@RequestMapping(value="/storeList.go")
	public String storelist() {
		return "store/storeList";
	}
	
	@GetMapping(value="/namesearch.ajax")
	@ResponseBody
	public Map<String, Object> storenamesearch(String keyword, Model model) {
		logger.info("매장이름키워드 컨트롤러");
		logger.info(keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchresult",store_ser.storenamesearch(keyword, model));
		return map;
	}
	
	@GetMapping(value="/menusearch.ajax")
	@ResponseBody
	public Map<String, Object> storemenusearch(String keyword,Model model) {
		logger.info("메뉴키워드 컨트롤러");
		logger.info(keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchresult",store_ser.storemenusearch(keyword, model));
		return map;
	}
	
	@GetMapping(value="/addrsearch.ajax")
	@ResponseBody
	public Map<String, Object> storeaddrsearch(String keyword, Model model) {
		logger.info("주소키워드 컨트롤러");
		logger.info(keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchresult",store_ser.storeaddrsearch(keyword, model));
		return map;
	}
	
}
