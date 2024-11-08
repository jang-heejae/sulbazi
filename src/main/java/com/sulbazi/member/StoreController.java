package com.sulbazi.member;




import java.util.List;

import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.security.Provider.Service;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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

import com.sulbazi.category.CategoryService;

import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;
import com.sulbazi.review.ReviewService;

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
	@Autowired ReviewService review_ser;

	
	
	
	//매장 상세보기
	@RequestMapping(value="/storeDetail.do")
    public String getStoreDetail(int storeidx, Model model, HttpSession session) {
		if (session.getAttribute("loginId") != null) {
			
		
		int idx = storeidx;
		//매장 정보
        StoreDTO storeDetail = store_ser.getStoreDetail(idx);
        //매장 대표사진 가져오기
        PhotoDTO file= store_ser.getStorePhoto(idx);
        //해당 매장 사진
        List<PhotoDTO> files= store_ser.getStorePhotos(idx);
        //해당 매장 게시판 정보
        BoardDTO boardList = store_ser.getBoard(idx);
        //매장 카테고리 가져오기
        List<CategoryOptDTO> storeOverviews = store_ser.getStoreExplain(idx);
        //리뷰 카테고리 가져오기
        List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);
        model.addAttribute("options",options);
        
        
        

        model.addAttribute("store", storeDetail);
        model.addAttribute("files", files);
        model.addAttribute("file", file);
        model.addAttribute("board", boardList);
		/* model.addAttribute("storeidx",idx); */
        model.addAttribute("storeOverviews",storeOverviews);
		/* logger.info("storeDetail: " + storeDetail); */
        return "store/storeDetail";
		}
		return "redirect:/main.go";
    }
	
	
	@RequestMapping(value="/menu.do")
    public String storeMenu1(int storeidx, Model model, HttpSession session) {
		if (session.getAttribute("loginId") != null) {
		int idx = storeidx;
        List<PhotoDTO> files= store_ser.fileList(idx);
		/* logger.info("files list size: {}", files.size()); */
        for (PhotoDTO f : files) {
			/* logger.info("PhotoDTO: {}", f); */
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
		return "redirect:/main.go";
    }
	
	@RequestMapping(value="/menu2.do")
    public String storeMenu2(int storeidx, Model model, HttpSession session) {
		if (session.getAttribute("loginId") != null) {
		int idx = storeidx;
        List<PhotoDTO> files= store_ser.alcoholFileList(idx);
//        logger.info("files list size: {}", files.size());
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
		return "redirect:/main.go";
    }
	
	@PostMapping(value="/bookmark.ajax")
	@ResponseBody
	public Map<String, Object> bookmarkCheck(@RequestParam Map<String, Object> params){

		return store_ser.bookmarkCheck(params);
	}
	@PostMapping(value="/firstMark.ajax")
	@ResponseBody
	public Map<String, Object> firstMark(@RequestParam Map<String, Object> params){

		return store_ser.firstMark(params);
	}
//	@PostMapping(value="/favoritMark.ajax")
//	@ResponseBody
//	public Map<String, Object> favoritMark(@RequestParam Map<String, Object> params ){
//
//		return store_ser.favoritMark(params);
//	}


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
			/* logger.info("매장리스트 stores: {} " , stores); */

            // 응답 데이터 구성
            Map<String, Object> response = new HashMap<>();
            response.put("list", stores);
            response.put("totalPages", totalPages);
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
    
    
    
    //매장 리뷰 페이지 보내기만함
//	@RequestMapping(value="/review.go")
//    public String reviewJoin (int storeidx, Model model, HttpSession session) {
//        return "store/review";
//    }
	//매장 리뷰 불러오기 아쟉스
	@PostMapping(value="/reviewAllUser.ajax")
	@ResponseBody
	public Map<String, Object> getReviewAllUser(@RequestParam("storeIdx") int storeIdx) {
		/* System.out.println("아쟉스 통신 성공"); */
		
		return review_ser.getReviewAlluser(storeIdx);
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
	public String storelist(Model model,HttpSession session) {
		if (session.getAttribute("loginId") != null) {
	    List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1); // category_state가 1인 옵션만 가져오기
	    model.addAttribute("options", options);
		return "store/storeList";
		}
		return "redirect:/main.go";
		
	}
	
	@GetMapping(value="/namesearch.ajax")
	@ResponseBody
	public Map<String, Object> storenamesearch(String keyword,int page,int cnt) {
//		logger.info("매장이름키워드 컨트롤러");
//		logger.info(keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		return store_ser.storenamesearch(keyword,page,cnt);
	}
	
	@GetMapping(value="/menusearch.ajax")
	@ResponseBody
	public Map<String, Object> storemenusearch(String keyword,int page,int cnt) {
//		logger.info("메뉴키워드 컨트롤러");
//		logger.info(keyword);
		/* System.out.println("이종원 페이지,cnt 확인"+page+" : "+cnt); */
		return store_ser.storemenusearch(keyword,page,cnt);
	}
	
	@GetMapping(value="/addrsearch.ajax")
	@ResponseBody
	public Map<String, Object> storeaddrsearch(String keyword,int page,int cnt) {
//		logger.info("주소키워드 컨트롤러");
//		logger.info(keyword);
		return store_ser.storeaddrsearch(keyword,page,cnt);
	}
	
	
	/*
	 * @PostMapping(value="/filtering.ajax")
	 * 
	 * @ResponseBody public Map<String,Object> storefiltering(@RequestParam
	 * Map<String, String> params,Model model) { return
	 * category_ser.storefiltering(params); }
	 */
	 
	 
	
	
	
	
	
	//매장 마이페이지
	@RequestMapping(value="/storeMyPage.go")
	public String storemypage(Model model, HttpSession session) {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
//		logger.info("store_idx:{}",store_idx);
		model.addAttribute("store_idx", store_idx);
		List<CategoryOptDTO> options = store_ser.OptionsCategoryState(1);//활성화된 카테고리
//		logger.info("options: {}",options);
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
	public String mystoreupdatedo(MultipartFile[] bestmystore, MultipartFile[] newmystoreinout, @RequestParam Map<String, String> params,Model model, HttpSession session) throws IOException {
		int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
		logger.info("store_idx:{}",store_idx);
		logger.info("params:{}",params);
		store_ser.mystoreupdate(params, store_idx);
		category_ser.mystoreoptupdate(params, store_idx);
		photo_ser.mystorebestphotoupdate(bestmystore, store_idx);
		photo_ser.mystoreinoutUpdate(newmystoreinout, store_idx);
		return "redirect:/storeMyPage.go";
	}
	@RequestMapping(value="/storeMyReview.go")
	public String storemyreply(Model model, HttpSession session) {
	    int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
	    model.addAttribute("store", store_idx);
	    return "store/storeReview";
	}
	@GetMapping(value="/storeMyReview.ajax")
	@ResponseBody
	public Map<String, Object> storeMyReview(String store_idx, String cnt, String page) {
		int store_idx_ = Integer.parseInt(store_idx);
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		return store_ser.storeMyReview(store_idx_, cnt_, page_);
	}
	/*
	 * @RequestMapping(value="/storeMyReview.go") public String storemyreply(Model
	 * model, HttpSession session) { int store_idx = store_ser.storeidx((String)
	 * session.getAttribute("loginId")); List<Map<String, Object>> reviews =
	 * review_ser.storelookreview(store_idx); List<Map<String, Object>> replies =
	 * review_ser.storelookreply(store_idx);
	 * 
	 * List<Map<String, Object>> totalReviews = new ArrayList<>();
	 * 
	 * for (Map<String, Object> review : reviews) { Map<String, Object> reviewData =
	 * new HashMap<>(); reviewData.put("review_content",
	 * review.get("review_content")); // 리뷰 내용 reviewData.put("review_date",
	 * review.get("review_date")); // 리뷰 날짜 reviewData.put("user_id",
	 * review.get("user_id")); // 리뷰 유저 reviewData.put("review_idx",
	 * review.get("review_idx")); // 리뷰 idx
	 * 
	 * // 해당 리뷰에 대한 댓글 리스트 List<Map<String, Object>> associatedReplies = new
	 * ArrayList<>(); for (Map<String, Object> reply : replies) { if
	 * (review.get("review_idx").equals(reply.get("review_idx"))) {
	 * associatedReplies.add(reply); // 리뷰에 해당하는 댓글 추가 } }
	 * 
	 * // 댓글이 없는 경우 기본 메시지 추가 if (associatedReplies.isEmpty()) { Map<String, Object>
	 * noReply = new HashMap<>(); noReply.put("comm_content", "댓글이 없습니다");
	 * noReply.put("comm_date", ""); associatedReplies.add(noReply); }
	 * 
	 * reviewData.put("replies", associatedReplies); // 댓글 리스트 추가
	 * totalReviews.add(reviewData); // 전체 리뷰 리스트에 추가 }
	 * 
	 * model.addAttribute("totalReviews", totalReviews); // 전체 리뷰 리스트 모델에 추가 return
	 * "store/storeReview"; }
	 */



	
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
    	logger.info("menu_idx: {}",map.get("menu_idx"));
    	logger.info("menu_category: {}",map.get("menu_category"));
    	String menu_category = map.get("menu_category");
    	photo_ser.totalmenudelete(menu_category, menu_idx);
        boolean isUpdated = store_ser.menudelete(menu_idx);
        return isUpdated ? "{\"success\": true}" : "{\"success\": false, \"message\": \"수정 실패\"}";
    }
	
	
    @PostMapping(value="/menuInsert.ajax")
    @ResponseBody
    public boolean menuinsert(MultipartFile[] files, @RequestParam Map<String, String> params, HttpSession session) throws IOException {
        boolean success = false;
        logger.info("params: {}", params);
        logger.info("file count: " + files.length);

        int store_idx = store_ser.storeidx((String) session.getAttribute("loginId"));
        if(store_ser.menuinsert(files, params,store_idx ) > 0) {
            success = true;
        }
        logger.info("Success status: " + success);
        return success;
    }
	
	
	
	
	
	
	
	
}


