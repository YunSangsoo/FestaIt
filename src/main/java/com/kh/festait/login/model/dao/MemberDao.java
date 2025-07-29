package com.kh.festait.login.model.dao;

import java.util.HashMap;

import com.kh.festait.login.model.vo.Member;

public interface MemberDao {

	Member loginUser(String userId);

	int insertMember(Member m);

	int updateMember(Member m);

	int idCheck(String userId);

	void updateMemberChagePwd();

	Member loginMember(Member m);

	HashMap<String, Object> selectOne(String userId);

	void insertAuthority(Member m);
	
	int idCheckNickname(String nickname);
	
	// 내가 추가한 코드
	Member selectMemberById(String userId);
}

// 중복확인??

//public int dupecateId(String id) {
//	int cnt=0;
//	try {
//		Connection con=DBOpen.getConection();
//		StringBuilder sql=new StringBuilder();
//		
//		sql.append(" SELECT count(id) as cnt ");
//		sql.append("FROM member");
//		sql.append("WHERE id = ?");
//		
//		PreparedStatement pstmt=con.prepareStatement(sql.toString());
//		pstmt.setString(1, id);
//		
//		ResultSet rs=pstmt.executeQuery();
//		if(rs.next()) {
//			cnt=rs.getInt("cnt");
//		}
//	}catch(Exception e) {
//		System.out.println("아이디 중복확인 실패 : "+ e);
//	}
//}
















