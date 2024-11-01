package com.sulbazi.review;

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

@Service
public class ReviewService {
	@Autowired ReviewDAO review_dao;
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



	public int reviewWriteDo(ReviewDTO insertReview) {
		return review_dao.reviewWriteDo(insertReview);
	}

	public Map<String, Object> reply(Map<String, String> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		int row = review_dao.reply(params);
		
		return null;
	}





}
