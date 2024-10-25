package com.sulbazi.inquery;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InqueryDAO {

	int userinquerywrite(InqueryDTO inquery_dto);

	int inqueryfileWrite(int photocategory, String newFileName,int photofolderidx);

	List<HashMap<String, Object>> userlistinquery(String id);
	
	List<HashMap<String, Object>> inqueryprocessadmin(String id);

	List<HashMap<String, Object>> admininquerylist();

	List<HashMap<String, Object>> inqueryfiltering(boolean bool);

	List<HashMap<String, Object>> inquerysearch(InqueryDTO dto);

	InqueryDTO userinquerydetail(int inqueryIdx);

	List<AnswerDTO> answer(int inqueryIdx);
	
	List<String> answeradmin(int inqueryIdx);
}
