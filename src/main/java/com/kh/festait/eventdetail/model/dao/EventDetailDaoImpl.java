package com.kh.festait.eventdetail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

@Repository // DAO(Repository)
public class EventDetailDaoImpl implements EventDetailDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public EventDetailVo selectEventDetail(int eventId) {
        return sqlSession.selectOne("eventMapper.selectEventDetail", eventId);
    }

}
