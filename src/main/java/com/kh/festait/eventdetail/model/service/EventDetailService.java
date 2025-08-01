package com.kh.festait.eventdetail.model.service;

import java.util.Map; // Map 임포트 추가

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

public interface EventDetailService {
	// 김현주 : 행사 관련 비즈니스 로직 (인터페이스)
	EventDetailVo selectEventDetail(Map<String, Object> paramMap);
    boolean isEventBookmarkedByUser(int userNo, int appId);
}