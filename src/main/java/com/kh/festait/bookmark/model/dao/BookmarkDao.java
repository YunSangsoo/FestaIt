package com.kh.festait.bookmark.model.dao;

public interface BookmarkDao {

	void insertBookmark(int userNo, int appId);
    void deleteBookmark(int userNo, int appId);

}
