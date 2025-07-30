package com.kh.festait.bookmark.service;

public interface BookmarkService {

	void addBookmark(int userNo, int appId);
    void removeBookmark(int userNo, int appId);

}
