package com.sulbazi.inquery;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InqueryDAO {

	int userinquerywrite(InqueryDTO inquery_dto);

	void inqueryfileWrite(int photocategory, String newFileName,int photofolderidx);

}
