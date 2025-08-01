package com.kh.festait.eventdetail.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.eventdetail.model.dao.EventDetailDao;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

import com.kh.festait.bookmark.model.dao.BookmarkDao; // BookmarkDao 임포트
import com.kh.festait.bookmark.model.vo.Bookmark; // Bookmark VO 임포트

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class EventDetailServiceImpl implements EventDetailService {

    @Autowired
    private EventDetailDao eventDetailDao;

    @Autowired
    private BookmarkDao bookmarkDao;
    @Override
    public EventDetailVo selectEventDetail(Map<String, Object> paramMap) {
        return eventDetailDao.selectEventDetail(paramMap);
    }

    @Override
    public boolean isEventBookmarkedByUser(int userNo, int appId) {
        if (userNo == 0) {
            return false;
        }

        List<Bookmark> bookmarkList = bookmarkDao.getBookmarkList(userNo);
        
        if (bookmarkList != null) {
            for (Bookmark bookmark : bookmarkList) {
                if (bookmark.getAppId() == appId) {
                    return true; 
                }
            }
        }
        return false; 
    }
}