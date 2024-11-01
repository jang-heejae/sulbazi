package com.sulbazi.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.member.StoreDAO;
import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreService;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;
@Service 
public class MainService {
	@Autowired MainDAO main_dao;
	@Autowired StoreDAO store_dao;
	@Autowired PhotoService photo_ser;
	@Autowired StoreService store_ser;
	Logger log = LoggerFactory.getLogger(getClass());
	
	public void mainStore(Model model) {
        List<StoreDTO> storeList = main_dao.mainStore(); // 상위 4개 store 정보
        log.info("storeList:{}"+storeList);
        Map<Integer, PhotoDTO> map = new HashMap<Integer, PhotoDTO>();
        // 각 store에 대한 사진 리스트 추가
        for (StoreDTO store : storeList) {
            PhotoDTO photoDto = photo_ser.mystorebestphoto(store.getStore_idx());
            map.put(store.getStore_idx(), photoDto);
            log.info("store_idx:{}"+store.getStore_idx());
        }        
        model.addAttribute("files", map); // store_idx별로 저장하여 JSP에서 사용 가능
        model.addAttribute("info", storeList); // 전체 store 정보 추가
    }
}
