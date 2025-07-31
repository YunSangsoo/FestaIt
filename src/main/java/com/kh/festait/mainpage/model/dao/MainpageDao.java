package com.kh.festait.mainpage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

@Mapper
public interface MainpageDao {

	List<NoticeBoard> selectNoticeList(int limit);

	List<EventBoard> selectEventList(int limit);

	List<EventBoard> selectTodayEventList(int limit);


}
