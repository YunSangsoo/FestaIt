package com.kh.festait.eventdetail.model.dao;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;


public interface EventDetailDao {
	// 김현주 : 행사 관련 DB 접근 (인터페이스)
	
    /*
     * 행사 상세 정보 조회
     * @param appid 조회할 행사 ID (EVENT 테이블의 EVENT_ID)
     * @return 조회된 행사 정보
     */
    EventDetailVo selectEventDetail(int appId);
}
