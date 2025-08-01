package com.kh.festait.mainpage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;

@Mapper
public interface MainpageDao {

	List<NoticeBoard> selectNoticeList(int limit);

	List<EventBoard> selectEventList(int limit);

	List<EventBoard> selectTodayEventList(int limit);

	List<ReviewBoard> selectReviewList(int limit);

	List<PromoBoardVo> selectPromoList(int limit);


}
