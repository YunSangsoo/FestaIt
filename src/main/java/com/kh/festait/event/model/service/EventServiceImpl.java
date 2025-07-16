package com.kh.festait.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.event.model.dao.EventDAO;
import com.kh.festait.event.model.vo.EventVO;

@Service // 이 클래스가 Spring의 서비스 컴포넌트임을 나타냅니다.
public class EventServiceImpl implements EventService {

    @Autowired // Spring이 EventDAO 타입의 빈(Bean)을 자동으로 주입해줍니다.
    private EventDAO eventDAO;

    /**
     * APP_ID를 이용하여 특정 행사 상세 정보를 조회하는 비즈니스 로직을 구현합니다.
     * DAO를 호출하여 데이터베이스에서 EventVO를 가져옵니다.
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체 (없으면 null)
     */
    @Override // EventService 인터페이스의 메서드를 오버라이드합니다.
    public EventVO selectEventDetail(int appId) {
        // 여기에서 필요한 비즈니스 로직을 추가할 수 있습니다.
        // 예를 들어, 조회수 증가 로직, 데이터 가공 등
        return eventDAO.selectEventDetail(appId); // EventDAO를 통해 데이터베이스에서 정보를 가져옵니다.
    }
}
