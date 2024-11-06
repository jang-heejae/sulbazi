package com.sulbazi.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.ReviewCategoryDTO;
import com.sulbazi.member.UserDTO;
import com.sulbazi.photo.PhotoDAO;

@Service
public class ReviewService {
	@Autowired ReviewDAO review_dao;
	@Autowired PhotoDAO photo_dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public String reportedIdx(int reported_idx) {
		return review_dao.reportedIdx(reported_idx);
	}

	public Map<String, Object> getReviewAlluser(int storeIdx) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReviewDTO> reviewsOfStore = review_dao.getReviewAlluser(storeIdx);
		logger.info("리뷰 이종원 씀 보자 : {} ",storeIdx);
		logger.info("리뷰 이종원 씀 보자 : {} ",reviewsOfStore);
		map.put("reviews", reviewsOfStore);
//		testGetReviewAlluser();
		return map;
	}
	//아쟉스 통신 테스트용
//	public void testGetReviewAlluser() {
//	    int testStoreIdx = 1; // 테스트할 storeIdx 설정
//	    List<ReviewDTO> reviews = review_dao.getReviewAlluser(testStoreIdx);
//	    if (reviews != null && !reviews.isEmpty()) {
//	        for (ReviewDTO review : reviews) {
//	            System.out.println("리뷰 내용: " + review.getReview_idx());
//	        }
//	    } else {
//	        System.out.println("리뷰가 존재하지 않거나 조회 실패");
//	    }
//	}



	public int reviewWriteDo(ReviewDTO insertReview ,Map<String, String> params , boolean flag) {
		int row = review_dao.reviewWriteDo(insertReview);
		if (flag) {
			int dow = review_dao.storeAvg(params);
		}
		return row;
	}

	public Map<String, Object> reply(Map<String, String> params) {
		boolean success =false;
		
		Map<String, Object> map = new HashMap<String, Object>();
		int row = review_dao.reply(params);
		if (row>0) {
			success=true;
		}
		map.put("success", success);
		return map;
	}

	public Map<String, Object> replyUpdate(Map<String, String> params) {
		boolean success =false;
		
		Map<String, Object> map = new HashMap<String, Object>();
		int row = review_dao.replyUpdate(params);
		if (row>0) {
			success=true;
		}
		map.put("success", success);
		return map;
	}

	public Map<String, Object> replyDel(Map<String, String> params) {
		boolean success =false;
		
		Map<String, Object> map = new HashMap<String, Object>();
		int row = review_dao.replyDel(params);
		if (row>0) {
			success=true;
		}
		map.put("success", success);
		return map;
	}

	public int reviewUpdate(Map<String, String> params) {
		int row = review_dao.reviewUpdate(params);
		
		int dow = review_dao.storeAvg(params);
		return row;
	}

	public int reviewDelUpdate(Map<String, String> params) {
		int row = review_dao.reviewDelUpdate(params);
		return row;
	}

	
	public int reviewLike(Map<String, String> params) {
		int row = 0;
		int dow = review_dao.reviewCount(params);
		if (dow>=1) {
			int sow = review_dao.reviewLikeDel(params);
		}else {
			row =  review_dao.reviewLike(params);
		}
		return row;
	}

	//매장 마이페이지 리뷰
	public List<Map<String, Object>> storelookreview(int store_idx) {
	    // 리뷰 리스트 가져오기
	    List<ReviewDTO> reviewlist = review_dao.storelookreview(store_idx);
	    List<Map<String, Object>> reviewMapList = new ArrayList<>(); // 리뷰를 담을 리스트
	    boolean photoexist = false;

	    // 각 리뷰를 Map으로 변환하여 리스트에 추가
	    for (ReviewDTO reviewdto : reviewlist) {
	        Map<String, Object> reviewMap = new HashMap<>();
	        reviewMap.put("review_idx", reviewdto.getReview_idx());
	        List<Integer> row = photo_dao.reviewphotoexist(reviewdto.getReview_idx());
	        if(row != null) {
	        	photoexist = true;
	        }
	        reviewMap.put("Starpoint", reviewdto.getStarpoint());
	        String uesrname = review_dao.reviewusername(reviewdto.getUser_id());
	        reviewMap.put("user_name", uesrname);
	        reviewMap.put("store_idx", reviewdto.getStore_idx());
	        reviewMap.put("review_content", reviewdto.getReview_content());
	        reviewMap.put("review_date", reviewdto.getReview_date());
	        reviewMap.put("photoexist", photoexist);

	        reviewMapList.add(reviewMap); // 변환한 Map을 리스트에 추가
	        logger.info("map확인:{}",reviewMap);
	    }
	    
	    return reviewMapList; // 리스트 반환
	}


	//매장 마이페이지 댓글
	public List<Map<String, Object>> storelookreply(int store_idx) {
	    // 리뷰 댓글 리스트 가져오기
	    List<ReviewCommDTO> reviewlist = review_dao.storelookreply(store_idx);
	    List<Map<String, Object>> replyMapList = new ArrayList<>(); // 댓글을 담을 리스트

	    // 각 댓글을 Map으로 변환하여 리스트에 추가
	    for (ReviewCommDTO reviewCommdto : reviewlist) {
	        Map<String, Object> replyMap = new HashMap<>();
	        replyMap.put("comm_content", reviewCommdto.getComm_content());
	        replyMap.put("review_idx", reviewCommdto.getReview_idx());
	        replyMap.put("store_idx", reviewCommdto.getStore_idx());
	        replyMap.put("comm_date", reviewCommdto.getComm_date());

	        replyMapList.add(replyMap); // 변환한 Map을 리스트에 추가
	        logger.info("map확인:{}",replyMap);
	    }

	    return replyMapList; // 리스트 반환
	}



}
