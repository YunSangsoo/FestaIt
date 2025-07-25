package com.kh.festait.eventboard.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.Pagination;
import com.kh.festait.common.model.vo.PageInfo;
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
	public String eventList(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam Map<String, Object> paramMap, Model model) {
		EventBoard eventBoard = new EventBoard();

		String eventCode = (String) paramMap.get("eventCode"); // 넘어온 파라미터
		List<String> eventCodeList = new ArrayList<String>();
		if(eventCode != null && !eventCode.isEmpty()) {
			eventCodeList = Arrays.asList(eventCode.split(","));			
		}
		
		paramMap.put("eventCodeList", eventCodeList);	
		
		int limit = 8; // 한 페이지에 보여줄 게시글 수
		int offset = (currentPage - 1) * limit; // 시작행 번호
		int totalEventCount = eventBoardService.selectEventCount(paramMap);
		int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
		
		PageInfo pi = Pagination.getPageInfo(totalEventCount, currentPage, pageBlock, limit);
		
		// mapper용 행 계산 parameter
		paramMap.put("startRow", offset);
		paramMap.put("endRow", offset + limit);
		
	    List<EventBoard> list = eventBoardService.selectEventList(pi, paramMap);
	    
	    model.addAttribute("eventCodeList", eventCodeList);		
	    model.addAttribute("eventSearch", eventBoard);
	    model.addAttribute("eventList", list);
	    model.addAttribute("pi", pi);
		model.addAttribute("param", paramMap);
	    
	    System.out.println("현재 유효한 행사 수: "+list.size());
	    
	    return "event/eventBoardList";
	}
	
	//1-2. 행사 캘린더
	@GetMapping("/calendar")
	public String eventCalendar(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam Map<String, Object> paramMap, Model model) {
		
		EventBoard eventBoard = new EventBoard();

		String eventCode = (String) paramMap.get("eventCode"); // 넘어온 파라미터
		List<String> eventCodeList = new ArrayList<String>();
		if(eventCode != null && !eventCode.isEmpty()) {
			eventCodeList = Arrays.asList(eventCode.split(","));			
		}
		
		paramMap.put("eventCodeList", eventCodeList);	
		
		int limit = 8; // 한 페이지에 보여줄 게시글 수
		int offset = (currentPage - 1) * limit; // 시작행 번호
		int totalEventCount = eventBoardService.selectEventCount(paramMap);
		int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
		
		PageInfo pi = Pagination.getPageInfo(totalEventCount, currentPage, pageBlock, limit);
		
		// mapper용 행 계산 parameter
		paramMap.put("startRow", offset);
		paramMap.put("endRow", offset + limit);
		
	    List<EventBoard> list = eventBoardService.selectEventList(pi, paramMap);
	    
	    model.addAttribute("eventCodeList", eventCodeList);		
	    model.addAttribute("eventSearch", eventBoard);
	    model.addAttribute("eventList", list);
	    model.addAttribute("pi", pi);
		model.addAttribute("param", paramMap);
	    
	    System.out.println("현재 유효한 행사 수: "+list.size());
		
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

