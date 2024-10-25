package com.sulbazi.inquery;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Service
public class InqueryService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryDAO inquery_dao;

	public int userinquerywrite(MultipartFile[] inqueryfiles, Map<String, String> params, HttpSession session) {
		InqueryDTO inquery_dto = new InqueryDTO();
		String loginId = (String) session.getAttribute("loginId");
		String opt = (String) session.getAttribute("opt");
		if(loginId != null && opt.equals("user_log")) {	
			inquery_dto.setId_write(loginId);//문의자
			inquery_dto.setId_category("사용자");//문의자 분류
		} else if(loginId != null && opt.equals("store_log")){
			inquery_dto.setId_write(loginId);//문의자
			inquery_dto.setId_category("매장");//문의자 분류
		}
		inquery_dto.setInquery_subject(params.get("inquerysubject"));//문의제목
		inquery_dto.setInquery_content(params.get("inquerycontent"));//문의 내용
	
		int row = inquery_dao.userinquerywrite(inquery_dto);
		int photofolderidx = inquery_dto.getInquery_idx();//폴더 idx
		if (photofolderidx>0 && row>0) {
			saveinqueryFile(inqueryfiles,photofolderidx);
		}
		return photofolderidx;
	}
	
	private void saveinqueryFile(MultipartFile[] inqueryfiles, int photofolderidx) {
		try {
			logger.info("file length : {}",inqueryfiles.length);				
			for (MultipartFile userinqueryfile : inqueryfiles) {
				logger.info("file 비어있나? : "+userinqueryfile.isEmpty());					
				String ori_filename = userinqueryfile.getOriginalFilename();
				logger.info("파일명 : "+ori_filename);
				
				int pos = ori_filename.lastIndexOf(".");
				
				if(pos>=0) {
					String ext = "";				
					ext = ori_filename.substring(pos);						
					String newFileName = UUID.randomUUID().toString()+ext;		
					byte[] userinqueryarr = userinqueryfile.getBytes();
					Path path = Paths.get("C:/upload/"+newFileName);
					Files.write(path,userinqueryarr);
					int photocategory = 5;
					inquery_dao.inqueryfileWrite(photocategory, newFileName,photofolderidx);						
				}					
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	
	}

	public List<HashMap<String, Object>> userlistinquery(String id) {
		//처리자
		/* inquery_dao.inqueryprocess(id); */
		return inquery_dao.userlistinquery(id);
	
	}

	public List<HashMap<String, Object>> admininquerylist() {
		return inquery_dao.admininquerylist();
	}

	public List<HashMap<String, Object>> inqueryfiltering(boolean bool) {
		return inquery_dao.inqueryfiltering(bool);
	}

	public List<HashMap<String, Object>> inquerysearch(Map<String, String> params) {
		logger.info("params: {}",params);
		InqueryDTO dto = new InqueryDTO();
		dto.setId_write(params.get("id_write"));
		boolean bool=false;
		if(params.get("inquery_state").equals("false")) {
			bool = false;
			dto.setInquery_state(false);
		} else {
			bool = true;
			dto.setInquery_state(true);
		}
		return inquery_dao.inquerysearch(dto);
	}

	public InqueryDTO userinquerydetail(int inqueryIdx) {
		return inquery_dao.userinquerydetail(inqueryIdx);
	}

	public InqueryDTO userinquerydetailadmin(int inqueryIdx) {
		return inquery_dao.userinquerydetailadmin(inqueryIdx);
	}
		
	
	
	
	
	

	
	
	
}
