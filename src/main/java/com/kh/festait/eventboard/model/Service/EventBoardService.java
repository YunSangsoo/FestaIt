package com.kh.festait.eventboard.model.Service;

import java.util.List;

import com.kh.festait.eventboard.model.vo.EventBoard;

public interface EventBoardService {
    
    EventBoard selectEventById(int eventId);

	List<EventBoard> selectEventList(int offset, int limit);

	int getEventCount();

}
