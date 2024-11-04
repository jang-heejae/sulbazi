package com.sulbazi.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.category.ReviewCategoryDTO;
import com.sulbazi.member.UserDTO;

@Mapper
public interface ReviewDAO {

	String reportedIdx(int reported_idx);

	List<ReviewDTO> getReviewAlluser(int storeIdx);

	int reviewWriteDo(ReviewDTO insertReview);

	int reply(Map<String, String> params);

	int allCount(Map<String, Object> param);

	List<ReviewDTO> userReview(Map<String, Object> param);

	

	
}
