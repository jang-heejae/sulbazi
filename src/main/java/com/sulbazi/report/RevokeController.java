package com.sulbazi.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;
@SpringBootApplication
@EnableScheduling
@Controller
public class RevokeController {
	@Autowired RevokeService revoke_ser;

	    public static void revokeSchedule(String[] args) {
	        SpringApplication.run(RevokeController.class, args);
	    }
}
