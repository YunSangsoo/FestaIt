package com.kh.festait.mainpage.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.eventboard.model.dao.EventBoardDaoImpl;
import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MainpageDaoImpl implements MainpageDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	Map<String, Object> paramMap = new HashMap<>();

	@Override
	public List<NoticeBoard> selectNoticeList(int limit) {
	    paramMap.put("limit", limit);
		return sqlSession.selectList("mainpageMapper.selectNoticeList", paramMap);
	}

	@Override
	public List<EventBoard> selectEventList(int limit) {
		paramMap.put("limit", limit);
		return sqlSession.selectList("mainpageMapper.selectEventList", paramMap);
	}

	@Override
	public List<EventBoard> selectTodayEventList(int limit) {
		paramMap.put("limit", limit);

	    System.out.println(sqlSession.selectList("mainpageMapper.selectTodayEventList", paramMap).size());
		return sqlSession.selectList("mainpageMapper.selectTodayEventList", paramMap);
	}
}
