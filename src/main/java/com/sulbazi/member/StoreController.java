package com.sulbazi.member;




import java.util.List;

import javax.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sulbazi.board.BoardDTO;
import com.sulbazi.board.BoardService;
import com.sulbazi.category.CategoryDTO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class StoreController {


	@Autowired StoreService store_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PhotoService photo_ser;
	@Autowired BoardService board_ser;
	
	@RequestMapping(value="/storeDetail.do")
    public String getStoreDetail(int storeidx, Model model, HttpSession session) {
		int idx = storeidx;
        StoreDTO storeDetail = store_ser.getStoreDetail(idx);
        PhotoDTO file= store_ser.getStorePhoto(idx);
        List<PhotoDTO> files= store_ser.getStorePhotos(idx);
        BoardDTO boardList = store_ser.getBoard(idx);
        List<CategoryOptDTO> storeOverviews = store_ser.getStoreExplain(idx);



        model.addAttribute("store", storeDetail);
        model.addAttribute("files", files);
        model.addAttribute("file", file);
        model.addAttribute("board", boardList);
		/* model.addAttribute("storeidx",idx); */
        model.addAttribute("storeOverviews",storeOverviews);
        logger.info("storeDetail: " + storeDetail);
        return "store/storeDetail";
  
    }
	
	
	@RequestMapping(value="/menu.do")
    public String storeMenu1(int storeidx, Model model, HttpSession session) {
		int idx = storeidx;
        List<PhotoDTO> files= store_ser.fileList(idx);
        logger.info("files list size: {}", files.size());
        for (PhotoDTO f : files) {
            logger.info("PhotoDTO: {}", f);
            System.out.println(f.getNew_filename());
        }
        List<StoreMenuDTO> storeMenu = store_ser.getStoreMenuById(idx);
        for (StoreMenuDTO storeMenuDTO : storeMenu) {
        	Object som =  storeMenuDTO.getMenu_name();
        	System.out.println(som);
			
		}
		model.addAttribute("files",files);
		model.addAttribute("storeMenu",storeMenu);
		model.addAttribute("store",idx);
        return "store/storeMenu";
  
    }
	
	@RequestMapping(value="/menu2.do")
    public String storeMenu2(int storeidx, Model model, HttpSession session) {
		int idx = storeidx;
        List<PhotoDTO> files= store_ser.alcoholFileList(idx);
        logger.info("files list size: {}", files.size());
        for (PhotoDTO f : files) {
            //logger.info("PhotoDTO: {}", f);
            //System.out.println(f.getNew_filename());
        }
        List<StoreMenuDTO> storeAlcohol = store_ser.getStoreAlcohol(idx);
		model.addAttribute("files",files);
		model.addAttribute("storeAlcohol",storeAlcohol);
		model.addAttribute("store",idx);
        return "store/storeMenu2";
  
    }
	
	@PostMapping(value="/bookmark.ajax")
	@ResponseBody
	public Map<String, Object> bookmarkCheck(String loginId,int storeidx ){
		System.out.println(storeidx);
		System.out.println(loginId);
		return store_ser.bookmarkCheck(loginId,storeidx);
	}
	
    @GetMapping(value = "/list.ajax")
    @ResponseBody
    public ResponseEntity<?> storeList(
            @RequestParam("page") int page,
            @RequestParam("cnt") int cnt,
            @RequestParam("minLat") double minLat,
            @RequestParam("maxLat") double maxLat,
            @RequestParam("minLng") double minLng,
            @RequestParam("maxLng") double maxLng) {

        try {
            // 서비스 계층을 통해 데이터 가져오기
            List<StoreDTO> stores = store_ser.getStoresInArea(minLat, maxLat, minLng, maxLng, page, cnt);
            int totalPages = store_ser.getTotalPages(minLat, maxLat, minLng, maxLng, cnt);
            List<PhotoDTO> photoList = store_ser.findPhotosForStores(stores);
            List<StoreCategoryDTO> storeCategorys = store_ser.findStoreCategorys(stores);
            List<CategoryOptDTO> categoryOpts = store_ser.findCategotyOpts(storeCategorys);
            
            // 응답 데이터 구성
            Map<String, Object> response = new HashMap<>();
            response.put("list", stores);
            response.put("totalpages", totalPages);
            response.put("photos", photoList);
            response.put("storeCategorys", storeCategorys);
            response.put("categoryOpts", categoryOpts);
            
            
            // 200 OK와 함께 데이터 반환
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // 예외 발생 시 500 INTERNAL_SERVER_ERROR 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while retrieving store data");
        }
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

