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

    private final SqlSessionTemplate sqlSession;
    
    @Override
    public EventDetailVo selectEventDetail(Map<String, Object> paramMap) {
       EventDetailVo resultVo = sqlSession.selectOne("eventDetail.selectEventDetail", paramMap);
        return resultVo;
    }
}
