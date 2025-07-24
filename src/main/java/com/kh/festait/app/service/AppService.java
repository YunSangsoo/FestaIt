package com.kh.festait.app.service;

import java.util.List;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.PageInfo;

public interface AppService {

	EventApplication getEvAppById(int appId);

	int saveOrUpdateApplication(EventApplication eventApplication);
	
	List<EventApplication> selectAppList(PageInfo pi);

	int selectAppListCount();
}
