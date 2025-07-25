package com.kh.spring.security.model.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.spring.security.model.dao.SecurityDao;
import com.kh.spring.security.model.vo.UsersExt;
import com.kh.spring.users.model.vo.UsersVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SecurityServiceImpl implements SecurityService {
	
	private final SecurityDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UsersVo userVo = dao.loadUserByUsername(username); 
		
		if(userVo == null) {
			throw new UsernameNotFoundException(username);
		}
		
		return new UsersExt(userVo, userVo.getAuthorities()); 
	}

}