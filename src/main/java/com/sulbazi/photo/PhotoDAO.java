package com.sulbazi.photo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PhotoDAO {
	/*
	 * void fileSave(int store_idx, String newfile, int cti);
	 */
	void fileSave(PhotoDTO photoDTO);

	void menufile(PhotoDTO photodto);
	
	List<PhotoDTO> inqueryphoto(int inqueryIdx);

	PhotoDTO mystorebestphoto(int store_idx);

	List<PhotoDTO> mystorephoto(int store_idx);

	List<PhotoDTO> detail1(int store_idx, int photo_category_idx);

	List<PhotoDTO> detail4(int store_idx, int photo_category_idx);


}
 