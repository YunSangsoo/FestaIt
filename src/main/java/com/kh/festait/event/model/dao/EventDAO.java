package com.kh.festait.event.model.dao;

import com.kh.festait.event.model.vo.EventVO;


public interface EventDAO {
	// 김현주 : 행사 관련 DB 접근 (인터페이스)
	
    /*
     * 행사 상세 정보 조회
     * @param appId 조회할 행사 ID
     * @return 조회된 행사 정보
     */
    EventVO selectEventDetail(int appId);
}
