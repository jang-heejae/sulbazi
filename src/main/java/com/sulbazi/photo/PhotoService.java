package com.sulbazi.photo;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class PhotoService {
	
	@Autowired PhotoDAO photo_dao;
	
	@Value("${upload.path}") private String bpath;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	/*
	 * public void fileSave(MultipartFile[] files, int store_idx, int cti) {
	 * try {
	 * for (MultipartFile file : files) {
	 * String ori = file.getOriginalFilename();
	 * int ext = ori.lastIndexOf(".");
	 * if(ext != -1) { String extt =
	 * ori.substring(ext); String newfile = UUID.randomUUID()+extt; Path path =
	 * Paths.get(bpath+newfile); byte[] arr = file.getBytes(); Files.write(path,
	 * arr); photo_dao.fileSave(store_idx, newfile, cti); } } } catch (IOException
	 * e) { e.printStackTrace(); } }
	 */
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

	public PhotoDTO mystorebestphoto(int store_idx) {
		return photo_dao.mystorebestphoto(store_idx);
	}

	public List<PhotoDTO> mystorephoto(int store_idx) {
		return photo_dao.mystorephoto(store_idx);
	}

}
