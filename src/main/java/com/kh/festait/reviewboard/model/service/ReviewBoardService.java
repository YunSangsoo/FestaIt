package com.kh.festait.reviewboard.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.festait.noticeboard.model.vo.NoticeBoard;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;

public interface ReviewBoardService {

	List<ReviewBoard> selectReviewList(Map<String, Object> paramMap);

	int getReviewCount(Map<String, Object> paramMap);
	
	int setReviewIdentifier(Map<String, Object> paramMap);

	int insertReview(ReviewBoard review);

	int updateReviewByUserNo(ReviewBoard review);

	int deleteReviewByUserNo(Map<String, Object> paramMap);

}
