package com.kh.festait.eventdetail.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.eventdetail.model.dao.EventDetailDao;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

@Service
public class EventDetailServiceImpl implements EventDetailService {

    @Autowired
    private EventDetailDao eventDAO;

    @Override
    public EventDetailVo selectEventDetail(int appId) {
        return eventDAO.selectEventDetail(appId);
    }
}
