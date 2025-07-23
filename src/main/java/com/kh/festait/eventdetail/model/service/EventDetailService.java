package com.kh.festait.eventdetail.model.service;

import java.util.List;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

public interface EventDetailService {
	// 김현주 : 행사 관련 비즈니스 로직 (인터페이스)
	
    /*
     * 행사 상세 정보 조회
     * @param appId 조회할 행사 ID (EVENT 테이블의 appId)
     * @return 조회된 행사 정보
     */
    EventDetailVo selectEventDetail(int appId);
}
