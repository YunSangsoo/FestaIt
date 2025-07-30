package com.kh.festait.memberboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	@Override
	 public void deleteUser(Long userNo) {
        String userId = memberBoardDao.getUserIdByUserNo(userNo);
        if (userId != null) {
            memberBoardDao.deleteUserAuthorities(userId);  // userId 기준 권한 삭제
        }
        memberBoardDao.deleteUser(userNo);  // userNo 기준 사용자 삭제
    }

	@Override
	public MemberBoardList selectUserById(Long userNo) {
		return memberBoardDao.selectUserById(userNo);
	}

	@Override
	public String getUserIdByUserNo(Long userNo) {
		return memberBoardDao.getUserIdByUserNo(userNo);
	}
 
    
}