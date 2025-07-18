package com.kh.festait.noticeboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

@Mapper
public interface NoticeBoardDao {
	
	int insertNotice(NoticeBoard notice);
	
    int updateNotice(NoticeBoard notice);
    
    int deleteNotice(int noticeId);
    
    NoticeBoard selectNoticeById(int noticeId);
    
    List<NoticeBoard> selectNoticeList();

    List<NoticeBoard> selectNoticeListWithPaging(Map<String, Object> paramMap);
    
	int getNoticeCount();

	

}
