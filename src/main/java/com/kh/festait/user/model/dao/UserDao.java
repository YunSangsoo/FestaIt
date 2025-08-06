package com.kh.festait.user.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.festait.bookmark.model.vo.Bookmark;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
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

	User getUserByUser(User u);

	String findUserIdEmail(String email);

	int updatePasswordByEmail(Map<String, Object> paramMap);

	int updateNickname(Map<String, Object> param);

	int updatePassword(Map<String, Object> param);

	List<Bookmark> selectBookmarkList(Map<String, Object> param);

	List<ReviewBoard> selectReviewList(Map<String, Object> param);
}
