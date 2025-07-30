package com.kh.festait.bookmark.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.bookmark.model.dao.BookmarkDao;

@Service
public class BookmarkServiceImpl implements BookmarkService {
	 	@Autowired
	    private BookmarkDao bookmarkDao;

	    @Override
	    public void addBookmark(int userNo, int appId) {
	        bookmarkDao.insertBookmark(userNo, appId);
	    }

	    @Override
	    public void removeBookmark(int userNo, int appId) {
	        bookmarkDao.deleteBookmark(userNo, appId);
	    }
}
