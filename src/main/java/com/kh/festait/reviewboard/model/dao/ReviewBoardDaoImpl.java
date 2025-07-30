package com.kh.festait.reviewboard.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.festait.reviewboard.model.vo.ReviewBoard;

@Repository
public class ReviewBoardDaoImpl implements ReviewBoardDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ReviewBoard> selectReviewListWithPaging(Map<String, Object> paramMap) {
		return sqlSession.selectList("reviewMapper.selectReviewListWithPaging", paramMap);
	}

	@Override
	public int getReviewCount() {
		return sqlSession.selectOne("reviewMapper.getReviewCount");
	}

	@Override
	public int insertReview(ReviewBoard review) {
		return sqlSession.insert("reviewMapper.insertReview", review);
	}

	@Override
	public int updateByUserNo(ReviewBoard review) {
		return sqlSession.update("reviewMapper.updateByUserNo", review);
	}

	@Override
	public int deleteByUserNo(int userNo) {
		return sqlSession.delete("reviewMapper.deleteByUserNo", userNo);
	}

}
