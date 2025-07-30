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
	public List<ReviewBoard> selectReviewList(int offset, int limit) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("startRow", offset);
	    paramMap.put("endRow", offset + limit);

	    return reviewBoardDao.selectReviewListWithPaging(paramMap);
	}

	@Override
	public int getReviewCount() {
		return reviewBoardDao.getReviewCount();
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
	public int deleteReviewByUserNo(int userNo) {
		return reviewBoardDao.deleteByUserNo(userNo);
	}

}
