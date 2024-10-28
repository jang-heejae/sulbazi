package com.sulbazi.photo;

import java.util.List;

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

}
