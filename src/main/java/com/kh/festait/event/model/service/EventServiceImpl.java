package com.kh.festait.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.event.model.dao.EventDAO;
import com.kh.festait.event.model.vo.EventVO;

@Service
public class EventServiceImpl implements EventService  {
	// 김현주 : EventService 구현체
    @Autowired
    private EventDAO eventDAO;

    @Override
    public EventVO getEventById(int eventId) {
        return eventDAO.selectEventById(eventId);
    }

    @Override
    public List<EventVO> getAllEvents() {
        return eventDAO.selectAllEvents();
    }
}
