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

<<<<<<< HEAD
	List<PhotoDTO> storemenualcholphoto(int photofolderidx);

	List<PhotoDTO> storemenuphoto(int photofolderidx);

=======
	int storephotoupdate(int photocategory, String newFileName, int photofolderidx);
	
	List<PhotoDTO> alcholmenuphoto(int photofolderidx);

	List<PhotoDTO> storemenuphoto(int photofolderidx);

	int menuphotodelete(String menu_idx);

	int alcholphotodelete(String menu_idx);

	int menuphotoinsert(PhotoDTO photo);



>>>>>>> origin/master
}
 