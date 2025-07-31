package com.kh.festait.mainpage.model.service;

import java.util.List;

import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

public interface MainpageService {

	List<NoticeBoard> selectNoticeList(int limit);

	List<EventBoard> selectEventList(int limit);

	List<EventBoard> selectTodayEventList(int limit);

}
