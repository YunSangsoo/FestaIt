package com.kh.festait.memberboard.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.memberboard.model.vo.MemberBoardList;


@Mapper
public interface MemberBoardDao {

	int getTotalCount(String keyword);

	List<MemberBoardList> selectUserList(String keyword, int offset, int limit);

	void deleteUser(Long userNo);

	void deleteUserAuthorities(Long userNo);

	MemberBoardList selectUserById(Long userNo);

}
