package com.kh.spring.security.model.dao;

import com.kh.spring.users.model.vo.UsersVo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SecurityDaoImpl implements SecurityDao{
	
	private final SqlSessionTemplate session;
	
	@Override
	public UsersVo loadUserByUsername(String username) {
		return session.selectOne("security.loadUserByUsername", username);
	}

}