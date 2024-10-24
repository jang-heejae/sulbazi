package com.sulbazi.member;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

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
	

	
	

	
}