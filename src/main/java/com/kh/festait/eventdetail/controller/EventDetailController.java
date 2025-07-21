package com.kh.festait.eventdetail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.eventdetail.model.service.EventDetailService;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

@Controller
@RequestMapping("/eventBoard") // ⭐️ /event -> /eventBoard로 변경
public class EventDetailController {

    @Autowired
    private EventDetailService eventService;

    /**
     * 행사 상세 조회
     * @param eventId 조회할 행사 ID (EVENT 테이블의 EVENT_ID)
     * @param model 뷰에 데이터 전달용 Model
     * @return 행사 상세 페이지 뷰 또는 에러 페이지
     */
    @GetMapping("/detail")
    public String selectEventDetail(@RequestParam("eventId") int eventId, Model model) { // ⭐️ appId -> eventId로 변경
        
        // 행사 상세 정보 조회 (EVENT_ID를 기준으로 조회)
        EventDetailVo event = eventService.selectEventDetail(eventId); // ⭐️ appId -> eventId로 변경

        // 조회 결과 처리
        if (event != null) {
            model.addAttribute("event", event);
            return "event/eventDetail"; // JSP 경로 유지됨
        } else {
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }
}
