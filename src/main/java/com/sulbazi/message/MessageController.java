package com.sulbazi.message;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MessageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MessageService msg_ser;
	
	// 메세지 전송
    @PostMapping("/sendMessage.ajax")
    @ResponseBody
    public String sendmsg(@RequestParam String user_id, @RequestParam String usermsg_content, @RequestParam int userchat_idx, Model model) {
        msg_ser.sendmsg(user_id, usermsg_content, userchat_idx, model);
        return "success";
    }
    
    // 메세지 로드
    @GetMapping("/loadMessages.ajax")
    @ResponseBody
    public List<UserMsgDTO> getmsg(@RequestParam int userchat_idx) {
        return msg_ser.getmsg(userchat_idx);
    }

}
