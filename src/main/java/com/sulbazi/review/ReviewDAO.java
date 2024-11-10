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

	int replyUpdate(Map<String, String> params);

	int replyDel(Map<String, String> params);

	int storeAvg(Map<String, String> params);

	int reviewUpdate(Map<String, String> params);

	int reviewDelUpdate(Map<String, String> params);

	int reviewLike(Map<String, String> params);

	int reviewCount(Map<String, String> params);

	int reviewLikeDel(Map<String, String> params);
	
	int allCount(Map<String, Object> param);

	List<ReviewDTO> userReview(Map<String, Object> param);

	List<ReviewDTO> storelookreview(int store_idx);

	List<ReviewCommDTO> storelookreply(int store_idx);

	String reviewusername(String user_id);

	List<ReviewDTO> dontWrite(Map<String, Object> params);

	int allStoreCount(Map<String, Object> param);

	List<ReviewDTO> getReviewAlluser2(Map<String, Object> param);

	int updateReviewTotal(Map<String, String> params);

	

	
}
