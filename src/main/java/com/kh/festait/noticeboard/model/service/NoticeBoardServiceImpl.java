package com.kh.festait.noticeboard.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.noticeboard.model.dao.NoticeBoardDao;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeBoardServiceImpl implements NoticeBoardService{
	
	@Autowired
    private NoticeBoardDao noticeBoardDao;

    @Override
    public List<NoticeBoard> selectNoticeList() {
        return noticeBoardDao.selectNoticeList();
    }

	@Override
	public int insertNotice(NoticeBoard notice) {
		return noticeBoardDao.insertNotice(notice);
	}

	@Override
	public NoticeBoard selectNoticeById(int noticeId) {
		return noticeBoardDao.selectNoticeById(noticeId);
	}

	@Override
	public int updateNotice(NoticeBoard notice) {
		 return noticeBoardDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int noticeId) {
		return noticeBoardDao.deleteNotice(noticeId);
	}

	@Override
	public List<NoticeBoard> selectNoticeList(int offset, int limit) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("startRow", offset);
	    paramMap.put("endRow", offset + limit);

	    return noticeBoardDao.selectNoticeListWithPaging(paramMap);
	}

	@Override
	public int getNoticeCount() {
		return noticeBoardDao.getNoticeCount();
	}


}
