package com.kh.festait.user.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.bookmark.model.vo.Bookmark;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
import org.springframework.web.multipart.MultipartFile;

import com.kh.festait.common.model.vo.Image;
import com.kh.festait.user.model.vo.User;

public interface UserService {
	
	Map<String,String> loginUser(User u);

	int insertUser(User u);

	int updateUser(User u);

	void updateUserChagePwd();
	
	int secessionUser(User u);
	
	User myPageUserInfo(String userId);

	User login(User u);
	
	String findUserIdEmail(String email, String name);

	int updatePasswordByEmail(String userId, String newPassword);

	int updateNick(String userId, String nickname);

	int updatePassword(String userId, String newPassword);

	List<Bookmark> selectBookmarkList(Map<String,Object> param);

	List<ReviewBoard> selectReviewList(Map<String,Object> param);

	Image uploadProfile(MultipartFile file, int userNo);

	User myPageUserInfo(String userId, String name);
	
	
}
