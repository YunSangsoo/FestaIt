package com.kh.festait.eventdetail.model.dao;

import java.util.Map; // Map 임포트 추가

import com.kh.festait.eventdetail.model.vo.EventDetailVo;


public interface EventDetailDao {
	// 김현주 : 행사 관련 DB 접근 (인터페이스)
	
	 /*
     * 행사 상세 정보 조회
     * @param paramMap 조회할 행사 ID (appId) 및 사용자 ID (userNo)
     * @return 조회된 행사 정보
     */
	EventDetailVo selectEventDetail(Map<String, Object> paramMap); 


}
