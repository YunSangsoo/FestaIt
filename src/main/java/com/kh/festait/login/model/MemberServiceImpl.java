package com.kh.festait.login.model;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.login.model.dao.MemberDao;
import com.kh.festait.login.model.vo.Member;




@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member loginMember(String userId) {
		return null;
	}
	
	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(m);
	}

	@Override
	public int insertMember(Member m) {
		int result = memberDao.insertMember(m); 
		// 회원 ID와 기본 USER권한 추가
		memberDao.insertAuthority(m);
		
		return result;
	}

	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(m);
	}

	@Override
	public int idCheck(String userId) {
		return memberDao.idCheck(userId);
	}

	@Override
	public void updateMemberChagePwd() {

	}

	@Override
	public HashMap<String, Object> selectOne(String userId) {
		return memberDao.selectOne(userId);
	}

	@Override
    public int register(Member member) {
        return memberDao.insertMember(member);
    }

    @Override
    public boolean isDuplicateId(String userId) {
        return memberDao.selectMemberById(userId) != null;
    }
    
    @Override
    public int idCheckNickname(String nickname) {
    	return memberDao.idCheckNickname(nickname);
    }
    


}











