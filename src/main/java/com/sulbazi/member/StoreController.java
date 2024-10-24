package com.sulbazi.member;




import java.util.List;

import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class StoreController {


	@Autowired StoreService store_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PhotoService photo_ser;

	@RequestMapping(value="/storeDetail.go")
    public String getStoreDetail(int idx, Model model, HttpSession session) {
        StoreDTO storeDetail = store_ser.getStoreDetail(idx);
        model.addAttribute("store", storeDetail);
        logger.info("storeDetail: " + storeDetail);
        return "store/storeDetail";
  
    }
	
	
	@RequestMapping(value="/menu.go")
    public String storeMenu1(int idx, Model model, HttpSession session) {
        List<PhotoDTO> files= store_ser.fileList(idx);
        logger.info("files list size: {}", files.size());
        for (PhotoDTO f : files) {
            logger.info("PhotoDTO: {}", f);
            System.out.println(f.getNew_filename());
        }
        List<StoreMenuDTO> storeMenu = store_ser.getStoreMenuById(idx);
		model.addAttribute("files",files);
		model.addAttribute("storeMenu",storeMenu);
		model.addAttribute("store",idx);
        return "store/storeMenu";
  
    }
	/*
	 * @RequestMapping(value="/menu2.go") public String storeMenu2(int idx, Model
	 * model, HttpSession session) { = store_ser.(idx);
	 * 
	 * model.addAttribute("store", storeDetail);
	 * model.addAttribute("file",storeDetail); logger.info("storeDetail: " +
	 * storeDetail); return "store/storeMenu2";
	 * 
	 * }
	 */

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

