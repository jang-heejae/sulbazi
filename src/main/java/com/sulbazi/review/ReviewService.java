package com.sulbazi.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
	@Autowired ReviewDAO review_dao;
	
	public String reportedIdx(int reported_idx) {
		return review_dao.reportedIdx(reported_idx);
	}

}
