package com.sulbazi.category;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.StoreDTO;

@Mapper
public interface CategoryDAO {
	List<CategoryOptDTO> categoryList();

	int categoryAdd(Map<String, String> param);

	int categoryState(String category, String state);
	 
	//매장 리스트 필터링
	List<StoreDTO> storefiltering(int idx_1, int idx_2, int idx_3, int idx_4,int offset,int limit);

	List<CategoryOptDTO> joincategory();

	void userJoindo(UserCategoryDTO usercategorydto);

	void storejoin(StoreCategoryDTO storecategorydto);

	int deletemystoreopt(int idx);

	int updatemystoreopt(int opt_idx, int store_idx);

	void userUpdate(String user_id, Integer category_idx, Integer opt_idx);

	Integer updateOpt(String opt_name_value);


	boolean userUpdate(String user_id, Integer opt_idx);

	void userUpdateCate(String user_id, int opt_idx);

	void userInsertCate(String user_id, int opt_idx);

	int getTotalPages(int idx_1, int idx_2, int idx_3, int idx_4);

	int insertOption(int purposeValue, int moodValue, int idx);

	int selectCategory(Map<String, String> params);

	int categoryUpdate(int optFirst, int moodValue, int reviewIdx);

	int categoryUpdateTwo(int optSecond, int purposeValue, int reviewIdx);

	int insertCategory(Map<String, String> params);



}
