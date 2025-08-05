package com.kh.festait.eventdetail.model.service;

import java.util.Map;

import com.kh.festait.eventdetail.model.vo.EventDetailVo;

public interface EventDetailService {
	EventDetailVo selectEventDetail(Map<String, Object> paramMap);
    boolean isEventBookmarkedByUser(int userNo, int appId);
}