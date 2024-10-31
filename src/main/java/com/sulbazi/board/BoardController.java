package com.sulbazi.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sulbazi.photo.PhotoDAO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;




@Controller
public class BoardController {
	
	@Autowired BoardService board_ser;
	@Autowired PhotoService photo_ser;
	@Autowired PhotoDAO photo_daoDao;
 	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/boardList.go")
	public String boardlist() {
		return "board/boardList";
	}
	
	@GetMapping(value="/boardList.ajax")
	@ResponseBody
	public Map<String, Object> boardlistgo(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (session.getAttribute("loginId") != null) {
			map.put("login", true);
			List<HashMap<String, Object>> list = board_ser.boardlistgo();
			for (HashMap<String, Object> boardData : list) {
	            int store_idx = (int) boardData.get("store_idx"); // store_idx 값 추출
	            logger.info("List store_idx : {}", store_idx);
	            String store_id = board_ser.selectidx(store_idx);
	            logger.info("Store ID: {}", store_id);
	            boardData.put("store_id", store_id); // store_id를 boardData에 추가
	        }
			map.put("list", list);
			logger.info("list : {}", list);
		}else {
			map.put("login", false);
		}	
		return map;
	}
	
	@RequestMapping(value="/delete.go")
	public String del(String board_idx) {
		logger.info("삭제할 idx : {}", board_idx);
		board_ser.del(board_idx);
		String page = "redirect:/boardList.go";
		return page;
	}

	@RequestMapping(value="/boardDetail.go")
	public String detail(String board_idx, Model model) {
		board_ser.detail(board_idx, model, true);
		return "board/boardDetail";
	}
	
	@PostMapping(value="/boardlike.ajax")
	@ResponseBody
	public BoardLikeDTO boardlike(int user_id, String store_idx) {
		logger.info("좋아요 parmas : ", user_id + store_idx);
		return null;
	}
	
	@RequestMapping(value="/test.go")
	public String testgo() {
		return "member/test";
	}
	
	@PostMapping(value="/test.ajax")
	public ResponseEntity<?> test(@RequestParam Map<String, Object> params) {
		logger.info("params : {} ", params);
		return null;
	}
	
	@RequestMapping(value="/boardWrite.go")
	public String boardWrite() {
		return "board/boardWrite";
	}
	
	@PostMapping(value="/boardWrite.ajax")
	@ResponseBody
	public Map<String, Object> boardWriteajax(
			@RequestParam("file") MultipartFile[] file,
			@RequestParam Map<String, String> params,
			HttpSession session) throws IOException{
		Map<String, Object> response = new HashMap<>();
		boolean success = false;
		logger.info("params : {} ", params + "file : {}", file.length);
		String store_id = (String) session.getAttribute("loginId");
		logger.info(store_id);
		logger.info("파일 랭스 :{} ",file.length);
		int store_idx = board_ser.getstore_idx(store_id);
		if (store_idx > 0) {
			BoardDTO boardDTO = new BoardDTO();
			boardDTO.setStore_idx(store_idx);
	        boardDTO.setBoard_subject(params.get("board_subject"));
	        boardDTO.setBoard_content(params.get("board_content"));
	        boardDTO.setBoard_category(params.get("board_category"));
	        int store_idxx = boardDTO.getStore_idx();
	        photo_ser.boardwriteajax(file, store_idxx ,4);
	        success = board_ser.boardWriteajax(boardDTO, file);
	        if (success) {
	        	response.put("success", true);
	        	response.put("link", "/SULBAZI/boardList.go");
				response.put("message", "게시글을 등록하시겠습니까?");
			}else {
				response.put("message", "게시글 등록에 실패했습니다.");
			}
		}else {
			response.put("message", "로그인 후 이용하세요.");
		}
		response.put("success", success);
		return response;
	}
	
	@PostMapping(value="/update.ajax")
	@ResponseBody
	public Map<String, Object> updateajax(
			@RequestParam("file") MultipartFile[] file,
			@RequestParam Map<String, String> params,
			HttpSession session) throws IOException{
		Map<String, Object> response = new HashMap<>();
		boolean success = false;
		logger.info("params detail : {} ", params + "file : {}", file.length);
		String store_id = (String) session.getAttribute("loginId");
		logger.info(store_id);
		logger.info("파일 랭스 :{} ",file.length);
		int store_idx = board_ser.getstore_idx(store_id);
		if (store_idx > 0) {
			BoardDTO boardDTO = new BoardDTO();
			boardDTO.setStore_idx(store_idx);
	        boardDTO.setBoard_subject(params.get("board_subject"));
	        boardDTO.setBoard_content(params.get("board_content"));
	        boardDTO.setBoard_category(params.get("board_category"));
	        String board_idxs = params.get("board_idx");
	        logger.info(board_idxs);
	        int board_idx = Integer.parseInt(board_idxs);
	        boardDTO.setBoard_idx(board_idx);
	        int store_idxx = boardDTO.getStore_idx();
	        if (file != null) {
	        	photo_ser.updateajax(file, store_idxx ,4);
			}
	        success = board_ser.updateajax(boardDTO, file);
	        if (success) {
	        	response.put("success", true);
	        	response.put("link", "/SULBAZI/boardList.go");
				response.put("message", "수정하시겠습니까?");
			}else {
				response.put("message", "수정에 실패했습니다.");
			}
		}else {
			response.put("message", "로그인 후 이용하세요.");
		}
		response.put("success", success);
		return response;
	}
	
	@RequestMapping(value="/update.go")
	public String update(String board_idx, Model model) {
		logger.info("idx : {}", board_idx);
		board_ser.update(board_idx, model);
		return "board/boardUpdate";
	}
}
