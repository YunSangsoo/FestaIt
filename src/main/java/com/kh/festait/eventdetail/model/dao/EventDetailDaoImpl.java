package com.kh.festait.eventdetail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

@Repository // DAO(Repository)
public class EventDetailDaoImpl implements EventDetailDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /*
     * 행사 상세 정보 조회
     * 서비스 임플이랑 동일  
     */
    @Override
    public EventDetailVo selectEventDetail(int appId) {
        return sqlSession.selectOne("eventMapper.selectEventDetail", appId);
    }

}
