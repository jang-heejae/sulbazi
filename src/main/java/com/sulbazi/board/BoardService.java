package com.sulbazi.board;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.alarm.AlarmService;
import com.sulbazi.photo.PhotoDAO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;

@Service
public class BoardService {
	
	@Autowired BoardDAO board_dao;
	@Autowired PhotoService photo_ser;
	@Autowired PhotoDAO photo_dao;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	public Map<String, Object> boardlistgo(int page, int cnt, HttpSession session) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int totalPages = board_dao.allCount(cnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("login", true);
		map.put("list", board_dao.boardlistgo(limit, offset));
		map.put("totalPages", totalPages);
		return map;
	}

	public void detail(String board_idx, Model model, boolean flag) {
		BoardDTO boarddto = board_dao.detail(board_idx);
		if(flag) {
			board_dao.bHit(board_idx);
		}
		int store_idx = boarddto.getStore_idx();
		String store_name = selectidx(store_idx);
		logger.info("detail에 가져올 store_idx : "+store_idx);
		List<PhotoDTO> photo1 = photo_ser.detail1(store_idx, 1);
		List<PhotoDTO> photo4 = photo_ser.detail4(store_idx, 4);
		logger.info("가져온 photo1 : {}", photo1);
		logger.info("가져온 photo4 : {}", photo4);
		for (PhotoDTO photodto1 : photo1) {
			String file1 = photodto1.getNew_filename();
			logger.info(file1);
			model.addAttribute("info", boarddto);
			model.addAttribute("files", file1);
			model.addAttribute("store", store_name);
			for (PhotoDTO photodto4 : photo4) {
				String file4 = photodto4.getNew_filename();
				logger.info(file4);
				model.addAttribute("files4", file4);
			}
		}
	}

	public void update(String board_idx, Model model) {
		BoardDTO boarddto = board_dao.detail(board_idx);
		int store_idx = boarddto.getStore_idx();
		List<PhotoDTO> photo = photo_ser.detail4(store_idx, 4);
		for (PhotoDTO photodto : photo) {
			String file = photodto.getNew_filename();
			logger.info("update : {}", file);
			model.addAttribute("info", boarddto);
			model.addAttribute("files", file);
		}
	}
	
	public boolean isLiked(BoardLikeDTO likeDTO) {
		return board_dao.isLiked(likeDTO);
	}

	public void deleteLike(BoardLikeDTO likeDTO) {
		board_dao.deleteLike(likeDTO);
	}

	public void insertLike(BoardLikeDTO likeDTO) {
		board_dao.insertLike(likeDTO);
	}

	public int getstore_idx(String store_id) {
		return board_dao.getstore_idx(store_id);
	}

	public boolean boardWriteajax(BoardDTO boardDTO, MultipartFile[] file) {
		return board_dao.boardWriteajax(boardDTO);
	}

	public String selectidx(int store_idx) {
		return board_dao.selectidx(store_idx);
	}

	public boolean updateajax(BoardDTO boardDTO, MultipartFile[] file) {
		return board_dao.updateajax(boardDTO);
	}

	public int del(String board_idx) {
		int row = board_dao.del(board_idx);
		return row;
	}

	public List<BoardDTO> stream() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<BoardDTO> getAllcategory() {
		return board_dao.getAllcategory();
	}

	public List<BoardDTO> getSearch(String boardCategory, String boardSearch) {
		return board_dao.getSearch(boardCategory, boardSearch);
	}



	

}
