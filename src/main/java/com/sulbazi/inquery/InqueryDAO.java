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

	List<InqueryDTO> userlistinquery(String id);

	List<HashMap<String, Object>> admininquerylist(int limit, int cnt);

	List<HashMap<String, Object>> inqueryfiltering(boolean bool, int limit, int offset);

	List<HashMap<String, Object>> inquerysearch(Map<String, Object> param);

	InqueryDTO userinquerydetail(int inqueryIdx);

	List<AnswerDTO> answer(int inqueryIdx);
	
	List<AdminDTO> answeradmin(int inqueryIdx);

	int adminanswerdo( int inqueryIdx,String loginId, String answer);

	int inquerystateupdate(int inquery_idx);

	int inqueryCount(int cnt);

	List<HashMap<String, Object>> inqueryallsearch(String string, int limit, int offset);

	int inqueryfilteringCount(int cnt, boolean bool);

	List<HashMap<String, Object>> inqueryfilteringall(int limit, int offset);

	int inqueryfilteringallCount(int cnt);

	int inquerysearchallCount(int cnt, String string);

	int inquerysearchCount(Map<String, Object> param);
}
