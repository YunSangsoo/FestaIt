package com.kh.festait.eventdetail.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import java.util.Map;
 
@Repository
@RequiredArgsConstructor
@Slf4j
public class EventDetailDaoImpl implements EventDetailDao {

    private final SqlSessionTemplate sqlSession;  // MyBatis의 SqlSessionTemplate 사용
    
    @Override
    public EventDetailVo selectEventDetail(Map<String, Object> paramMap) {

        // MyBatis를 사용하여 DB에서 'eventDetail.selectEventDetail' 쿼리 실행
        EventDetailVo resultVo = sqlSession.selectOne("eventDetail.selectEventDetail", paramMap);

        // 조회된 이벤트 상세 정보를 반환
        return resultVo;
    }
}
