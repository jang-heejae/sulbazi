package com.sulbazi.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	String login(String id, String pw, String opt);

	String userfindpw(String id, String user_email);

	String storefindpwdo(String store_id, String store_number);

	int changeuserpw(String id, String newPassword);

	int changestorepw(String store_number, String newPassword);

	String userfindiddo(String email);

	String storefindiddo(String number);
	boolean userRevoke(String id, String opt);

}
