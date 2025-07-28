package com.kh.festait.login.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.login.model.vo.Member;



@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member loginMember(Member m) {
		return sqlSession.selectOne("member.loginMember", m);
	}
	
	@Override
	public Member loginUser(String userId) {
		
		return null;
	}

	@Override
	public int insertMember(Member m) {
		return sqlSession.insert("member.insertMember", m);
	}

	@Override
	public int updateMember(Member m) {
		return sqlSession.update("member.updateMember", m);
	}

	@Override
	public int idCheck(String userId) {
		return sqlSession.selectOne("member.idCheck", userId);
	}

	@Override
	public void updateMemberChagePwd() {
		
	}

	@Override
	public HashMap<String, Object> selectOne(String userId) {
		return sqlSession.selectOne("member.selectOne", userId);
	}

	@Override
	public void insertAuthority(Member m) {	
		sqlSession.insert("member.insertAuthority",m);
	}

	@Override
	public Member selectMemberById(String userId) {
		return null;
		
	}

	@Override
	public int idCheckNickname(String nickname) {
		return sqlSession.selectOne("member.idCheckNickname", nickname);
	}
	
	
}
