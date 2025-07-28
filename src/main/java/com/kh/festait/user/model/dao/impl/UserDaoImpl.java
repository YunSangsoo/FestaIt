package com.kh.festait.user.model.dao.impl;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.festait.user.model.dao.UserDao;
import com.kh.festait.user.model.vo.MyPageBookmark;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.model.vo.myPageReview;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	//회원 로그인
	public String loginUser(User u) {
		return sqlSession.selectOne("user.loginCheck", u);
	}

	@Override 
	//회원가입 
	public int insertUser(User u) {
		
		//회원가입할때 라디오체크가 사업자면 COMPANY 테이블 INSERT한다.
		if ("사업자".equals(u.getUserType())) {
				sqlSession.insert("user.insertCompany", u);

				//COMPANY 테이블 INSERT 하면 COMP_ID 조회 후 USERS테이블에 넣어줘야함.
				int result2 = sqlSession.selectOne("user.selectCompId", u);
				//u.setCompId(compId);
		}	
		
		//개인이든 사업자든 상관없이 USERS 테이블에 INSERT한다.
		int result = sqlSession.insert("user.insertUser", u);
		return result;
	}

	@Override
	//회원 정보 수정
	public int updateUser(User u) {
		return sqlSession.update("user.updateUserInfo", u);
	}

	@Override
	//아이디 중복확인
	public int idCheck(String userId) {
		return sqlSession.selectOne("user.idCheck", userId);
	}
	
	@Override
	//닉네임 중복확인
	public int nickNameCheck(String nickName) {
		return sqlSession.selectOne("user.nickNameCheck", nickName);
	}
	

	@Override
	public void updateUserChagePwd() {
		
	}

	@Override
	//????
	public void insertAuthority(User u) {	
		sqlSession.insert("user.insertAuthority",u);
	}

	@Override
	public User selectUserById(String userId) {
		return null;
		
	}


	@Override
	//로그인한 회원정보 임시로 담을거
	public User selectUserInfo(User u) {
		return sqlSession.selectOne("user.selectUserInfo", u);
	}

	@Override
	//회원탈퇴
	public int secessionUser(User u) {
		return sqlSession.update("user.updateUserStatus", u);
	}

	@Override
	//마이페이지 북마크 조회
	public List<MyPageBookmark> myPageBookMarkList(String userId) {
		return sqlSession.selectList("user.myPageUserBookMark", userId);
	}

	@Override
	//마이페이지 리뷰 조회
	public List<myPageReview> myPageReviewList(String userId) {
		return sqlSession.selectList("user.myPageUserReview", userId);
	}

	@Override
	//최종 로그인 일시 수정
	public void userLastLoaginAtUpdate(User u) {
		sqlSession.update("user.userLastLoaginAtUpdate", u);
	}

	@Override
	//마이페이지에서 조회할 유저정보 
	public User myPageUserInfo(String userId) {
		return sqlSession.selectOne("user.myPageUserInfo", userId);
	}
	
}
