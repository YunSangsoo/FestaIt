package com.kh.festait.event.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.event.model.service.EventService;
import com.kh.festait.event.model.vo.EventVO;

@Controller // 이 클래스가 Spring의 컨트롤러 컴포넌트임을 나타냅니다.
@RequestMapping("/event")
public class EventController {

    @Autowired // Spring이 EventService 타입의 빈(Bean)을 자동으로 주입해줍니다.
    private EventService eventService;

    /**
     * 행사 상세 페이지를 보여주는 메서드입니다.
     * 예시 URL: /event/detail?appId=123
     * @param appId 조회할 행사의 APP_ID (요청 파라미터로 받음)
     * @param model 데이터를 뷰로 전달하기 위한 Spring Model 객체
     * @return 행사 상세 페이지의 뷰 이름 (JSP 경로)
     */
    @GetMapping("/detail") // "/event/detail" 경로로 GET 요청이 들어오면 이 메서드가 처리합니다.
    public String selectEventDetail(@RequestParam("appId") int appId, Model model) {
        // 1. 서비스 계층을 호출하여 행사 상세 정보를 가져옵니다.
        EventVO event = eventService.selectEventDetail(appId);

        // 2. 조회된 EventVO 객체를 Model에 담아 뷰로 전달합니다.
        //    뷰(JSP)에서는 "event"라는 이름으로 이 객체에 접근할 수 있습니다.
        if (event != null) {
            model.addAttribute("event", event);
            // 이 부분을 "event/eventDetail"로 수정합니다!
            return "event/eventDetail"; 
        } else {
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }

    // 향후 필요에 따라 다른 웹 요청 처리 메서드들을 여기에 추가할 수 있습니다.
    // 예:
    // @GetMapping("/event/list") // 행사 목록 페이지
    // public String selectEventList(Model model) { ... }
    //
    // @PostMapping("/event/register") // 행사 등록 처리
    // public String insertEvent(@ModelAttribute EventVO event) { ... }
}