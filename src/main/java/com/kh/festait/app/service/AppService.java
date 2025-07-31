package com.kh.festait.app.service;

import java.util.List;
import java.util.Map;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.PageInfo;

public interface AppService {

	EventApplication getEvAppById(int appId);

	int saveOrUpdateApplication(EventApplication eventApplication);
	
	List<EventApplication> selectAppList(PageInfo pi,int userNo);

	int selectAppListCount(int userNo);

	int approvingApp(String appId);

	int rejectingApp(Map<String, String> setMap);

	List<EventApplication> selectAppAllList(PageInfo pi,String searchType, String keyword);

	int selectAppAllListCount(String searchType, String keyword);

	int deleteApplication(EventApplication eventApplication);
}
