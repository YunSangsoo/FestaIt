package com.kh.festait.memberboard.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.memberboard.model.vo.MemberBoardList;



@Repository
public class MemberBoardDaoImpl implements MemberBoardDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

	@Override
	public int getTotalCount(String keyword) {
		return sqlSession.selectOne("memberBoardMapper.getTotalCount", keyword);
	}

	@Override
	public List<MemberBoardList> selectUserList(String keyword, int offset, int limit) {
		Map<String, Object> params = new HashMap<>();
	    params.put("keyword", keyword);
	    params.put("offset", offset);
	    params.put("limit", limit);

	    return sqlSession.selectList("memberBoardMapper.selectUserList", params);
	}

	@Override
	public void deleteUser(Long userNo) {
		sqlSession.delete("memberBoardMapper.deleteUser", userNo);
		
	}

	@Override
	public void deleteUserAuthorities(String userId) {
		sqlSession.delete("memberBoardMapper.deleteUserAuthorities", userId);
	}

	@Override
	public MemberBoardList selectUserById(Long userNo) {
		return sqlSession.selectOne("memberBoardMapper.selectUserById", userNo);
	}

	@Override
	public String getUserIdByUserNo(Long userNo) {
		 return sqlSession.selectOne("memberBoardMapper.getUserIdByUserNo", userNo);
	}


}