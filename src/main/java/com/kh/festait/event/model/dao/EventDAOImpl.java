package com.kh.festait.event.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.event.model.vo.EventVO;

@Repository // 이 클래스가 Spring의 DAO(Repository) 컴포넌트임을 나타냅니다.
public class EventDAOImpl implements EventDAO { // EventDAO 인터페이스를 구현합니다.

    @Autowired // Spring이 SqlSessionTemplate 타입의 빈(Bean)을 자동으로 주입해줍니다.
    private SqlSessionTemplate sqlSession;

    /**
     * APP_ID를 이용하여 특정 행사 상세 정보를 데이터베이스에서 조회합니다.
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체 (없으면 null)
     */
    @Override // EventDAO 인터페이스의 메서드를 오버라이드합니다.
    public EventVO selectEventDetail(int appId) {
        // SqlSessionTemplate의 selectOne 메서드를 사용하여 단일 행을 조회합니다.
        // 첫 번째 인자는 "네임스페이스.쿼리ID", 두 번째 인자는 쿼리에 전달할 파라미터입니다.
        return sqlSession.selectOne("eventMapper.selectEventDetail", appId);
    }

}
