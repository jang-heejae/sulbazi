package com.sulbazi.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sulbazi.alarm.AlarmService;
import com.sulbazi.member.UserDTO;
import com.sulbazi.message.LocalMsgDTO;
import com.sulbazi.message.MessageService;
import com.sulbazi.message.UserMsgDTO;

@Controller
public class ChatRoomController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomService chatroom_ser;
	@Autowired MessageService message_ser;
	@Autowired ChatPartiService chatparti_ser;
	@Autowired AlarmService alarm_ser;
	
	/* 개인 채팅방 리스트 */
	@RequestMapping(value ="/userchatlist.go")
	public String chatlist(HttpSession session, Model model, UserChatroomDTO userChatroomdto) {
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.chatlist();
		model.addAttribute("list", userchat_list);
		
		logger.info("userchat_list :"+ userchat_list);
		logger.info("세션아이디 : "+session.getAttribute("loginId"));
				
		return "chat/userChatList";
	}
	
	/* 개인 채팅방 리스트 - 검색결과 */
	@GetMapping(value ="/search.ajax")
	@ResponseBody
	public List<UserChatroomDTO> search(@RequestParam String query) {
		logger.info(query);
		return chatroom_ser.search(query);
	}
	
	/* 개인 채팅방 생성 */
	@PostMapping(value="/userchatroom.do")
	public String chatcreate(HttpSession session, UserChatroomDTO userchatroomdto, Model model, RedirectAttributes redirectAttributes) {
		
		String page;
		String userId = (String) session.getAttribute("loginId"); // 세션에서 로그인 아이디
		
		if(userId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {		
			int row = chatroom_ser.chatcreate(userchatroomdto, model, userId);
			
			if(row>0) {
				model.addAttribute("msg", "방이 개설되었습니다.");
				page = "/chat/userChatRoom";
			}else {
				logger.info("세션에 설정된 값: " + session.getAttribute("session"));
				page = "/chat/userChatList";
				model.addAttribute("msg", "방 생성 불가 : 개설된 방이 있습니다.");
			}
		}
		return page;
	}
	
	/* 생성한 채팅방 수정 */
	@PostMapping(value="/updatechatroom.ajax")
	@ResponseBody
	public ResponseEntity<String> updatechatroom(@RequestParam Map<String, String> params) {
		chatroom_ser.updatechatroom(params);
		return ResponseEntity.ok("Success");
	}
	
	/* 공지 등록, 수정 */
	@PostMapping(value="/updatenotice.ajax")
	@ResponseBody
	public ResponseEntity<String> updatenotice(@RequestParam String notice, int userchat_idx){
		chatroom_ser.updatenotice(notice, userchat_idx);
		return ResponseEntity.ok("Success");
	}
	
	/* 개인 채팅방 삭제(비공개) */
	@PostMapping(value="/deletechatroom.ajax")
	@ResponseBody
	 public ResponseEntity<String> deleteChatroom(@RequestParam String user_id, @RequestParam int userchat_idx, @RequestParam int chatroom_idx) {
		chatroom_ser.deleteroom(user_id, userchat_idx, chatroom_idx);
		return ResponseEntity.ok("Success");
    }
	
	/* 개인 채팅방 참여 */
	@RequestMapping(value="/userchatroom.go")
	public String chatroom(HttpSession session, Model model, UserChatroomDTO userChatroomdto) {
		
		String page;
		String user_id = (String) session.getAttribute("loginId");
		
		if(user_id==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			
			// 나의 채팅방 목록
			List<UserChatroomDTO> userchat_list = chatroom_ser.myroomlist(user_id);
			
			int idx = userChatroomdto.getUserchat_idx();
			String id = userChatroomdto.getUser_id();

			int current = chatroom_ser.current(idx);
			int total = chatparti_ser.usertotal(idx);
			
			logger.info("최대 인원수 = "+total);
			logger.info("현재 인원수 = "+current);
			
			model.addAttribute("roomin", user_id);

			// 참여 테이블에 사용자 인서트
		    	
	    	int roomin = chatparti_ser.roomin(user_id, idx);
	        
	        if(roomin == 0) {
	        	
	        	if (current <= total) {
	        		model.addAttribute("msg", "입장 인원 초과");
	        		page = "/chat/userChatList";
	        	}else {
	        		int row = chatparti_ser.userparti(user_id, idx);
		        	if (row > 0) {
		        		alarm_ser.partialarm(id);
		        		page = "/chat/userChatRoom";
		        	}
	        	}
	        }else {
	        	page = "/chat/userChatRoom";
	        	
	        }
	    
		
		
			
			
			// 방에 참여중인 총 사용자 
//			logger.info("idx :" + idx);
//			Integer usertotal =chatparti_ser.usertotal(idx);
//			logger.info("total:"+usertotal);
//			
//			model.addAttribute("usertotal", usertotal);
			
			// 방에 참여중인 사용자
//			List<PartiDTO> userlist =chatparti_ser.userlist(idx);
//			
//			Map<String, String> userNickname = new HashMap<String, String>();
//			Map<String, String> userPhoto = new HashMap<String, String>();
//			
//			for (PartiDTO list : userlist) {
//				String userlists = list.getUser_id();
//				if (!userNickname.containsKey(userlists)) {
//					UserDTO user = message_ser.getUserById(userlists);
//					if (user != null) {
//						userNickname.put(userlists, user.getUser_nickname());
//						userPhoto.put(userlists, user.getUser_photo());
//					}
//				}
//			}
//			
//			// 방에 해당하는 메세지 가져오기
//			List<UserMsgDTO> usermsg = message_ser.usermsg(idx);
//			
//			// 사용자 닉네임을 저장할 맵 생성
//			Map<String, String> userNicknames = new HashMap<String, String>();
//			Map<String, String> userPhotos = new HashMap<String, String>();
//			
//			// 메시지에서 user_id를 가져와서 닉네임 조회, 프로필사진
//			for (UserMsgDTO msg : usermsg) {
//				String messageUserId = msg.getUser_id();
//				if (!userNicknames.containsKey(messageUserId)) {
//					UserDTO user = message_ser.getUserById(messageUserId);
//					if (user != null) {
//						userNicknames.put(messageUserId, user.getUser_nickname());
//						userPhotos.put(messageUserId, user.getUser_photo());
//					}
//				}
//			}
			
			// 방 정보 가져오기
			List<UserChatroomDTO> roominfo = chatroom_ser.roominfo(idx);
			System.out.print(roominfo);
			
			model.addAttribute("list", userchat_list);
			model.addAttribute("idx", idx);
			model.addAttribute("userid", userChatroomdto.getUser_id());
			model.addAttribute("current", userChatroomdto.getCurrent_people());
//			model.addAttribute("usermsg", usermsg);
//			model.addAttribute("userNickname", userNickname);
//			model.addAttribute("userNicknames", userNicknames);
			model.addAttribute("roominfo",roominfo);
//			model.addAttribute("userlist",userlist); 
//			model.addAttribute("userPhoto",userPhoto);
//			model.addAttribute("userPhotos",userPhotos);

			page = "/chat/userChatRoom";
		}
		
		return page;
	}
	
	
	
	/* 지역 채팅방 리스트 */
	
	@RequestMapping(value ="/localchatlist.go")
	public String localchatlist(Model model) {
		
		List<UserChatroomDTO> localchat_list = chatroom_ser.localchatlist();
		model.addAttribute("list", localchat_list);
		logger.info("userchat_list :"+ localchat_list);
		
		return "chat/localChatList";
	}
	
	/* 지역 채팅방 참여 */
	
	@PostMapping(value="/localchatroom.go")
	public String localchatgo(HttpSession session, Model model, LocalChatroomDTO localChatroomdto) {
		
		String page;
		String userId = (String) session.getAttribute("loginId");
		
		if(userId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			
			int idx = localChatroomdto.getLocalchat_idx();
			
			System.out.print("idx:"+idx);
			
			// 지역 채팅방 입장
			chatparti_ser.localparti(userId, idx);
			
			List<UserChatroomDTO> localchat_list = chatroom_ser.localchatlist();
			model.addAttribute("list", localchat_list);
//			// 방에 참여중인 사용자
//			List<PartiDTO> localuserlist =chatparti_ser.localuserlist(idx);
//			
//
//			Map<String, String> userNickname = new HashMap<String, String>();
//			Map<String, String> userPhoto = new HashMap<String, String>();
//			
//			for (PartiDTO list : localuserlist) {
//				String userlists = list.getUser_id();
//				if (!userNickname.containsKey(userlists)) {
//					UserDTO user = message_ser.getUserById(userlists);
//					if (user != null) {
//						userNickname.put(userlists, user.getUser_nickname());
//						userPhoto.put(userlists, user.getUser_photo());
//					}
//				}
//			}
//			
//			// 방에 해당하는 메세지 가져오기
//			List<LocalMsgDTO> localmsg = message_ser.localmsg(idx);
//			
//		    // 사용자 닉네임을 저장할 맵 생성
//		    Map<String, String> userNicknames = new HashMap<String, String>();
//		    Map<String, String> userPhotos = new HashMap<String, String>();
//		    
//		    // 메시지에서 user_id를 가져와서 닉네임 조회
//		    for (LocalMsgDTO msg : localmsg) {
//		        String messageUserId = msg.getUser_id();
//		        if (!userNicknames.containsKey(messageUserId)) {
//		            UserDTO user = message_ser.getUserById(messageUserId);
//		            if (user != null) {
//		                userNicknames.put(messageUserId, user.getUser_nickname());
//		                userPhotos.put(messageUserId, user.getUser_photo());
//		            }
//		        }
//		    }
//		
		
			
			model.addAttribute("roomidx", idx);
//			model.addAttribute("userNickname", userNickname);
//			model.addAttribute("userNicknames", userNicknames);
//			model.addAttribute("userPhoto", userPhoto);
//			model.addAttribute("userPhotos", userPhotos);
//			model.addAttribute("localmsg",localmsg);
//			model.addAttribute("localuserlist",localuserlist);
			
			page ="/chat/localChatRoom";
		}
		return page;
	}
}
