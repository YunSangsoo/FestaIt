package com.kh.festait.eventdetail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.eventdetail.model.service.EventDetailService;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

// 행사 상세 정보 웹 요청 처리 컨트롤러
@Controller
@RequestMapping("/eventBoard") // 기본 요청 경로: /eventBoard
public class EventDetailController {

    @Autowired // EventDetailService 의존성 자동 주입
    private EventDetailService eventService;

    @GetMapping("/detail") // 최종 요청 경로: /eventBoard/detail
    public String selectEventDetail(@RequestParam("eventId") int eventId, Model model) {
        // 행사 상세 정보 조회
        EventDetailVo event = eventService.selectEventDetail(eventId);

        // 조회 결과에 따라 뷰 반환
        if (event != null) {
            model.addAttribute("event", event); // Model에 행사 객체 추가
            return "event/eventDetail"; // 행사 상세 페이지 뷰 반환.
        } else {
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다."); // 오류 메시지 추가
            return "common/errorPage"; // 오류 페이지 뷰 반환.
        }
    }
}
