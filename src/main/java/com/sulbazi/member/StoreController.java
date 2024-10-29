package com.sulbazi.member;




import java.util.List;

import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
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
<<<<<<< HEAD
import com.sulbazi.category.CategoryService;
=======
>>>>>>> origin/master
import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class StoreController {


	@Autowired StoreService store_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PhotoService photo_ser;
	@Autowired BoardService board_ser;
	@Autowired CategoryService category_ser;
	
	@RequestMapping(value="/storeMain.go")
	public String storeMain() {
		return "main/storeMain";
	}
	
	
	
	@RequestMapping(value="/storeDetail.do")
    public String getStoreDetail(int idx, Model model, HttpSession session) {
        StoreDTO storeDetail = store_ser.getStoreDetail(idx);
        PhotoDTO file= store_ser.getStorePhoto(idx);
        List<PhotoDTO> files= store_ser.getStorePhotos(idx);
        BoardDTO boardList = store_ser.getBoard(idx);
        List<CategoryOptDTO> storeOverviews = store_ser.getStoreExplain(idx);


        model.addAttribute("store", storeDetail);
        model.addAttribute("files", files);
        model.addAttribute("file", file);
        model.addAttribute("board", boardList);
        model.addAttribute("storeidx",idx);
        model.addAttribute("storeOverviews",storeOverviews);
        logger.info("storeDetail: " + storeDetail);
        return "store/storeDetail";
  
    }
	
	
	@RequestMapping(value="/menu.do")
    public String storeMenu1(int idx, Model model, HttpSession session) {
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
    public String storeMenu2(int idx, Model model, HttpSession session) {
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
		
		return store_ser.bookmarkCheck(loginId,storeidx);
	}

<<<<<<< HEAD
	
=======
>>>>>>> origin/master
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
            List<CategoryOptDTO> categoryOpts = store_ser.findStoreCategorys(stores);
            List<StoreCategoryDTO> storeCategorys = store_ser.storeHelpMeIdx(stores);
//            List<CategoryOptDTO> categoryOpts = store_ser.findCategotyOpts(storeCategorys);
            

            
            
            
//            for (CategoryOptDTO categoryOptDTO : categoryOpts) {
//            	int i = categoryOptDTO.getOpt_idx();
//            	String c = categoryOptDTO.getOpt_name();
//            	
//            	System.out.println("카태고리"+i+':'+ c );
//            			
//			}

//            List<Integer> storeIdxCategory = new ArrayList<>();
//            
//            for (StoreDTO  storedto : stores) {
//				int c = storedto.getStore_idx();
//				System.out.println(c);
//				
//				storeIdxCategory.add(c);
//			}
            
        
//            for (StoreCategoryDTO sc : storeCategorys) {
//            	int asd = sc.getOpt_idx();
//            	int dsa = sc.getStore_idx();
//            	
//            	System.out.println("카테고리 디폴트 store:"+dsa+" : "+asd);
//			}
            
            
            
//            for (CategoryOptDTO categoryOptDTO : categoryOpts) {
//					int a = categoryOptDTO.getOpt_idx();
//					int b = categoryOptDTO.getCategory_idx();
//					String c = categoryOptDTO.getOpt_name();
//					
//					//System.out.println("카테고리: " +a+" : "+b+" : "+c);
//					logger.info("카테고리 :{}",categoryOptDTO);
//			}
            
            
            

            
            
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
<<<<<<< HEAD


	
=======

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
>>>>>>> origin/master

	@RequestMapping(value="/storeList.go")
	public String storelist(Model model) {
	    List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1); // category_state가 1인 옵션만 가져오기
	    model.addAttribute("options", options);
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
	
	
	//매장 마이페이지
	@RequestMapping(value="/storeMyPage.go")
	public String storemypage(Model model, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
		logger.info("store_idx:{}",store_idx);
		model.addAttribute("store_idx", store_idx);
		List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);//활성화된 카테고리
		logger.info("options: {}",options);
		model.addAttribute("options", options);
		StoreDTO storedto = store_ser.mystore(store_idx); 
		logger.info("storedto: {}", storedto);
	    List<Integer> selectedValues = store_ser.mystoreopt(store_idx);
	    PhotoDTO mystorebestphoto = photo_ser.mystorebestphoto(store_idx);
	    List<PhotoDTO> mystorephoto = photo_ser.mystorephoto(store_idx);
	    logger.info("selectedValues:{}",selectedValues);
	    model.addAttribute("mystorebestphoto", mystorebestphoto);
	    model.addAttribute("mystorephoto", mystorephoto);
	    model.addAttribute("selectedValues", selectedValues);
	    model.addAttribute("storedto", storedto);
		return "store/storeMyPage";
	}
	
	
	//매장 마이페이지 수정
	@RequestMapping(value="/mystoreUpdate.go")
	public String mystoreupdatego(Model model, String idx, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
		logger.info("store_idx:{}",store_idx);
		model.addAttribute("store_idx", store_idx);
		List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);//활성화된 카테고리
		logger.info("options: {}",options);
		model.addAttribute("options", options);
		StoreDTO storedto = store_ser.mystore(store_idx); 
		logger.info("storedto: {}", storedto);
	    List<Integer> selectedValues = store_ser.mystoreopt(store_idx);
	    PhotoDTO mystorebestphoto = photo_ser.mystorebestphoto(store_idx);
	    List<PhotoDTO> mystorephoto = photo_ser.mystorephoto(store_idx);
	    logger.info("selectedValues:{}",selectedValues);
	    model.addAttribute("mystorebestphoto", mystorebestphoto);
	    model.addAttribute("mystorephoto", mystorephoto);
	    model.addAttribute("selectedValues", selectedValues);
	    model.addAttribute("storedto", storedto);
		return "store/storeMyPageUpdate";	
	}
	
	@PostMapping(value="/mystoreUpdate.do")
	public String mystoreupdatedo(MultipartFile[] newmystoreinout,MultipartFile[] bestmystore, @RequestParam Map<String, String> params,Model model, HttpSession session) throws IOException {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
		logger.info("store_idx:{}",store_idx);
		logger.info("params:{}",params);
		store_ser.mystoreupdate(params, store_idx);
		category_ser.mystoreoptupdate(params, store_idx);
		photo_ser.mystorebestphotoupdate(bestmystore, store_idx);
		photo_ser.mystoreinoutUpdate(newmystoreinout, store_idx);
		return "redirect:/storeMyPage.go";
	}
	
	
	
	
	
	
	
	//나의 매장 리뷰 댓글
	@RequestMapping(value="/storeMyReview.go")
	public String storemyreview() {
		return "store/storeReview";
	}
	
	
	
	//매장 나의 홍보글
	@RequestMapping(value="/storeMyBoard.go")
	public String storemyboard(Model model, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
		List<BoardDTO> myboard =store_ser.storemyboard(store_idx);
		model.addAttribute("myboard", myboard);
		return "store/storeBoard";
	}
	

	
	//매장 나의 메뉴 가기
	@RequestMapping(value="/storeMyMenu.go")
	public String storemymenu() {		
		return "store/storeMyMenu";
	}


    @GetMapping("/menuFiltering.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> filterMenu(
            @RequestParam("menu_category") String menuCategory, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
        // 서비스에서 필터링된 메뉴 및 사진 리스트 가져오기
    	List<StoreMenuDTO> menulist = store_ser.storemenulist(store_idx);
    	List<PhotoDTO> menuphoto = photo_ser.storemenuphoto(store_idx);
        // 결과를 JSON 형식으로 변환하여 반환
        Map<String, Object> response = new HashMap<>();
        response.put("menulist", menulist);
        response.put("menuphoto", menuphoto);
        return ResponseEntity.ok(response);
    }
	
    @GetMapping("/alcholmenuFiltering.ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> alcholfilterMenu(
            @RequestParam("menu_category") String menuCategory, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
        // 서비스에서 필터링된 메뉴 및 사진 리스트 가져오기
		List<StoreMenuDTO> menulist = store_ser.storealcholmenulist(store_idx);
		List<PhotoDTO> menuphoto = photo_ser.alcholmenuphoto(store_idx);
        // 결과를 JSON 형식으로 변환하여 반환
        Map<String, Object> response = new HashMap<>();
        response.put("menulist", menulist);
        response.put("menuphoto", menuphoto);
        return ResponseEntity.ok(response);
    }
	
	
    @PostMapping(value="/menuUpdate.ajax")
    @ResponseBody
    public String menuupdate(@RequestParam Map<String, String> map) {
    	String menu_idx = map.get("menu_idx"); // 메뉴 인덱스
        String menu_name = map.get("menu_name"); // 메뉴 이름
        String menu_price = map.get("menu_price"); // 메뉴 가격
        boolean isUpdated = store_ser.menuupdate(menu_name, menu_price,menu_idx);
        return isUpdated ? "{\"success\": true}" : "{\"success\": false, \"message\": \"수정 실패\"}";
    }

    @PostMapping(value="/menuDelete.ajax")
    @ResponseBody
    public String menudelete(@RequestParam Map<String, String> map) {
    	String menu_idx = map.get("menu_idx"); // 메뉴 인덱스
    	String menu_category = map.get("menu_category");
    	photo_ser.totalmenudelete(menu_category, menu_idx);
        boolean isUpdated = store_ser.menudelete(menu_idx);
        return isUpdated ? "{\"success\": true}" : "{\"success\": false, \"message\": \"수정 실패\"}";
    }
	
	
    @PostMapping(value="/menuInsert.do")
    public String menuinsert(@RequestParam("files") MultipartFile[] files, @RequestParam Map<String, String> params, HttpSession session) {
        boolean success = false;
        logger.info("params: {}", params);
        logger.info("file count: " + files.length);

        int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
        if(store_ser.menuinsert(files, store_idx, params) > 0) {
            success = true;
        }
        logger.info("Success status: " + success);
        return "store/storeMyMenu";
    }
	
	
	
	
	
	
}

