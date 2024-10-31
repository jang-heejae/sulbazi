package com.sulbazi.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;




@Controller
public class BoardController {
	
	@Autowired BoardService board_ser;
	@Autowired PhotoService photo_ser;
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
			map.put("list", list);
			logger.info("list : {}", list);
		}else {
			map.put("login", false);
		}	
		return map;
	}

	@RequestMapping(value="boardDetail.go")
	public String detail(String board_idx, Model model) {
		board_ser.detail(board_idx, model);
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
			MultipartFile[] files,
			@RequestParam Map<String, String> params,
			HttpSession session) throws IOException{
		Map<String, Object> response = new HashMap<>();
		boolean success = false;
		logger.info("params : {} ", params);
		logger.info("files : {} "+ files);
		String store_id = (String) session.getAttribute("loginId");
		logger.info(store_id);
		int store_idx = board_ser.getstore_idx(store_id);
		if (store_idx > 0) {
			BoardDTO boardDTO = new BoardDTO();
			boardDTO.setStore_idx(store_idx);
	        boardDTO.setBoard_subject(params.get("board_subject"));
	        boardDTO.setBoard_content(params.get("board_content"));
	        boardDTO.setBoard_date(LocalDate.now());
	        boardDTO.setBoard_category(params.get("board_category"));
	        boardDTO.setBoard_state(true);
	        int store_idxx = boardDTO.getStore_idx();
	        photo_ser.fileSave(files, store_idxx ,4);
	        success = board_ser.boardWriteajax(boardDTO, files);
	        if (success) {
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
}
