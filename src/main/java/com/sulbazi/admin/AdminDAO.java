package com.sulbazi.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.UserDTO;

@Mapper
public interface AdminDAO {
	int adminAdd(Map<String, String> param);

	List<AdminDTO> adminList();

	AdminDTO adminChange(String admin_id);

	int adminUpdate(Map<String, Object> param);

	String getAdminNameById(String admin_id);

	int userCount(int cnt);

	List<HashMap<String, Object>> adminUserList(int limit, int offset);
	
	int storeCount(int cnt);

	List<HashMap<String, Object>> adminStoreList(int limit, int offset);

	UserDTO getUserInfo(String user_id);
    
	List<HashMap<String, Object>> getRevokeInfo(String user_id);
    
	List<HashMap<String, Object>> getUserCategories(String user_id);

}
