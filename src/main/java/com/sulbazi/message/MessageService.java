package com.sulbazi.message;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sulbazi.member.UserDTO;

@Service
public class MessageService<Objcet> {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired UserMsgDAO usermsg_dao;
	@Autowired LocalMsgDAO localmsg_dao;
	
	/* 개인 채팅방 입장 시 해당 방 메세지들 출력 *//* 메세지 로드 */
	public List<UserMsgDTO> usermsg(int idx) {
		List<UserMsgDTO> content = usermsg_dao.usermsg(idx);
		return content;
	}

	/* 채팅방에서 각 메세지 작성한 id가지고 닉네임 뽑기 */
	public UserDTO getUserById(String messageUserId) {
		return usermsg_dao.getUserById(messageUserId);
	}

	/* 지역 채팅방 입장 시 해당 방 메세지들 출력 */
	public List<LocalMsgDTO> localmsg(int idx) {
		List<LocalMsgDTO> content = localmsg_dao.localmsg(idx);
		return content;
	}
	
	/* 메세지 전송 - 개인 */
	public void sendmsg(String user_id, String usermsg_content, int userchat_idx, Model model) {
		
		UserMsgDTO message = new UserMsgDTO();
		message.setUserchat_idx(userchat_idx);
        message.setUser_id(user_id);
        message.setUsermsg_content(usermsg_content);
        int row = usermsg_dao.sendmsg(message);
        if(row>0) {
        	int idx = message.getUsermsg_idx();
        	model.addAttribute(idx);
        	logger.info("방금 insert한 msg idx : "+idx);
        }
	}

	/* 메세지 로드 - 개인 */
    public List<UserMsgDTO> getmsg(int userchat_idx) {
        return usermsg_dao.getmsg(userchat_idx);
    }
    
    
   /* 메세지 전송 - 지역 */
	public void localsendmsg(String user_id, String localmsg_content, int localchat_idx, Model model) {
		
		LocalMsgDTO message = new LocalMsgDTO();
		message.setLocalchat_idx(localchat_idx);
		message.setUser_id(user_id);
		message.setLocalmsg_content(localmsg_content);
		int row = localmsg_dao.localsendmsg(message);
		if(row>0) {
			int idx = message.getLocalmsg_idx();
			model.addAttribute(idx);
			logger.info("방금 insert한 local msg idx : "+idx);
		}
	}
    
	/* 메세지 로드 - 지역 */
	public List<UserMsgDTO> getlocalmsg(int localchat_idx) {
		return localmsg_dao.getlocalmsg(localchat_idx);
	}
    
    
   public String userreportedIdx(int reported_idx) {
	      return usermsg_dao.userreportedIdx(reported_idx);
	   }

   public String localreportedIdx(int reported_idx) {
      return localmsg_dao.localreportedIdx(reported_idx);
   }











	

}
