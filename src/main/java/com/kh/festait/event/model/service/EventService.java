package com.kh.festait.event.model.service;

import java.util.List;

import com.kh.festait.event.model.vo.EventVO;

public interface EventService {
	// 김현주 : 행사 관련 비즈니스 로직 (인터페이스)
	
    /*
     * 행사 상세 정보 조회
     * 이벤트 다오랑 동일
     */
	    EventVO selectEventDetail(int appId);
}
