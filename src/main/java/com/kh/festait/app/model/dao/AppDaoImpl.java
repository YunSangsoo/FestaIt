package com.kh.festait.app.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

	@Override
	public List<EventApplication> selectAppList(Map<String, Object> paramMap) {
		return session.selectList("app.selectAppList",paramMap);
	}

	@Override
	public int selectAppListCount() {
		return session.selectOne("app.selectAppListCount");
	}

	@Override
	public int approvingApp(String appId) {
		// TODO Auto-generated method stub
		return session.update("app.approvingApp",appId);
	}

	@Override
	public int rejectingApp(Map<String, String> setMap) {
		return session.update("app.rejectingApp",setMap);
	}

}
