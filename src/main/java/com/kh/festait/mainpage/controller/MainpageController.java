package com.kh.festait.mainpage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import com.kh.festait.eventboard.controller.EventBoardController;
import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.mainpage.model.service.MainpageService;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainpageController {
	
	@Autowired
	private MainpageService mainpageService;
	
	// 0. 메인 페이지
	public void mainpageLoading(Model model) {
		bannerMain(model);
		eventMain(model);
		todayEventMain(model);
		reviewMain(model);
		noticeMain(model);
	}
	
	// 1. 배너 슬라이더
	private void bannerMain(Model model) {
		// 홍보 게시물과 연결, 어떤 게시물을 띄울 것인지는 상의 필요
//		model.addAttribute("bannerList", bannerService.getBannerList());
		
	}
	
	// 2. 진행 중인 행사
	private void eventMain(Model model) {
		
		int limit = 6; // 한 페이지에 보여줄 게시글 수
	    List<EventBoard> eventList = mainpageService.selectEventList(limit);
	    EventBoardController.setRegion(eventList);
	    model.addAttribute("eventList", eventList);
	    
	}
	
	// 3. 오늘의 행사
	private void todayEventMain(Model model) {
		
		int limit = 7; // 한 페이지에 보여줄 게시글 수
	    List<EventBoard> todayEventList = mainpageService.selectTodayEventList(limit);
	    model.addAttribute("todayEventList", todayEventList);
		
	}
	
	// 4. 실시간 리뷰
	private void reviewMain(Model model) {
		
		
	}
	
	// 5. 공지사항
	private void noticeMain(Model model) {
		
		int limit = 5; // 한 페이지에 보여줄 게시글 수
	    List<NoticeBoard> noticeList = mainpageService.selectNoticeList(limit);
	    model.addAttribute("noticeList", noticeList);
		
	}
	
	
	
	
	
	
	
}
