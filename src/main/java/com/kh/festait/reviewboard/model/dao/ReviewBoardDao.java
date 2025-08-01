package com.kh.festait.reviewboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.reviewboard.model.vo.ReviewBoard;

@Mapper
public interface ReviewBoardDao {

	List<ReviewBoard> selectReviewListWithPaging(Map<String, Object> paramMap);

	int getReviewCount();
	
	int setReviewIdentifier(Map<String, Object> paramMap);

	int insertReview(ReviewBoard review);

	int updateByUserNo(ReviewBoard review);

	int deleteByUserNo(Map<String, Object> paramMap);

}
