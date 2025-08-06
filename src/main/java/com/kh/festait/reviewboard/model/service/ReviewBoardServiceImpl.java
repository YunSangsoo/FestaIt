package com.kh.festait.reviewboard.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.festait.reviewboard.model.dao.ReviewBoardDao;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewBoardServiceImpl implements ReviewBoardService {
	
	@Autowired
	private final ReviewBoardDao reviewBoardDao;

	@Override
	public List<ReviewBoard> selectReviewList(Map<String, Object> paramMap) {
	    return reviewBoardDao.selectReviewListWithPaging(paramMap);
	}

	@Override
	public int getReviewCount(Map<String, Object> paramMap) {
		return reviewBoardDao.getReviewCount(paramMap);
	}
	
	@Override
	public int setReviewIdentifier(Map<String, Object> paramMap) {
		return reviewBoardDao.setReviewIdentifier(paramMap);
	}

	@Override
	public int insertReview(ReviewBoard review) {
		return reviewBoardDao.insertReview(review);
	}

	@Override
	public int updateReviewByUserNo(ReviewBoard review) {
		return reviewBoardDao.updateByUserNo(review);
	}

	@Override
	public int deleteReviewByUserNo(Map<String, Object> paramMap) {
		return reviewBoardDao.deleteByUserNo(paramMap);
	}

}
