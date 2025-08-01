package com.kh.festait.eventdetail.model.dao;

import java.util.Map;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;


public interface EventDetailDao {
	
	// 행사 상세 정보 조회
	EventDetailVo selectEventDetail(Map<String, Object> paramMap); 

}
