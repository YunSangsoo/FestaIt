package com.kh.festait.eventboard.model.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.eventboard.model.dao.EventBoardDao;
import com.kh.festait.eventboard.model.vo.EventBoard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventBoardServiceImpl implements EventBoardService {
	
	@Autowired
    private EventBoardDao eventBoardDao;

	
	@Override
	public int getEventCount() {
		return eventBoardDao.getEventCount();
	}

	@Override
	public EventBoard selectEventById(int eventId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EventBoard> selectEventList(int offset, int limit) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startRow", offset);
		paramMap.put("endRow", offset + limit);
		
		return eventBoardDao.selectEventList(paramMap);
	}
		
//	@Override
//	public EventBoard selectEventById(int eventId) {
//		return eventBoardDao.selectEventById(eventId);
//	}
//
//
}
