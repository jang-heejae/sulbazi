package com.sulbazi.photo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PhotoDAO {
	/*
	 * void fileSave(int store_idx, String newfile, int cti);
	 */
	void fileSave(PhotoDTO photoDTO);

	List<PhotoDTO> inqueryphoto(int inqueryIdx);

	PhotoDTO mystorebestphoto(int store_idx);

	List<PhotoDTO> mystorephoto(int store_idx);

	int mystoreinoutUpdate(List<Map<String, Object>> photos);

	int mystorebestphotoupdate(String new_filename, int idx);
}
 