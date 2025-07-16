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
	// 김현주 : 행사세부페이지 요청 처리
	
    @Autowired
    private EventService eventService;

    @GetMapping("/detail")
    public String eventDetail(@RequestParam("no") int no, Model model) {
        EventVO event = eventService.getEventById(no);
        model.addAttribute("event", event);
        return "event/eventDetail"; // JSP 경로	
 }
}