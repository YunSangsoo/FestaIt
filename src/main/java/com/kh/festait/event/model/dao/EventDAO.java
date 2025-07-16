package com.kh.festait.event.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.event.model.vo.EventVO;

@Mapper
public interface EventDAO {
	// 김현주 : 행사 관련 DB 접근 (인터페이스
    EventVO selectEventById(int eventId);
    List<EventVO> selectAllEvents();
}
