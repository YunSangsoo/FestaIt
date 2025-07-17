package com.kh.festait.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.event.model.dao.EventDAO;
import com.kh.festait.event.model.vo.EventVO;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDAO eventDAO;

    /**
     * APP_ID를 이용하여 특정 행사 상세 정보를 조회하는 비즈니스 로직 구현
     * DAO를 호출하여 데이터베이스에서 EventVO를 가져오기
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체
     */
    @Override
    public EventVO selectEventDetail(int appId) {
    	// 조회수 증가 추가 예정
    	
        return eventDAO.selectEventDetail(appId); // EventDAO를 통해 데이터베이스에서 정보 가져오깅
    }
}
