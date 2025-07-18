package com.kh.festait.noticeboard.model.service;

import java.util.List;

import com.kh.festait.noticeboard.model.vo.NoticeBoard;

public interface NoticeBoardService {
	
	int insertNotice(NoticeBoard notice);
	
    int updateNotice(NoticeBoard notice);
    
    int deleteNotice(int noticeId);
    
    NoticeBoard selectNoticeById(int noticeId);
    
    List<NoticeBoard> selectNoticeList();

	List<NoticeBoard> selectNoticeList(int offset, int limit);

	int getNoticeCount();


}
