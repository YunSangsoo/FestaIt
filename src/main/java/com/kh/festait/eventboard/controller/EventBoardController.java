package com.kh.festait.eventboard.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.eventboard.model.Service.EventBoardService;
import com.kh.festait.eventboard.model.vo.EventBoard;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/eventBoard")
public class EventBoardController {
	
	@Autowired
	private EventBoardService eventBoardService;
	
	//1-1. 행사 리스트
	@GetMapping("/list")
	public String eventList(@RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {

		
		int limit = 8; // 한 페이지에 보여줄 게시글 수
	    int offset = (page - 1) * limit;

	    List<EventBoard> list = eventBoardService.selectEventList(offset, limit);
	    int totalCount = eventBoardService.getEventCount();

	    // 페이징 계산
	    int totalPage = (int) Math.ceil((double) totalCount / limit);
	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > totalPage) endPage = totalPage;

	    model.addAttribute("eventList", list);
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("limit", limit);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    
	    System.out.println("현재 유효한 행사 수: "+list.size());
	    
	    return "event/eventBoardList";
	}
	
	//1-2. 행사 캘린더
	@GetMapping("/calendar")
	public String eventCalendar(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		
//		int limit = 10; // 한 페이지에 보여줄 게시글 수
//	    int offset = (page - 1) * limit;
//
//	    List<NoticeBoard> list = noticeBoardService.selectNoticeList(offset, limit);
//	    int totalCount = noticeBoardService.getNoticeCount();
//
//	    // 페이징 계산
//	    int totalPage = (int) Math.ceil((double) totalCount / limit);
//	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
//	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
//	    int endPage = startPage + pageBlock - 1;
//	    if (endPage > totalPage) endPage = totalPage;
//
//	    model.addAttribute("noticeList", list);
//	    model.addAttribute("totalCount", totalCount);
//	    model.addAttribute("currentPage", page);
//	    model.addAttribute("limit", limit);
//	    model.addAttribute("totalPage", totalPage);
//	    model.addAttribute("startPage", startPage);
//	    model.addAttribute("endPage", endPage);
		
		return "event/eventBoardCalendar";
	}
	
	//2. 공지사항 상세 보기
    @GetMapping("/detail")
    public String noticeDetail(@RequestParam("eventId") int eventId, Model model) {
//    	EventBoard event = eventBoardService.selectEventById(eventId);
//        model.addAttribute("event", event);
        return "eventBoard/eventDetail"; // 김현주 작성 jsp 경로 확인
    }
	
	
}

