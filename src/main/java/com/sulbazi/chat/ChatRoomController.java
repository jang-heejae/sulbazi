package com.sulbazi.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sulbazi.member.UserDTO;
import com.sulbazi.message.MessageService;
import com.sulbazi.message.UserMsgDTO;

@Controller
public class ChatRoomController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomService chatroom_ser;
	@Autowired MessageService message_ser;
	
	/* 개인 채팅방 리스트 */
	
	@RequestMapping(value ="/userchatlist.go")
	public String chatlist(HttpSession session, Model model) {
		
		List<UserChatroomDTO> userchat_list = chatroom_ser.chatlist();
		model.addAttribute("list", userchat_list);
		logger.info("userchat_list :"+ userchat_list);
		logger.info("세션아이디 : "+session.getAttribute("loginId"));
		
		return "chat/userChatList";
	}
	
	/* 유저 채팅방 개설 */
	
	@PostMapping(value="/userchatroom.do")
	public String chatcreate(HttpSession session, UserChatroomDTO userchatroomdto, Model model, RedirectAttributes redirectAttributes) {
		
		String page;
		String userId = (String) session.getAttribute("loginId"); // 세션에서 로그인 아이디
		
		if(userId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {		
			int row = chatroom_ser.chatcreate(userchatroomdto, model);
			
			if(row>0) {
				model.addAttribute("msg", "방이 개설되었습니다.");
				page = "/chat/userChatRoom";
			}else {
				logger.info("세션에 설정된 값: " + session.getAttribute("session"));
				model.addAttribute("msg", "방 생성 불가 : 개설된 방이 있습니다.");
				page = "/chat/userChatRoom";
			}
		}
		return page;
	}
	
	/* 개인 채팅방 참여 */
	@RequestMapping(value="/userchatroom.go")
	public String chatroom(HttpSession session, Model model, UserChatroomDTO userChatroomdto, UserMsgDTO usermsgdto) {
		
		String page;
		String userId = (String) session.getAttribute("loginId");
		
		if(userId==null) {
			model.addAttribute("msg", "로그인 해라");
			page = "/member/login";
		}else {	
			List<UserChatroomDTO> userchat_list = chatroom_ser.chatroom(userId);
			
			int idx = userChatroomdto.getUserchat_idx();
			List<UserMsgDTO> usermsg = message_ser.msg(idx);
			
		    // 사용자 닉네임을 저장할 맵 생성
		    Map<String, String> userNicknames = new HashMap<String, String>();
		    
		    // 메시지에서 user_id를 가져와서 닉네임 조회
		    for (UserMsgDTO msg : usermsg) {
		        String messageUserId = msg.getUser_id();
		        if (!userNicknames.containsKey(messageUserId)) {
		            UserDTO user = message_ser.getUserById(messageUserId);
		            if (user != null) {
		                userNicknames.put(messageUserId, user.getUser_nickname());
		            }
		        }
		    }
		
			model.addAttribute("list", userchat_list);
			model.addAttribute("idx", idx);
			model.addAttribute("userid", userChatroomdto.getUser_id());
			model.addAttribute("subject", userChatroomdto.getUserchat_subject());
			model.addAttribute("usermsg", usermsg);
			model.addAttribute("userNicknames", userNicknames);
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
	
	/* 지역 채팅방 입장 */
	@RequestMapping(value="/localchatroom.go")
	public String localchatgo(HttpSession session, Model model) {
		
		String userId = (String) session.getAttribute("loginId");
		List<LocalChatroomDTO> localchat_list = chatroom_ser.localroom();
		model.addAttribute("list", localchat_list);
		
		return "chat/localChatRoom";
	}
}
