package com.sulbazi.board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
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

import com.sulbazi.member.StoreDTO;
import com.sulbazi.member.StoreService;
import com.sulbazi.photo.PhotoDAO;
import com.sulbazi.photo.PhotoDTO;
import com.sulbazi.photo.PhotoService;




@Controller
public class BoardController {
	
	@Autowired BoardService board_ser;
	@Autowired PhotoService photo_ser;
	@Autowired PhotoDAO photo_daoDao;
	@Autowired StoreService store_ser;
	
 	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/boardList.go")
	public String boardlist() {
		return "board/boardList";
	}
	
	@GetMapping(value="/boardList.ajax")
	@ResponseBody
	public Map<String, Object> boardlistgo(HttpSession session, String page, String cnt) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		/*
		 * Map<String, Object> map = new HashMap<String, Object>(); if
		 * (session.getAttribute("loginId") != null) { List<HashMap<String,Object>> list
		 * = board_ser.boardlistgo(page_, cnt_); map.put("login", true); map.put("list",
		 * list); }else { map.put("login", false); }
		 */
		return board_ser.boardlistgo(page_, cnt_, session);
	}
	
	@GetMapping(value="/board_category.ajax")
	@ResponseBody
	public Map<String, Object> boardFilter(
			@RequestParam String boardCategory,
			@RequestParam String boardSearch,
			HttpServletRequest request) {
		logger.info("넘어온 카테고리 값 : " + boardCategory);
		List<BoardDTO> boardList = board_ser.getAllcategory();
		String action = request.getParameter("action");
		logger.info("실행되는 액션기능 : " + action);
		if("filter".equals(action)) {
			boardList = boardList.stream()
					.filter(board -> board.getBoard_category().equals(boardCategory))
					.collect(Collectors.toList());
		}else if("search".equals(action)) {
			boardList = board_ser.getSearch(boardCategory, boardSearch);
		}
		List<BoardDTO> limitedBoardList = boardList.stream()
	            .limit(15)
	            .collect(Collectors.toList());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", boardList);
		map.put("list", limitedBoardList);
		return map;
	}
	
	/*
	 * @GetMapping(value="/board_search.ajax")
	 * 
	 * @ResponseBody public {
	 * 
	 * }
	 */
	
	@RequestMapping(value="/delete.go")
	public String del(String board_idx, Model model) {
		logger.info("삭제할 idx : {}", board_idx);
		String page = "";
		if(board_ser.del(board_idx) > 0) {
			model.addAttribute("message", "게시글을 삭제하시겠습니까?");
			page = "redirect:/boardList.go";
		}
		return page;
	}

	@RequestMapping(value="/boardDetail.go")
	public String detail(String board_idx, Model model) {
		board_ser.detail(board_idx, model, true);
		return "board/boardDetail";
	}
	
	@RequestMapping(value="/boardWrite.go")
	public String boardWrite(Model model, HttpSession session) {
		String store_id = (String) session.getAttribute("loginId");
		logger.info(store_id);
		model.addAttribute("bookmarkuser", store_ser.bookmarkuserlist(store_id));
		logger.info("북마크 유저 리스트"+store_ser.bookmarkuserlist(store_id));
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
