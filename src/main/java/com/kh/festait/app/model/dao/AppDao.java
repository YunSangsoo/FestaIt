package com.kh.festait.app.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.Image;

public interface AppDao {

	int insertApplication(EventApplication eventApplication);

	int insertAppManager(EventApplication eventApplication);

	EventApplication getEvAppById(int appId);

	int updateApplication(EventApplication eventApplication);

	int updateAppManager(EventApplication eventApplication);

	int insertBoardImgList(List<Image> imgList);

	List<EventApplication> selectAppList(Map<String, Object> paramMap);

	int selectAppListCount();

}
