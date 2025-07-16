package com.kh.festait.event.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.event.model.vo.EventVO;

@Repository
public class EventDAOImpl implements EventDAO {
	// 김현주 : EventDAO 구현체
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public EventVO selectEventById(int eventId) {
        return sqlSession.selectOne("event.selectEventById", eventId);
    }

    @Override
    public List<EventVO> selectAllEvents() {
        return sqlSession.selectList("event.selectAllEvents");
    }
}
