package com.sulbazi.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	String login(String id, String pw, String opt);

	boolean userRevoke(String id, String opt);

}
