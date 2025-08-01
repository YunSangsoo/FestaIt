package com.kh.festait.mainpage.model.service;

import java.util.List;

import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;

public interface MainpageService {

	List<NoticeBoard> selectNoticeList(int limit);

	List<EventBoard> selectEventList(int limit);

	List<EventBoard> selectTodayEventList(int limit);

	List<ReviewBoard> selectReviewList(int limit);

	List<PromoBoardVo> selectPromoList(int limit);

}
