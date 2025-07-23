package com.kh.festait.eventboard.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.eventboard.model.vo.EventBoard;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EventBoardDaoImpl implements EventBoardDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public EventBoard selectEventById(int eventId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EventBoard> selectEventList(Map<String, Object> paramMap) {
		int result = sqlSession.selectList("eventMapper.selectEventList").size();
		log.debug("행사 수 확인 중: {}",result);
		
		return sqlSession.selectList("eventMapper.selectEventList", paramMap);
	}

	@Override
	public int getEventCount() {
		return sqlSession.selectOne("eventMapper.getEventCount");
	}
//	@Override
//	public EventBoard selectEventById(int noticeId) {
//		return sqlSession.selectOne("eventMapper.selectEventById", noticeId);
//	}
//
//	@Override
//	public int getEventCount() {
//		return sqlSession.selectOne("eventMapper.getEventCount");
//	}

}
