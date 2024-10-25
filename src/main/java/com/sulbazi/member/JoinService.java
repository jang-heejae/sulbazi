package com.sulbazi.member;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.CategoryDAO;
import com.sulbazi.category.CategoryOptDTO;
import com.sulbazi.category.CategoryService;
import com.sulbazi.photo.PhotoService;

@Service
public class JoinService {
	@Autowired JoinDAO join_dao;
	@Autowired PhotoService photo_ser;
	@Autowired CategoryService category_ser;
	@Autowired CategoryDAO category_dao;
	@Value("${upload.path}") private String bpath;
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

		public int userJoindo(MultipartFile files, Map<String, String> params) {
			UserDTO userDTO = new UserDTO();
		    userDTO.setUser_id(params.get("user_id"));
		    userDTO.setUser_pw(params.get("user_pw"));
		    userDTO.setUser_nickname(params.get("user_nickname"));
		    userDTO.setUser_name(params.get("user_name"));
		    userDTO.setUser_gender(params.get("user_gender"));
		    userDTO.setUser_birth(params.get("user_birth"));
		    userDTO.setUser_phone(params.get("user_phone"));
		    userDTO.setUser_email(params.get("user_email"));
			String photo = "";
			try {
				String ori = files.getOriginalFilename();
				int ext = ori.lastIndexOf(".");
				String extt = ori.substring(ext);
				photo = UUID.randomUUID()+extt;
				Path path = Paths.get(bpath+photo);
				byte[] arr;
					arr = files.getBytes();
				Files.write(path, arr);
			} catch (IOException e) {
				e.printStackTrace();
			}
			userDTO.setUser_photo(photo);
			int row = join_dao.userJoindo(userDTO);
			String user_id = userDTO.getUser_id();
			logger.info("성공한 row 값 : " + row + "가져온 user_id : " + user_id);
			logger.info("파일 이름 : " + photo);
			if(user_id != null && row > 0) {
				category_ser.userJoindo(user_id);
			}
			return 0;
		}

}
