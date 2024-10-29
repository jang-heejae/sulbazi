package com.sulbazi.photo;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.category.StoreCategoryDTO;
import com.sulbazi.inquery.InqueryDTO;

@Service
public class PhotoService {
	
	@Autowired PhotoDAO photo_dao;
	
	@Value("${upload.path}") private String bpath;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public void fileSave(MultipartFile[] files, int store_idx, int cti) throws IOException {
		logger.info("받은 cti 값: " + cti);
		String filePath = storeFile(files);
        PhotoDTO photoDTO = new PhotoDTO();
        photoDTO.setPhoto_category_idx(cti);
        photoDTO.setPhoto_folder_idx(store_idx);
        photoDTO.setNew_filename(filePath);
        photo_dao.fileSave(photoDTO);
        logger.info("{photoDTO}:"+photoDTO);
    }

    private String storeFile(MultipartFile[] files) throws IOException {
    	String newfile = "";
    	try {
			for (MultipartFile file : files) {
				String ori = file.getOriginalFilename();
				int ext = ori.lastIndexOf(".");
				String extt = ori.substring(ext);
				newfile = UUID.randomUUID()+extt;
				Path path = Paths.get(bpath+newfile);
				byte[] arr = file.getBytes();
				Files.write(path, arr);
			}
		} catch (IOException e) {
				e.printStackTrace();
			}
    	logger.info("{newfile}:"+newfile);
        return newfile; 
    }

	public List<PhotoDTO> inqueryphoto(int inqueryIdx) {
		return photo_dao.inqueryphoto(inqueryIdx);
	}

 
	public void filesaveone(MultipartFile fileone, int store_idx, int i) {
		String photo = "";
		try {
			String ori = fileone.getOriginalFilename();
			int ext = ori.lastIndexOf(".");
			String extt = ori.substring(ext);
			photo = UUID.randomUUID()+extt;
			Path path = Paths.get(bpath+photo);
			byte[] arr;
				arr = fileone.getBytes();
			Files.write(path, arr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		PhotoDTO photodto = new PhotoDTO();
		photodto.setNew_filename(photo);
		photodto.setPhoto_folder_idx(store_idx);
		photodto.setPhoto_category_idx(i);
		photo_dao.fileSave(photodto);
	}
		

	public PhotoDTO mystorebestphoto(int store_idx) {
		return photo_dao.mystorebestphoto(store_idx);
	}

	public List<PhotoDTO> mystorephoto(int store_idx) {
		return photo_dao.mystorephoto(store_idx);

	}
	
	// 유저 이미지 가져오기
	public ResponseEntity<Resource> getImg(String user_photo) {
		Resource reso = new FileSystemResource(bpath+user_photo);
		HttpHeaders header = new HttpHeaders();
		try {
			String type = Files.probeContentType(Paths.get(bpath+user_photo));
			header.add("content-type", type);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(reso, header, 200);
	}

	public void mystorebestphotoupdate(MultipartFile[] files, int store_idx) {
		int i = 1;
		storeupdatephoto(files, store_idx, i);
				
	}

	public void mystoreinoutUpdate(MultipartFile[] files, int store_idx) throws IOException {
		int cti = 7;
		storeupdatephoto(files, store_idx, cti);
		
	}

	public void storeupdatephoto(MultipartFile[] inqueryfiles,int store_idx,int photocategory) {
//		PhotoDTO storephodo_dto = new PhotoDTO();
//	
//		int row = photo_dao.storeupdatephoto(storephodo_dto);
//		if (store_idx>0 && row>0) {
			savestoreupdate(inqueryfiles,store_idx, photocategory);
//		}
//		return store_idx;
	}
	
	private void savestoreupdate(MultipartFile[] files, int photofolderidx, int photocategory) {
		try {
			logger.info("file length : {}",files.length);				
			for (MultipartFile file : files) {
				logger.info("file 비어있나? : "+file.isEmpty());					
				String ori_filename = file.getOriginalFilename();
				logger.info("파일명 : "+ori_filename);
				
				int pos = ori_filename.lastIndexOf(".");
				
				if(pos>=0) {
					String ext = "";				
					ext = ori_filename.substring(pos);						
					String newFileName = UUID.randomUUID().toString()+ext;		
					byte[] arr = file.getBytes();
					Path path = Paths.get("C:/upload/"+newFileName);
					Files.write(path,arr);
					photo_dao.storephotoupdate(photocategory, newFileName,photofolderidx);						
				}					
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}


}
