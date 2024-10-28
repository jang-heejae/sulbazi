package com.sulbazi.photo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PhotoController {
	@Autowired PhotoService photo_ser;
	
	// 유저 이미지 가져오기
	@RequestMapping(value="/photo/{user_photo}")
	public ResponseEntity<Resource> photo(@PathVariable String user_photo) {
		return photo_ser.getImg(user_photo);
	}
}
