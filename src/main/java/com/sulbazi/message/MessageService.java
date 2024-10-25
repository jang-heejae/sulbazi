package com.sulbazi.message;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sulbazi.member.UserDTO;

@Service
public class MessageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired UserMsgDAO usermsg_dao;
	
	/* 개인 채팅방 입장 시 해당 방 메세지들 출력 */
	public List<UserMsgDTO> msg(int idx) {
		
		List<UserMsgDTO> content = usermsg_dao.msg(idx);
		return content;
	}

	/* 개인 채팅방에서 각 메세지 작성한 id가지고 닉네임 뽑기 */
	public UserDTO getUserById(String messageUserId) {
		return usermsg_dao.getUserById(messageUserId);
	}
	

}
