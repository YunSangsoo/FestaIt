package com.kh.festait.bookmark.service;

import java.util.List;

import com.kh.festait.bookmark.model.vo.Bookmark;

public interface BookmarkService {

	void addBookmark(int userNo, int appId);
    void removeBookmark(int userNo, int appId);
	List<Bookmark> getBookmarkList(Integer userNo);

}
