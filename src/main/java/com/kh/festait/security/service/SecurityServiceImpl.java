package com.kh.festait.security.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.festait.security.model.dao.SecurityDao;
import com.kh.festait.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SecurityServiceImpl implements SecurityService{
	
	
	private final SecurityDao dao;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDetails user = dao.loadUserByUsername(username);
		
		if(user==null)
			throw new UsernameNotFoundException(username);
		return user;
	}
}
