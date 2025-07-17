package com.kh.festait.event.model.dao;

import com.kh.festait.event.model.vo.EventVO;


public interface EventDAO {
	// 김현주 : 행사 관련 DB 접근 (인터페이스)
	
	/*
     * APP_ID를 이용하여 특정 행사 상세 정보를 데이터베이스에서 조회
     * @param appId 조회할 행사의 APP_ID
     * @return 조회된 EventVO 객체
     */
	
    EventVO selectEventDetail(int appId);
    
}
