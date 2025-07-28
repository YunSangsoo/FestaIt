package com.kh.festait.memberboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.memberboard.model.dao.MemberBoardDao;
import com.kh.festait.memberboard.model.vo.MemberBoardList;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberBoardServiceImpl implements MemberBoardService {

    @Autowired
    private MemberBoardDao memberBoardDao;

	@Override
	public int getTotalCount(String keyword) {
		 return memberBoardDao.getTotalCount(keyword);
	}

	@Override
	public List<MemberBoardList> selectUserList(String keyword, int page, int limit) {
		int offset = (page - 1) * limit;  // 페이지 계산 (예: 1페이지면 0부터)
	    return memberBoardDao.selectUserList(keyword, offset, limit);
	}

	@Override
	public void deleteUser(Long userNo) {
		memberBoardDao.deleteUserAuthorities(userNo);
	    memberBoardDao.deleteUser(userNo);
		
	}

	@Override
	public MemberBoardList selectUserById(Long userNo) {
		return memberBoardDao.selectUserById(userNo);
	}
 
    
}