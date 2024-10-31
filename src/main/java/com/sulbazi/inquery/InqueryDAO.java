package com.sulbazi.inquery;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.admin.AdminDTO;

@Mapper
public interface InqueryDAO {

	int userinquerywrite(InqueryDTO inquery_dto);

	int inqueryfileWrite(int photocategory, String newFileName,int photofolderidx);

	List<HashMap<String, Object>> userlistinquery(String id);

	List<HashMap<String, Object>> admininquerylist();

	List<HashMap<String, Object>> inqueryfiltering(boolean bool);

	List<HashMap<String, Object>> inquerysearch(InqueryDTO dto);

	InqueryDTO userinquerydetail(int inqueryIdx);

	List<AnswerDTO> answer(int inqueryIdx);
	
	List<AdminDTO> answeradmin(int inqueryIdx);

	int adminanswerdo( int inqueryIdx,String loginId, String answer);

	int inquerystateupdate(int inquery_idx);
}
