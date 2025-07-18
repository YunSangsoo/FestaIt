package com.kh.festait.event.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.event.model.dao.EventDAO;
import com.kh.festait.event.model.vo.EventVO;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDAO eventDAO;

    /*
     * 행사 상세 정보 조회
     * @param appId 조회할 행사 ID
     * @return 조회된 행사 정보
     */
    @Override
    public EventVO selectEventDetail(int appId) {
        // 조회수 증가 만들면 여기다가 넣으면 됌
        return eventDAO.selectEventDetail(appId);
    }
}
