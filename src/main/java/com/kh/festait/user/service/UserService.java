package com.kh.festait.user.service;

import java.util.Map;

import com.kh.festait.user.model.vo.User;

public interface UserService {
	
	Map<String,String> loginUser(User u);

	int insertUser(User u);

	int updateUser(User u);

	void updateUserChagePwd();
	
	int secessionUser(User u);
	
	User myPageUserInfo(String userId);

	User login(User u);
	
	String findUserIdEmail(String email);

	int updatePasswordByEmail(String email, String newPassword);

	int updateNick(String userId, String nickname);

	int updatePassword(String userId, String newPassword);
	
}
