package com.sulbazi.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
