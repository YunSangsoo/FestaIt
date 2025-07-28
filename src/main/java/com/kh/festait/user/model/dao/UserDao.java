package com.kh.festait.user.model.dao;

import java.util.List;

import com.kh.festait.user.model.vo.MyPageBookmark;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.model.vo.myPageReview;

public interface UserDao {
	
	int insertUser(User u);
	
	int updateUser(User u);
	
	int idCheck(String userId);
	
	void updateUserChagePwd();
	
	String loginUser(User u);
	
	void insertAuthority(User u);
	
	int nickNameCheck(String nickName);
	
	User selectUserById(String userId);
	
	User selectUserInfo(User u);
	
	int secessionUser(User u);
	
	List<MyPageBookmark> myPageBookMarkList(String userId);
	
	List<myPageReview> myPageReviewList(String userId);
	
    void userLastLoaginAtUpdate(User u);
    
    User myPageUserInfo(String userId);
}
