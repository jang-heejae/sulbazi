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
	
	void menufile(PhotoDTO photodto);

	List<PhotoDTO> inqueryphoto(int inqueryIdx);

	PhotoDTO mystorebestphoto(int store_idx);

	List<PhotoDTO> mystorephoto(int store_idx);

	int storephotoupdate(int photocategory, String newFileName, int photofolderidx);
	
	List<PhotoDTO> alcholmenuphoto(int photofolderidx);

	List<PhotoDTO> storemenuphoto(int photofolderidx);

	int menuphotodelete(String menu_idx);

	int alcholphotodelete(String menu_idx);

	int menuphotoinsert(PhotoDTO photo);

	List<PhotoDTO> detail1(int store_idx, int photo_category_idx);

	List<PhotoDTO> detail4(int store_idx, int photo_category_idx);

}
 