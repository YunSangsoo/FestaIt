package com.kh.festait.mainpage.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.mainpage.model.dao.MainpageDao;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainpageServiceImpl implements MainpageService{
	
	@Autowired
    private MainpageDao mainpageDao;
	
	@Override
	public List<NoticeBoard> selectNoticeList(int limit) {
		return mainpageDao.selectNoticeList(limit);
	}

	@Override
	public List<EventBoard> selectEventList(int limit) {
		return mainpageDao.selectEventList(limit);
	}

	@Override
	public List<EventBoard> selectTodayEventList(int limit) {
		return mainpageDao.selectTodayEventList(limit);
	}

}
