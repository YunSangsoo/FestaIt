package com.kh.festait.event.model.service;

import java.util.List;

import com.kh.festait.event.model.vo.EventVO;

public interface EventService {
	// 김현주 : 행사 관련 비즈니스 로직 (인터페이스)
	
    /*
     * APP_ID를 이용하여 특정 행사 상세 정보를 조회하는 서비스 메서드를 정의
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체 (없으면 null)
     */
    EventVO selectEventDetail(int appId);
	
}
