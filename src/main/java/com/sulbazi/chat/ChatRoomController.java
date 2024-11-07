package com.sulbazi.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.html.HTMLModElement;

import com.sulbazi.alarm.AlarmService;
import com.sulbazi.member.UserDTO;
import com.sulbazi.member.UserService;
import com.sulbazi.message.MessageService;

@Controller
public class ChatRoomController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomService chatroom_ser;
	@Autowired MessageService message_ser;
	@Autowired ChatPartiService chatparti_ser;
	@Autowired AlarmService alarm_ser;
	@Autowired UserService user_ser;
	
	private final SseService sseService;
	@Autowired
	public ChatRoomController(SseService sseService) {
        this.sseService = sseService;
    }
	
	/* 개인 채팅방 리스트 */
	@RequestMapping(value ="/userchatlist.go")
	public String chatlist(HttpSession session, Model model, UserChatroomDTO userChatroomdto) {
		
		String page;
		String loginId = (String) session.getAttribute("loginId"); // 세션에서 로그인 아이디
		
		if(loginId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {		
			List<UserChatroomDTO> userchat_list = chatroom_ser.chatlist();
			model.addAttribute("list", userchat_list);
			
			// 닉네임, 사진
			Map<String, UserDTO> userinfo = new HashMap<>();
			
	        for (UserChatroomDTO userlist : userchat_list) {
	        	UserDTO user = user_ser.user(userlist.getUser_id());
	            if (user != null) {
	            	userinfo.put(userlist.getUser_id(), user);
	                logger.info("방장 id : {}", userlist.getUser_id());
	                logger.info("방장 사진: {}", user.getUser_photo());
	                logger.info("방장 닉 : {}", user.getUser_nickname());
	            }
	        }
	        model.addAttribute("userinfo", userinfo);
			logger.info("userchat_list :"+ userchat_list);
			logger.info("세션아이디 : "+loginId);
			page = "chat/userChatList";
		}
		
		return page;
	}
	
	/* 개인 채팅방 리스트 - 검색결과 */
	@GetMapping(value ="/search.ajax")
	@ResponseBody
	public List<UserChatroomDTO> search(@RequestParam String query) {
		logger.info("Search query: " + query);
		List<UserChatroomDTO> resultList = chatroom_ser.search(query);
		logger.info("resultList{}:",resultList);
		return resultList;
	}
	
	/* 개인 채팅방 생성 */
	@PostMapping(value="/userchatroom.do")
	public String chatcreate(HttpSession session, UserChatroomDTO userchatroomdto, Model model, RedirectAttributes redirectAttributes) {
		
		String page;
		String loginId = (String) session.getAttribute("loginId"); // 세션에서 로그인 아이디
		
		if(loginId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {		
			int row = chatroom_ser.chatcreate(userchatroomdto, model, loginId);
			
			if(row>0) {
	            page = "/chat/userChatList";
	            
			}else {
				redirectAttributes.addFlashAttribute("msg", "방 생성 불가 : 개설된 방이 있습니다.");
			    return "redirect:/userchatlist.go";
			}
		}
		return page;
	}
	
	/* 생성한 채팅방 수정 */
	@PostMapping(value="/updatechatroom.ajax")
	@ResponseBody
	public ResponseEntity<String> updatechatroom(@RequestParam Map<String, String> params) {
		chatroom_ser.updatechatroom(params);
		
		sseService.updateRoom(params);
		
		return ResponseEntity.ok("Success");
	}
		
	/* 공지 등록, 수정 */
	@PostMapping(value="/updatenotice.ajax")
	@ResponseBody
	public ResponseEntity<String> updatenotice(@RequestParam String notice, int userchat_idx){
		chatroom_ser.updatenotice(notice, userchat_idx);
		
		// 모든 연결된 클라이언트에게 notifyNewUser 이벤트 전송
		sseService.sendNoticeUpdate(notice);
	    
		return ResponseEntity.ok("Success");
	}
	
	/* 개인 채팅방 삭제(비공개) */
	@PostMapping(value="/deletechatroom.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> deletechatroom(@RequestParam int userchat_idx, @RequestParam String user_id, @RequestParam int current_people){
		
		Map<String, String> response = new HashMap<String, String>();
		if(current_people <= 1) {
			int row = chatroom_ser.deletechatroom(user_id, userchat_idx);
			
			if(row==0) {
				response.put("status", "error");
				response.put("message", "방 삭제 대실패.");
			} else {
				response.put("status", "success");
				response.put("message", "삭제 완료");
			}
		}else {
			response.put("status", "error");
			response.put("message", "퇴장하지 않은 유저 있음 방 삭제 불가.");
		}
		return ResponseEntity.ok(response);
		
	}
	
	/* 개인 채팅방 참여 */
	@RequestMapping(value="/userchatroom.go")
	public String chatroom(HttpSession session, Model model, UserChatroomDTO userChatroomdto, RedirectAttributes redirectAttributes) {
		
		String page;
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			
			// 나의 채팅방 목록
			List<UserChatroomDTO> userchat_list = chatroom_ser.myroomlist(loginId);
			
			int idx = userChatroomdto.getUserchat_idx();
			String id = userChatroomdto.getUser_id();
						
			logger.info("idx = "+idx);
			model.addAttribute("roomin", loginId);

			// 방 정보 가져오기
			List<UserChatroomDTO> roominfo = chatroom_ser.roominfo(idx);
			
    		int row = chatparti_ser.userparti(loginId, idx);
        	if (row > 0) {
        		redirectAttributes.addFlashAttribute("msg", "참여 신청 완료");
			    return "redirect:/userchatlist.go";
        	}
			
			String userid = userChatroomdto.getUser_id();
			logger.info("방장 아이디:"+userid);
			
			model.addAttribute("list", userchat_list);
			model.addAttribute("idx", idx);
			model.addAttribute("userid", userid);
			model.addAttribute("current", userChatroomdto.getCurrent_people());
			model.addAttribute("roominfo",roominfo);

			page = "/chat/userChatRoom";
		}
		
		return page;
	}
	
	
	
	/* ************************  지역 채팅  *************************** */
	
	/* 지역 채팅방 리스트 */
	@RequestMapping(value ="/localchatlist.go")
	public String localchatlist(Model model, HttpSession session) {
		
		String page;
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			List<LocalChatroomDTO> localchat_list = chatroom_ser.localchatlist();
			model.addAttribute("list", localchat_list);
			logger.info("userchat_list :"+ localchat_list);
			page = "chat/localChatList";
		}
		return page;
	}
	
	/* 지역 채팅방 참여 */
	@PostMapping(value="/localchatroom.go")
	public String localchatgo(HttpSession session, Model model, LocalChatroomDTO localChatroomdto) {
		
		String page;
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			
			int idx = localChatroomdto.getLocalchat_idx();
			
			// 방 정보
			List<LocalChatroomDTO> roominfo = chatroom_ser.localroominfo(idx);
			
			List<PartiDTO> localtotal = chatparti_ser.localtotal(idx);
			
			// 지역 채팅방 입장
			chatparti_ser.localparti(loginId, idx);
			
			List<LocalChatroomDTO> localchat_list = chatroom_ser.localchatlist();
			model.addAttribute("list", localchat_list);
			model.addAttribute("roomidx", idx);
			model.addAttribute("roominfo", roominfo);
			model.addAttribute("localtotal", localtotal);

			page ="/chat/localChatRoom";
		}
		return page;
	}
}
