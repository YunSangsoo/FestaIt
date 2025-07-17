package com.kh.festait.event.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.event.model.service.EventService;
import com.kh.festait.event.model.vo.EventVO;

@Controller
@RequestMapping("/event")
public class EventController {

    @Autowired
    private EventService eventService;

    /*
     * @param appId 조회할 행사의 APP_ID (요청 파라미터로 받음)
     * @param model 데이터를 뷰로 전달하기 위한 Spring Model 객체
     * @return 행사 상세 페이지의 뷰 이름 (JSP 경로)
     */
    
    @GetMapping("/detail")
    public String selectEventDetail(@RequestParam("appId") int appId, Model model) {
       
    	// 1. 서비스 호출하여 행사 상세 정보 가져오기
        EventVO event = eventService.selectEventDetail(appId);

        // 2. 조회된 EventVO 객체를 Model에 담아 뷰로 전달
        if (event != null) {
            model.addAttribute("event", event);

            return "event/eventDetail"; 
        } else {
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }

}