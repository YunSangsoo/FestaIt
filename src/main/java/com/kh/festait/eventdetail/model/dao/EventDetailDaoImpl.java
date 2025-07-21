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
     * @param eventId 조회할 행사 ID (EVENT 테이블의 EVENT_ID)
     * @return 조회된 행사 정보
     */
    @Override
    public EventDetailVo selectEventDetail(int eventId) { // ⭐️ appId -> eventId로 변경
        // eventMapper.xml의 selectEventDetail 쿼리도 eventId를 받도록 수정해야 합니다.
        return sqlSession.selectOne("eventMapper.selectEventDetail", eventId); // ⭐️ appId -> eventId로 변경
    }

}
