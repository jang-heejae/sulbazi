package com.sulbazi.member;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sulbazi.photo.PhotoDTO;






@Service
public class StoreService {

	@Autowired StoreDAO store_dao;


	public StoreDTO getStoreDetail(int idx) {
		StoreDTO sd = store_dao.getStoreDetail(idx);
		
		return sd;
	}


	public List<PhotoDTO> fileList(int idx) {
		return store_dao.fileList(idx);
	}


	public List<StoreMenuDTO> getStoreMenuById(int idx) {
		return store_dao.getStoreMenuById(idx);
	}

}
