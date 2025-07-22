package com.kh.festait.app.model.dao;

import java.util.List;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.Image;

public interface AppDao {

	int insertApplication(EventApplication eventApplication);

	int insertAppManager(EventApplication eventApplication);

	EventApplication getEvAppById(int appId);

	int updateApplication(EventApplication eventApplication);

	int updateAppManager(EventApplication eventApplication);

	int insertBoardImgList(List<Image> imgList);

}
