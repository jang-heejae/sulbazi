package com.sulbazi.board;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

@Service
public class BoardService {
	
	@Autowired BoardDAO board_dao;
	@Autowired PhotoService photo_ser;
	Logger logger = LoggerFactory.getLogger(getClass());

	public List<HashMap<String, Object>> boardlistgo() {
		return board_dao.boardlistgo();
	}

	public void detail(String board_idx, Model model) {
		BoardDTO boarddto = board_dao.detail(board_idx);
		int store_idx = boarddto.getStore_idx();
		logger.info("detail에 가져올 store_idx : "+store_idx);
		List<PhotoDTO> photo = photo_ser.detail(store_idx);
		logger.info("가져온 files : {}", photo);
		for (PhotoDTO photodto : photo) {
			String file = photodto.getNew_filename();
			logger.info(file);
			model.addAttribute("info", boarddto);
			model.addAttribute("files", file);
		}
	}

	

}
