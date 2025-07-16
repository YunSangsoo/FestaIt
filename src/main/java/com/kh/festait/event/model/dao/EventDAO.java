package com.kh.festait.event.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.event.model.vo.EventVO;


public interface EventDAO {
	// 김현주 : 행사 관련 DB 접근 (인터페이스
	/**
     * APP_ID를 이용하여 특정 행사 상세 정보를 데이터베이스에서 조회합니다.
     * @param appId 조회할 행사의 APP_ID (정수)
     * @return 조회된 EventVO 객체 (해당 APP_ID의 행사가 없으면 null이 반환될 수 있습니다.)
     */
    EventVO selectEventDetail(int appId);
}
