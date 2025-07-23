package com.kh.festait.eventboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.eventboard.model.vo.EventBoard;

@Mapper
public interface EventBoardDao {

	EventBoard selectEventById(int eventId);

	List<EventBoard> selectEventList(Map<String, Object> paramMap);

	int getEventCount();

}
