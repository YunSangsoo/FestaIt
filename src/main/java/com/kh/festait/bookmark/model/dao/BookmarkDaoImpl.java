package com.kh.festait.bookmark.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.bookmark.model.vo.Bookmark;

@Repository
public class BookmarkDaoImpl implements BookmarkDao {
	@Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public void insertBookmark(int userNo, int appId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userNo", userNo);
        map.put("appId", appId);
        sqlSession.insert("bookmarkMapper.insertBookmark", map);
    }

    @Override
    public void deleteBookmark(int userNo, int appId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userNo", userNo);
        map.put("appId", appId);
        sqlSession.delete("bookmarkMapper.deleteBookmark", map);
    }

	@Override
	public List<Bookmark> getBookmarkList(Integer userNo) {
		Map<String, Object> map = new HashMap<>();
        map.put("userNo", userNo);
		return sqlSession.selectList("bookmarkMapper.selectBookmarkedAppIdsByUser", map);
	}
}
