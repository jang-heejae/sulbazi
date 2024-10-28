package com.sulbazi.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.photo.PhotoDTO;

@Mapper
public interface UserDAO {

	List<PhotoDTO> files(String user_id);

}
