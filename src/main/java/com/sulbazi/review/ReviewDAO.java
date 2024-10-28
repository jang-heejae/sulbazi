package com.sulbazi.review;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewDAO {

	String reportedIdx(int reported_idx);

}
