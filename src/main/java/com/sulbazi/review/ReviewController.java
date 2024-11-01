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
    public Map<String, Object> reviewWriteDo(MultipartFile[] files,@RequestBody Map<String, Object> params) throws IOException{
    		
/*				'ratingValue':ratingValue,
				'purposeValue':purposeValue,
				'moodValue':moodValue,
				'reviewContent':reviewContent,
				'loginId':loginId,
				'storeIdx':storeIdx,*/
    		ReviewDTO insertReview = new ReviewDTO();
    		insertReview.setUser_id((String) params.get("loginId"));
    		insertReview.setStore_idx((int) params.get("storeIdx"));
    		insertReview.setReview_content((String) params.get("loginId"));
    		insertReview.setStarpoint((int) params.get("loginId"));
    		
    		int purposeValue = (int) params.get("purposeValue");
    		int moodValue = (int) params.get("moodValue");
    		
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		int row= review_ser.reviewWriteDo(insertReview);
    		int cti=3;
    		int idx=insertReview.getReview_idx();
    		photo_ser.fileSave(files,idx,cti);
    		int opt = category_ser.insertOption(purposeValue,moodValue,idx);
    		map.put("row", row);
    		map.put("opt", opt);
    		
    	return map;
    }
	
	
	
}
