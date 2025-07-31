package com.kh.festait.bookmark.model.dao;

import java.util.List;

import com.kh.festait.bookmark.model.vo.Bookmark;
import com.kh.festait.eventboard.model.vo.EventBoard;

public interface BookmarkDao {

	void insertBookmark(int userNo, int appId);
    void deleteBookmark(int userNo, int appId);
	List<Bookmark> getBookmarkList(Integer userNo);

}
