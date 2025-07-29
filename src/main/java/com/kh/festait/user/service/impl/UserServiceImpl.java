package com.kh.festait.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.user.model.dao.UserDao;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.service.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao uDao;
	
	@Override
	public Map<String, String> loginUser(User u) {
		
		Map<String , String> loginMap = new HashMap<String, String>();
		String userMatch = uDao.loginUser(u);
		
		System.out.println("USER match :: "+userMatch);
		loginMap.put("SUCCES_YN", userMatch);
		
		if ("Y".equals(userMatch)) {
			User userInfo = uDao.selectUserInfo(u);
			
			System.out.println("userInfo : "+userInfo.toString());
			loginMap.put("USER_NAME", userInfo.getUserName());
			loginMap.put("USER_ID", userInfo.getUserId());
			loginMap.put("NICK_NAME", userInfo.getNickname());
//			loginMap.put("COMP_ID", userInfo.getCompId());
			loginMap.put("PHONE", userInfo.getPhone());
			loginMap.put("EMAIL", userInfo.getEmail());
			loginMap.put("ADDR", userInfo.getAddr());
			
			u.setUserNo(userInfo.getUserNo());
			uDao.userLastLoaginAtUpdate(u);
		}
		
		return loginMap;
	}

	@Override
	//회원가입
	public int insertUser(User u) {
		
		int result = uDao.insertUser(u);
		
		uDao.insertAuthority(u);
	    //uDao.insertAuthority(u);
		return result;
	}

	@Override
	//회원정보 수정
	public int updateUser(User u) {
		return uDao.updateUser(u);
	}

	@Override
	public void updateUserChagePwd() {
		
	}

	@Override
	//회원 탈퇴
	public int secessionUser(User u) {
		return uDao.secessionUser(u);
	}

	@Override
	//마이페이지 회원정보 조회
	public User myPageUserInfo(String userId) {
		return uDao.myPageUserInfo(userId);
	}

	@Override
	public User login(User u) {
		return uDao.getUserByUser(u);
	}


}
