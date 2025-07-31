package com.kh.festait.eventboard.model.Service;

import java.util.List;
import java.util.Map;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.eventboard.model.vo.EventBoard;

public interface EventBoardService {
    
    EventBoard selectEventById(int eventId);

	List<EventBoard> selectEventList(PageInfo pi, Map<String, Object> paramMap);

	int selectEventCount(Map<String, Object> paramMap);

}
