package com.sulbazi.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDAO {
	int adminAdd(Map<String, String> param);

	List<AdminDTO> adminList();

	AdminDTO adminChange(String admin_id);

	int adminUpdate(Map<String, Object> param);
}
