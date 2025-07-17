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
     * APP_ID를 이용하여 특정 행사 상세 정보를 데이터베이스에서 조회
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체
     */
    
    @Override
    public EventVO selectEventDetail(int appId) {
        // SqlSessionTemplate의 selectOne 메서드를 사용하여 단일 행 조회
        // 첫 번째 인자는 "네임스페이스.쿼리ID", 두 번째 인자는 쿼리에 전달할 파라미터
        return sqlSession.selectOne("eventMapper.selectEventDetail", appId);
    }

}
