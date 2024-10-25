package com.sulbazi.member;

import java.io.IOException;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.photo.PhotoService;

@Service
public class JoinService {
	@Autowired JoinDAO join_dao;
	@Autowired PhotoService photo_ser;
	   Logger logger = LoggerFactory.getLogger(getClass());

		@Transactional
		 public int storeJoin(MultipartFile[] files, Map<String, String> param) {
			 StoreDTO dto = new StoreDTO(); 
			 dto.setStore_id(param.get("store_id"));
			 dto.setStore_pw(param.get("store_pw"));
			 dto.setStore_name(param.get("store_name"));
			 dto.setStore_number(param.get("store_number"));
			 dto.setStore_phone(param.get("store_phone"));
			 dto.setStore_time(param.get("store_time"));
			 dto.setStore_address(param.get("store_address")); 
			 int row = join_dao.storeJoin(dto);
			 int store_idx = dto.getStore_idx();
			 if(store_idx > 0 && row >0) {
				 try {
					photo_ser.fileSave(files, store_idx, 1);
				} catch (IOException e) {
					e.printStackTrace();
				} 
			 } 
			 logger.info("{Join store_idx}:"+store_idx);
			 logger.info("{row}:"+row);
			 return store_idx; 
		 }
		 

		/*
		 * public void storeJoin(StoreDTO dto) { join_dao.storeJoin(dto); }
		 */


}
