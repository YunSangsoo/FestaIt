package com.kh.festait.noticeboard.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.noticeboard.model.vo.NoticeBoard;

@Repository
public class NoticeBoardDaoImpl implements NoticeBoardDao{

	@Autowired
	private SqlSessionTemplate sqlSession;


    @Override
    public List<NoticeBoard> selectNoticeList() {
        return sqlSession.selectList("noticeMapper.selectNoticeList");
    }

	@Override
	public int insertNotice(NoticeBoard notice) {
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}

	@Override
	public NoticeBoard selectNoticeById(int noticeId) {
		return sqlSession.selectOne("noticeMapper.selectNoticeById", noticeId);
	}

	@Override
	public int updateNotice(NoticeBoard notice) {
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}

	@Override
	public int deleteNotice(int noticeId) {
		return sqlSession.delete("noticeMapper.deleteNotice", noticeId);
	}

	@Override
	public List<NoticeBoard> selectNoticeListWithPaging(Map<String, Object> paramMap) {
		return sqlSession.selectList("noticeMapper.selectNoticeListWithPaging", paramMap);
	}
	
	@Override
	public int getNoticeCount() {
		return sqlSession.selectOne("noticeMapper.getNoticeCount");
	}



}
