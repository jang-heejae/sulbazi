package com.sulbazi.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.UserDTO;

@Mapper
public interface ReviewDAO {

	String reportedIdx(int reported_idx);

	List<ReviewDTO> getReviewAlluser(int storeIdx);

	
}
