package com.kh.festait.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.user.model.dao.UserDao;
import com.kh.festait.user.service.UserApiService;

@Service
public class UserApiServiceImpl implements UserApiService{
	
	@Autowired
	private UserDao uDao;
	
	
	@Override
	public int idCheck(String userId) {
		return uDao.idCheck(userId);
	}
	
    @Override
    public int nickNameCheck(String nickName) {
    	return uDao.nickNameCheck(nickName);
    }
    
}
