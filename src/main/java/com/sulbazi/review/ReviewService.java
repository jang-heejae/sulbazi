package com.sulbazi.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		List<UserDTO> userInfo = review_dao.getUserName(reviewsOfStore);
		
		
		
		map.put("reviews", reviewsOfStore);
		logger.info("리뷰 이종원 씀 보자 : {} ",reviewsOfStore);
		return map;
	}

}
