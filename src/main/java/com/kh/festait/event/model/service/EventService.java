package com.kh.festait.event.model.service;

import java.util.List;

import com.kh.festait.event.model.vo.EventVO;

public interface EventService {
	// 김현주 : 행사 관련 비즈니스 로직 (인터페이스)
	
    EventVO getEventById(int eventId);
    List<EventVO> getAllEvents();	
	
}
