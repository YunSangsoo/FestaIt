package com.kh.festait.event.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.event.model.vo.EventVO;

@Repository // DAO(Repository)
public class EventDAOImpl implements EventDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /*
     * 행사 상세 정보 조회
     * 서비스 임플이랑 동일  
     */
    @Override
    public EventVO selectEventDetail(int appId) {
        return sqlSession.selectOne("eventMapper.selectEventDetail", appId);
    }

}
