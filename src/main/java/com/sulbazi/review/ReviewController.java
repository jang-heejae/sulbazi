package com.sulbazi.review;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.CategoryService;
import com.sulbazi.category.ReviewCategoryDTO;
import com.sulbazi.photo.PhotoService;


@Controller
public class ReviewController {

	@Autowired ReviewService review_ser;
	@Autowired PhotoService photo_ser;
	@Autowired CategoryService category_ser;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
    @PostMapping(value = "/storeReviewWrite.ajax")
    @ResponseBody
    public Map<String, Object> reviewWriteDo(MultipartFile[] files, @RequestParam Map<String, String> params){
    		boolean success =false;
/*				'ratingValue':ratingValue,
				'purposeValue':purposeValue,
				'moodValue':moodValue,
				'reviewContent':reviewContent,
				'loginId':loginId,
				'storeIdx':storeIdx,*/
//    		logger.info("종원 files 받기 :{}",(Object[])files);
//    		logger.info("종원 files 받기 :{}",files.length);
    		ReviewDTO insertReview = new ReviewDTO();
    		insertReview.setUser_id(params.get("loginId"));
    		insertReview.setStore_idx(Integer.parseInt(params.get("storeIdx")));
    		insertReview.setReview_content(params.get("reviewContent"));
    		insertReview.setStarpoint(Integer.parseInt(params.get("ratingValue")));
    		
    		int purposeValue = Integer.parseInt(params.get("purposeValue"));
    		int moodValue = Integer.parseInt(params.get("moodValue"));
    		
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		int row= review_ser.reviewWriteDo(insertReview);
    		
    		int photo_category_idx=3;
    		int idx=insertReview.getReview_idx();
    		if (idx>0) {
				success=true;
			}
    		if (files != null && files.length > 0) {
				photo_ser.storeupdatephoto(files,idx,photo_category_idx);
				
			}
    		int opt = category_ser.insertOption(purposeValue,moodValue,idx);
    		map.put("success", success);
    		
    	return map;
    }
    
    @PostMapping(value = "/storeReviewReply.ajax")
    @ResponseBody
    public Map<String, Object> storeReviewReply(@RequestParam Map<String, String> params){
    	
    	
    	return review_ser.reply(params);
    }
	
	
}
