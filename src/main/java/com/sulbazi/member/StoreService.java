package com.sulbazi.member;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired StoreDAO store_dao;
	
	public List<Integer> storenamesearch(String keyword) {
		logger.info("매장이름키워드서비스");
		logger.info(keyword);
		List<Integer> namesearch = store_dao.storenamesearch(keyword);
		logger.info("" + namesearch);
		
		/*
		 * for (Integer storeidx : namesearch) { List<StoreDTO> list =
		 * store_dao.storesearch(storeidx);
		 * 
		 * 
		 * }
		 * 
		 * logger.info("list: {}", list);
		 */
		return namesearch;
	}

	public List<Integer> storemenusearch(String keyword) {
		logger.info("메뉴키워드서비스");
		logger.info(keyword);
		List<Integer> menusearch = store_dao.storemenusearch(keyword);
		logger.info("" + menusearch);
		return menusearch;
	}

	public List<Integer> storeaddrsearch(String keyword) {
		logger.info("주소키워드서비스");
		logger.info(keyword);
		List<Integer> addrsearch = store_dao.storeaddrsearch(keyword);
		logger.info("" + addrsearch);
		return addrsearch;
	}
}
