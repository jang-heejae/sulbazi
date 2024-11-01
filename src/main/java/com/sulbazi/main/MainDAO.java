package com.sulbazi.main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sulbazi.member.StoreDTO;

@Mapper
public interface MainDAO { 
 
	List<StoreDTO> mainStore();

}
