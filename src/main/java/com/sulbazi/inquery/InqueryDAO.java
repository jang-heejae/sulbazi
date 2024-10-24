package com.sulbazi.inquery;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InqueryDAO {

	int userinquerywrite(InqueryDTO inquery_dto);

	int inqueryfileWrite(int photocategory, String newFileName,int photofolderidx);

	List<HashMap<String, Object>> userlistinquery(String id);
	
	List<HashMap<String, Object>> inqueryprocess(String id);
}
