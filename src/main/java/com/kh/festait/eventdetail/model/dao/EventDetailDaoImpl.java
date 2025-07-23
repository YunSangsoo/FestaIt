package com.kh.festait.eventdetail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class EventDetailDaoImpl implements EventDetailDao {

    private final SqlSessionTemplate sqlSession;

    @Override
    public EventDetailVo selectEventDetail(int appId) {
        // ⭐⭐ 이 호출의 "eventDetail" 부분이 매퍼 XML의 namespace와 일치해야 합니다. ⭐⭐
        log.info("이벤트 상세 조회 DAO 호출 - appId: {}", appId);
        return sqlSession.selectOne("eventDetail.selectEventDetail", appId);
    }
}
