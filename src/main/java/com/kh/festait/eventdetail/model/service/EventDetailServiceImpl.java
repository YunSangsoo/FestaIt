package com.kh.festait.eventdetail.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.eventdetail.model.dao.EventDetailDao;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

@Service
public class EventDetailServiceImpl implements EventDetailService {

    @Autowired
    private EventDetailDao eventDAO;

    /*
     * 행사 상세 정보 조회
     * @param appId 조회할 행사 ID
     * @return 조회된 행사 정보
     */
    @Override
    public EventDetailVo selectEventDetail(int eventId) {
        // 조회수 증가 만들면 여기다가 넣으면 됌
        return eventDAO.selectEventDetail(eventId);
    }
}
