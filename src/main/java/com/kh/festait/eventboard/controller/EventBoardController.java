package com.kh.festait.eventboard.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.bookmark.controller.BookmarkController;
import com.kh.festait.common.Pagination;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.service.ImageService;
import com.kh.festait.eventboard.model.Service.EventBoardService;
import com.kh.festait.eventboard.model.vo.EventBoard;
import com.kh.festait.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/eventBoard")
public class EventBoardController {
	
	@Autowired
	private EventBoardService eventBoardService;
	@Autowired
	private final ImageService imgService;
	@Autowired
	private BookmarkController bc;
	private String boardCode = "A";
	
	//1-1. 행사 리스트
	@GetMapping("/list")
	public String eventList(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam Map<String, Object> paramMap, Model model, Authentication authentication) {
		EventBoard eventBoard = new EventBoard();
		
		Integer userNo = 0;
		
    	if (authentication != null && authentication.isAuthenticated()) {
        	User loginUser = (User) authentication.getPrincipal();
            userNo = loginUser.getUserNo();
        }
		
		String eventCode = (String) paramMap.get("eventCode"); // 넘어온 파라미터
		List<String> eventCodeList = new ArrayList<String>();
		
		if(eventCode != null && !eventCode.isEmpty()) {
			eventCodeList = Arrays.asList(eventCode.split(","));			
		}
		int limit = 8; // 한 페이지에 보여줄 게시글 수
		int offset = (currentPage - 1) * limit; // 시작행 번호
		
		// 검색용 행사 코드 리스트 작성, 다중 선택을 가능케 함
		paramMap.put("eventCodeList", eventCodeList);
		// mapper용 행 계산 parameter
		paramMap.put("startRow", offset);
		paramMap.put("endRow", offset + limit);
		// 리스트/캘린더형에 따라 행사 리스트 출력 기본값(날짜)을 지정하기 위한 구분자, L/C
		paramMap.put("boardCode", "L");
		paramMap.put("userNo", userNo);
		
		int totalEventCount = eventBoardService.selectEventCount(paramMap);
		int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
		
		PageInfo pi = Pagination.getPageInfo(totalEventCount, currentPage, pageBlock, limit);
		
	    List<EventBoard> eventList = eventBoardService.selectEventList(pi, paramMap);
	    setPosterImage(eventList);
	    
	    if (eventList != null) {
	    	setRegion(eventList);
	    	bc.setBookmark(eventList, userNo);
        }
	    
	    model.addAttribute("eventCodeList", eventCodeList);		
	    model.addAttribute("eventSearch", eventBoard);
	    model.addAttribute("eventList", eventList);
	    model.addAttribute("pi", pi);
		model.addAttribute("param", paramMap);
	    
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
		int limit = 5000; // 한 페이지에 보여줄 게시글 수
		int offset = (currentPage - 1) * limit; // 시작행 번호
		
		// 검색용 행사 코드 리스트 작성, 다중 선택을 가능케 함
		paramMap.put("eventCodeList", eventCodeList);
		// mapper용 행 계산 parameter
		paramMap.put("startRow", offset);
		paramMap.put("endRow", offset + limit);
		// 리스트/캘린더형에 따라 행사 리스트 출력 기본값(날짜)을 지정하기 위한 구분자, L/C
		paramMap.put("boardCode", "C");
		
		int totalEventCount = eventBoardService.selectEventCount(paramMap);
		int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
		
		PageInfo pi = Pagination.getPageInfo(totalEventCount, currentPage, pageBlock, limit);
		
	    List<EventBoard> eventList = eventBoardService.selectEventList(pi, paramMap);
	    setPosterImage(eventList);
	    
	    if (eventList != null) {
	    	setRegion(eventList);
        }
	    
	    model.addAttribute("eventCodeList", eventCodeList);		
	    model.addAttribute("eventSearch", eventBoard);
	    model.addAttribute("eventList", eventList);
	    model.addAttribute("pi", pi);
		model.addAttribute("param", paramMap);
		
		return "event/eventBoardCalendar";
	}
	
    public static List<EventBoard> setRegion(List<EventBoard> list){
    	
    	for (EventBoard event : list) {
    		
    		String region = event.getRegion();
    		String newRegion = "";
    		
    	    if (region == null) {
    	        newRegion = "기타";
    	    } else {
    	        switch(region) {
    	            case "서울": newRegion = "서울시"; break;
    	            case "인천": newRegion = "인천시"; break;
    	            case "경기": newRegion = "경기도"; break;
    	            case "강원": newRegion = "강원도"; break;
    	            case "충북": case "충남": newRegion = "충청도"; break;
    	            case "경북": case "경남": newRegion = "경상도"; break;
    	            case "전북": case "전남": newRegion = "전라도"; break;
    	            case "제주": newRegion = "제주도"; break;
    	            default: newRegion = "기타";
    	        }
    	    }
    	    
    		event.setRegion(newRegion);
		}
    	return list;
    }
    
    public void setPosterImage(List<EventBoard> list) {
		if (list != null) {
			for(EventBoard event : list) {
				Image eventImage = imgService.getImageByRefNoAndType(event.getAppId(), boardCode);
				if(eventImage != null) event.setPosterImage(eventImage);
			}
		}
	}
}

