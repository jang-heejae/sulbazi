package com.sulbazi.category;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CategoryDAO {
	List<CategoryOptDTO> categoryList();

	int categoryAdd(Map<String, String> param);
}
