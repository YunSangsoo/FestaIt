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
     * 행사 상세 조회
     * @param appId 조회할 행사 ID
     * @param model 뷰에 데이터 전달용 Model
     * @return 행사 상세 페이지 뷰 또는 에러 페이지
     */
    @GetMapping("/detail")
    public String selectEventDetail(@RequestParam("appId") int appId, Model model) {
       
        // 행사 상세 정보 조회
        EventVO event = eventService.selectEventDetail(appId);

        // 조회 결과 처리
        if (event != null) {
            model.addAttribute("event", event);
            return "event/eventDetail";
        } else {
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }
}
