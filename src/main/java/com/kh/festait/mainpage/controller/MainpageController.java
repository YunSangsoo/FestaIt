package com.kh.festait.mainpage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import com.kh.festait.bookmark.controller.BookmarkController;
import com.kh.festait.common.service.ImageService;
import com.kh.festait.eventboard.controller.EventBoardController;
import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.mainpage.model.service.MainpageService;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;
import com.kh.festait.reviewboard.controller.ReviewBoardController;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
import com.kh.festait.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainpageController {
	
	@Autowired
	private MainpageService mainpageService;
	@Autowired
	private BookmarkController bCon;
	@Autowired
	private ReviewBoardController rbCon;
	@Autowired
	private final ImageService imgService;
	
	// 0. 메인 페이지
	public void mainpageLoading(Model model, Authentication authentication) {
		bannerMain(model);
		eventMain(model, authentication);
		todayEventMain(model);
		reviewMain(model);
		noticeMain(model);
	}
	
	// 1. 배너 슬라이더
	private void bannerMain(Model model) {
		int limit = 3; // 출력할 최대 게시물 수
	    List<PromoBoardVo> promoList = mainpageService.selectPromoList(limit);
	    model.addAttribute("promoList", promoList);
		
	}
	
	// 2. 진행 중인 행사
	private void eventMain(Model model, Authentication authentication) {
		
		int limit = 6;
	    List<EventBoard> eventList = mainpageService.selectEventList(limit);
	    
	    Integer userNo = 0;
		
    	if (authentication != null && authentication.isAuthenticated()) {
        	User loginUser = (User) authentication.getPrincipal();
            userNo = loginUser.getUserNo();
        }
    	bCon.setBookmark(eventList, userNo);
	    
	    EventBoardController.setRegion(eventList);
	    model.addAttribute("eventList", eventList);
	    
	}
	
	// 3. 오늘의 행사
	private void todayEventMain(Model model) {
		
		int limit = 7;
	    List<EventBoard> todayEventList = mainpageService.selectTodayEventList(limit);
	    model.addAttribute("todayEventList", todayEventList);
		
	}
	
	// 4. 실시간 리뷰
	private void reviewMain(Model model) {
		
		int limit = 9;
	    List<ReviewBoard> reviewList = mainpageService.selectReviewList(limit);
	    rbCon.setProfileImage(reviewList);
	    model.addAttribute("reviewList", reviewList);
		
	}
	
	// 5. 공지사항
	private void noticeMain(Model model) {
		
		int limit = 5;
	    List<NoticeBoard> noticeList = mainpageService.selectNoticeList(limit);
	    model.addAttribute("noticeList", noticeList);
		
	}
	
	
	
	
	
	
	
}
