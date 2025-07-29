package com.kh.festait.memberboard.model.service;

import java.util.List;
import com.kh.festait.memberboard.model.vo.MemberBoardList;

public interface MemberBoardService {

	int getTotalCount(String keyword);

	List<MemberBoardList> selectUserList(String keyword, int page, int limit);

	void deleteUser(Long userNo);

	MemberBoardList selectUserById(Long userNo);
	

}
