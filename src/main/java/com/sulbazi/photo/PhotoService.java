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

import com.sulbazi.member.StoreDAO;
import com.sulbazi.member.StoreMenuDTO;

@Service
public class PhotoService {
	
	@Autowired PhotoDAO photo_dao;
	@Autowired StoreDAO store_dao;
	
	@Value("${upload.path}") private String bpath;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public void fileSave(MultipartFile[] files, int idx, int cti) throws IOException {
		String filePath = storeFile(files);
        PhotoDTO photoDTO = new PhotoDTO();
        photoDTO.setPhoto_category_idx(cti);
        photoDTO.setPhoto_folder_idx(idx);
        photoDTO.setNew_filename(filePath);
        photo_dao.fileSave(photoDTO);
    }

    private String storeFile(MultipartFile[] files) throws IOException {
    	String newfile = "";
    	try {
			for (MultipartFile file : files) {
				String ori = file.getOriginalFilename();
				if (ori == null || ori.isEmpty()) {
					return "2a4ce406-3235-46b0-a641-6e02cde217ad.png";
				}
				int ext = ori.lastIndexOf(".");
				if (ext > 0) {
					String extt = ori.substring(ext);	
					newfile = UUID.randomUUID()+extt;
					Path path = Paths.get(bpath+newfile);
					byte[] arr = file.getBytes();
					Files.write(path, arr);
				}else {
					String extt = ".png";
					newfile = UUID.randomUUID()+extt;
					Path path = Paths.get(bpath+newfile);
					byte[] arr = file.getBytes();
					Files.write(path, arr);
				}
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
	
	public void menufile(MultipartFile file, int menu_idx, int i) {
		String photo = "";
		try {
			String ori = file.getOriginalFilename();
			logger.info(ori);
			int ext = ori.lastIndexOf(".");
			String extt = ori.substring(ext);
			photo = UUID.randomUUID()+extt;
			Path path = Paths.get(bpath+photo);
			byte[] arr = file.getBytes();
			Files.write(path, arr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		PhotoDTO photodto = new PhotoDTO();
		photodto.setNew_filename(photo);
		photodto.setPhoto_folder_idx(menu_idx);
		photodto.setPhoto_category_idx(i);
		photo_dao.menufile(photodto);
	}

		

	public PhotoDTO mystorebestphoto(int store_idx) {
		return photo_dao.mystorebestphoto(store_idx);
	}

	public List<PhotoDTO> mystorephoto(int store_idx) {
		return photo_dao.mystorephoto(store_idx);

	}
	public PhotoDTO mainStore(int store_idx) {
		return photo_dao.mainStore(store_idx);
		
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
		int photo_category_idx = 1;
		storeupdatephoto(files, store_idx, photo_category_idx);
				
	}

	public void mystoreinoutUpdate(MultipartFile[] files, int store_idx) throws IOException {
	    int photo_category_idx = 7;
	    storeupdatephoto(files, store_idx, photo_category_idx);
	}

	public void storeupdatephoto(MultipartFile[] files,int store_idx,int photo_category_idx) {
		savestoreinsert(files,store_idx, photo_category_idx);
	}
	
	public void menuphotoinsert(MultipartFile[] files,int store_idx,int photo_category_idx) {
		storeupdatephoto(files,store_idx, photo_category_idx);
	};
	
	 public void savestoreinsert(MultipartFile[] files, int photo_folder_idx, int photo_category_idx) { 
		 try { 
			 logger.info("file length : {}",files.length); 
		 	for(MultipartFile file : files) { 
		 		logger.info("file 비어있나? : "+file.isEmpty());
		 		String ori_filename = file.getOriginalFilename();
		 		logger.info("파일명 : "+ori_filename);
	 
		 		int pos = ori_filename.lastIndexOf(".");
	 
		 		if(pos>=0) { 
		 			String ext = ""; ext = ori_filename.substring(pos); 
		 			String new_filename = UUID.randomUUID().toString()+ext; 
		 			byte[] arr = file.getBytes();
		 			Path path = Paths.get("C:/upload/"+new_filename); 
		 			Files.write(path,arr);
		 			PhotoDTO dto = new PhotoDTO();
		 			dto.setPhoto_category_idx(photo_category_idx);
		 			dto.setNew_filename(new_filename);
		 			dto.setPhoto_folder_idx(photo_folder_idx);
		 			photo_dao.fileSave(dto);
		 		}
		 	} 
		 } catch (IOException e) { 
			 e.printStackTrace();
			 } 
		 }

	

	   //메뉴 사진
	   public List<PhotoDTO> storemenuphoto(int store_idx) {
	      List<StoreMenuDTO> menulist =store_dao.storemenulist(store_idx);
	      List<PhotoDTO> menuphoto = new ArrayList<>();
	      for (StoreMenuDTO menudto : menulist) {
	         List<PhotoDTO> photoList = photo_dao.storemenuphoto(menudto.getMenu_idx());
	         menuphoto.addAll(photoList);
	      }
	      return menuphoto;
	   }

	   public List<PhotoDTO> alcholmenuphoto(int store_idx) {
	      List<StoreMenuDTO> menulist =store_dao.storealcholmenulist(store_idx);
	      List<PhotoDTO> menuphoto = new ArrayList<>();
	      for (StoreMenuDTO menudto : menulist) {
	         List<PhotoDTO> photoList = photo_dao.alcholmenuphoto(menudto.getMenu_idx());
	         menuphoto.addAll(photoList);
	      }
	      return menuphoto;
	   }
	   
	   
		public boolean totalmenudelete(String menu_category,String menu_idx) {
			int row = 0;
			boolean success = false;
			if(menu_category.equals("안주")) {
				row = photo_dao.menuphotodelete(menu_idx);
			} else if(menu_category.equals("주류")) {
				row = photo_dao.alcholphotodelete(menu_idx);
			}
			
			if(row != 0) {
				success = true;
			}
			return success;
		}

		public List<PhotoDTO> detail1(int store_idx, int photo_category_idx) {
			return photo_dao.detail1(store_idx, photo_category_idx);
		}
		
		public List<PhotoDTO> detail4(int store_idx, int photo_category_idx) {
			return photo_dao.detail4(store_idx, photo_category_idx);
		}

		public List<PhotoDTO> menulist(int menu_idx, int photo_category_idx) {
			return photo_dao.menulist(menu_idx, photo_category_idx);
		}
		
		// 게시판 게시글 사진 저장하는 메서드
		public void boardwriteajax(MultipartFile[] file, int store_idxx, int i) throws IOException {
			PhotoDTO photoDTO = new PhotoDTO();
			String photo = "2a4ce406-3235-46b0-a641-6e02cde217ad.png";
			photo = storeFile(file);
			logger.info(photo);
			photoDTO.setNew_filename(photo);
			photoDTO.setPhoto_folder_idx(store_idxx);
			photoDTO.setPhoto_category_idx(i);
			photo_dao.fileSave(photoDTO);
		}
		
		// 파일 한개만 저장하는 메서드 (가져온 파일을 랜덤아이디로 지정 후 C 드라이브에 저장)
		public String fileonesave(MultipartFile file) {
			String photo = "";
			try {
				if (!file.isEmpty()) {
					String ori = file.getOriginalFilename();
					int ext = ori.lastIndexOf(".");
					String extt = ori.substring(ext);
					photo = UUID.randomUUID()+extt;
					Path path = Paths.get(bpath+photo);
					byte[] arr;
					arr = file.getBytes();
					Files.write(path, arr);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return photo;
		}


		public void updateajax(MultipartFile[] file, int store_idxx, int i) throws IOException {
			PhotoDTO photoDTO = new PhotoDTO();
			String photo = storeFile(file);
			logger.info(photo);
			photoDTO.setNew_filename(photo);
			photoDTO.setPhoto_folder_idx(store_idxx);
			photoDTO.setPhoto_category_idx(i);
			photo_dao.updateajax(photoDTO);
		}

		public int reviewPhotoDel(Map<String, String> params) {
			return photo_dao.reviewPhotoDel(params);
		}

		public Map<String, Object> photoexist(int i, int reviewidx) {
			
			List<PhotoDTO> photodtolist = photo_dao.photoexist(3, reviewidx);
			Map<String, Object> photo = new HashMap<String, Object>();
			for (PhotoDTO photodto : photodtolist) {
				if(photodto!=null) {
					photo.put("photoexist",photodto.getPhoto_folder_idx()); //사진 있음
				}else {
					photo.put("photoexist", 0); //사진 없음		
				}
			} 
			return photo;
			
		}

		public PhotoDTO getPhotoByMenuIdx(int menu_idx, int photo_category_idx) {
			return photo_dao.getPhotoByMenuIdx(menu_idx, photo_category_idx);
		}

		public PhotoDTO menuPhoto(Integer store_idx, int menu_idx) {
			return photo_dao.menuPhoto(store_idx, menu_idx);
		}

		public PhotoDTO drinkPhoto(Integer store_idx, int menu_idx) {
			return photo_dao.drinkPhoto(store_idx, menu_idx);
		}




}
