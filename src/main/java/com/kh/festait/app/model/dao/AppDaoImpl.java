package com.kh.festait.app.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.common.model.vo.Image;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class AppDaoImpl implements AppDao {
	
	@Autowired
	private final SqlSessionTemplate session;
	
	@Override
	public int insertApplication(EventApplication evApp) {
		return session.insert("app.insertApplication",evApp);
	}

	@Override
	public int insertAppManager(EventApplication evApp) {
		return session.insert("app.insertAppManager",evApp);
	}

	@Override
	public EventApplication getEvAppById(int appId) {
		return session.selectOne("app.getEvAppById",appId);
	}

	@Override
	public int updateApplication(EventApplication evApp) {
		return session.update("app.updateApplication",evApp);
	}

	@Override
	public int updateAppManager(EventApplication evApp) {
		return session.update("app.updateAppManager",evApp);
	}

	@Override
	public int insertBoardImgList(List<Image> imgList) {
		return session.insert("app.insertBoardImg",imgList);
	}

}
