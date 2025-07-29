package com.kh.festait.login.model;

import java.util.HashMap;

import com.kh.festait.login.model.vo.Member;

public interface MemberService {
	
Member loginMember(String userId);
	
	Member loginMember(Member m);

	int insertMember(Member m);

	int updateMember(Member m);

	int idCheck(String userId);

	void updateMemberChagePwd();

	HashMap<String, Object> selectOne(String userId);
	
	int idCheckNickname(String nickname);
	
	// 아래 두개는 내가 추가한코드
	int register(Member member);
	
	boolean isDuplicateId(String userId);
}
