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

import com.sulbazi.admin.AdminDTO;

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
	    List<HashMap<String, Object>> userinquerylist = inquery_dao.userlistinquery(id);
	    for (HashMap<String, Object> inquery : userinquerylist) {
	        int inqueryidx = (int) inquery.get("inquery_idx");
	        logger.info("inqueryidx: " + inqueryidx);
	        
	        // answeradmin 정보를 가져와서 현재 inquery에 추가
	        List<AdminDTO> answeradmin = inquery_dao.answeradmin(inqueryidx);
	        inquery.put("answeradmin", answeradmin);  // 개별 inquery에 "answeradmin" 추가
	    }
	    return userinquerylist;
	}
	
	
	//관리자 문의 리스트
	public Map<String, Object> admininquerylist(int page, int cnt) {
		 int limit = cnt;
		 int offset = (page-1) * cnt;
		 int inquerytotalPages = inquery_dao.inqueryCount(cnt);
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("inquerytotalPages", inquerytotalPages);
		 map.put("list", inquery_dao.admininquerylist(limit, offset));
		return map;
	}

	
	//관리자 문의 필터링
	public Map<String, Object> inqueryfiltering(Map<String, String> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>>  inquerylist = null;
		int cnt = Integer.parseInt(params.get("cnt"));
		int limit = cnt;
		int page = Integer.parseInt(params.get("page"));
		int offset = (page-1) * cnt;
		int inquerytotalPages = 0;
		if(!params.get("inquerystate").equals("all")) {
			boolean bool=false;
			if(params.get("inquerystate").equals("false")) {
				bool = false;
				inquerylist=inquery_dao.inqueryfiltering(bool,limit, offset);				
				inquerytotalPages=inquery_dao.inqueryfilteringCount(cnt,bool);
			} else {
				bool = true;
				inquerylist=inquery_dao.inqueryfiltering(bool,limit, offset);
				inquerytotalPages=inquery_dao.inqueryfilteringCount(cnt,bool);
			}
		}else if(params.get("inquerystate").equals("all")) {
			inquerylist=inquery_dao.inqueryfilteringall(limit, offset);
			inquerytotalPages=inquery_dao.inqueryfilteringallCount(cnt);
		}
		 map.put("inquerytotalPages", inquerytotalPages);
		 map.put("list", inquerylist);
		return map;
	}


	//관리자 문의 검색
	public Map<String, Object> inquerysearch(Map<String, String> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		logger.info("params: {}",params);
		InqueryDTO dto = new InqueryDTO();
		dto.setId_write(params.get("id_write"));
		String state = params.get("inquery_state");
		List<HashMap<String, Object>>  inquerylist = null;
		int cnt = Integer.parseInt(params.get("cnt"));
		int limit = cnt;
		int page = Integer.parseInt(params.get("page"));
		int offset = (page-1) * cnt;
		int inquerytotalPages = 0;
		if(!state.equals("all")) {			
			if(state.equals("false")) {
				dto.setInquery_state(false);
			} else if(state.equals("true")){
				dto.setInquery_state(true);
			}
			param.put("imqueryDTO", dto);
			param.put("limit", limit);
			param.put("offset", offset);
			param.put("cnt", cnt);
			inquerylist = inquery_dao.inquerysearch(param);
			inquerytotalPages=inquery_dao.inquerysearchCount(param);
		}else {
			inquerylist = inquery_dao.inqueryallsearch(params.get("id_write"),limit, offset);
			inquerytotalPages=inquery_dao.inquerysearchallCount(cnt, params.get("id_write"));
		}
		 map.put("inquerytotalPages", inquerytotalPages);
		 map.put("list", inquerylist);
		return map;

	}

	
	
	public InqueryDTO userinquerydetail(int inqueryIdx) {
		return inquery_dao.userinquerydetail(inqueryIdx);
	}

	public List<AnswerDTO> answer(int inqueryIdx) {
		return inquery_dao.answer(inqueryIdx);
	}
		
	public List<AdminDTO> answeradmin(int inqueryIdx) {
		return inquery_dao.answeradmin(inqueryIdx);
	}

	public boolean adminanswerdo(int inqueryIdx,String loginId, String answer) {
		int row = inquery_dao.adminanswerdo(inqueryIdx,loginId,answer);
		boolean successanswer = false;
		if(row != 0) {
			successanswer=true;
		}
		logger.info(""+successanswer);
		return successanswer;
		
	}

	public void inquerystateupdate(int inquery_idx) {
		inquery_dao.inquerystateupdate(inquery_idx);
	}

	
	
}
