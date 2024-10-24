package com.sulbazi.inquery;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class InqueryService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired InqueryDAO inquery_dao;

	public int userinquerywrite(MultipartFile[] inqueryfiles, Map<String, String> params, HttpSession session) {
		InqueryDTO inquery_dto = new InqueryDTO();
		String loginId = (String) session.getAttribute("loginId");
		if(loginId != null) {	
			inquery_dto.setId_write(loginId);//문의자
		}
		inquery_dto.setId_category("사용자");//문의자 분류
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
					// ori_filename.lastIndexOf(".") 수행시 -1이 나오는데 이걸로 서브스트링이 되나?					
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
	
	
	
	
	

	
	
	
}
