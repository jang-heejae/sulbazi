package com.sulbazi.category;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CategoryDAO {
	List<CategoryOptDTO> categoryList();

	int categoryAdd(Map<String, String> param);

	int categoryState(String category, String state);
	
	//매장 리스트 필터링
	List<Integer> storefiltering(int idx_1, int idx_2, int idx_3, int idx_4);

	List<CategoryOptDTO> joincategory();

	void userJoindo(UserCategoryDTO usercategorydto);

	void storejoin(StoreCategoryDTO storecategorydto);

	Integer updateOpt(String opt_name_value);

	boolean userUpdate(String user_id, Integer opt_idx);

	void userUpdateCate(String user_id, int opt_idx);

	void userInsertCate(String user_id, int opt_idx);

}
