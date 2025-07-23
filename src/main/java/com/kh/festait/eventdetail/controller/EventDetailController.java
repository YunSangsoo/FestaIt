package com.kh.festait.eventdetail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.eventdetail.model.service.EventDetailService;
import com.kh.festait.eventdetail.model.vo.EventDetailVo;

import lombok.extern.slf4j.Slf4j; // ⭐⭐ 추가: Slf4j 임포트 ⭐⭐

// 행사 상세 정보 웹 요청 처리 컨트롤러
@Controller
@RequestMapping("/eventBoard") // 기본 요청 경로: /eventBoard
@Slf4j // ⭐⭐ 추가: Slf4j 어노테이션 사용 ⭐⭐
public class EventDetailController {

    @Autowired // EventDetailService 의존성 자동 주입
    private EventDetailService eventService;

    @GetMapping("/detail") // 최종 요청 경로: /eventBoard/detail
    public String selectEventDetail(@RequestParam("appId") int appId, Model model) {
        // ⭐⭐ 변경: 로그 메시지 형식 변경 (Slf4j 플레이스홀더 사용) ⭐⭐
        log.info("행사 상세 정보 조회 요청 - appid: {}", appId);

        // 행사 상세 정보 조회 (EventDetailVo에 카테고리 정보가 포함되어 반환될 예정)
        EventDetailVo event = eventService.selectEventDetail(appId);

        // 조회 결과에 따라 뷰 반환
        if (event != null) {
            model.addAttribute("event", event); // Model에 행사 객체 추가
            // ⭐⭐ 변경: 로그 메시지 형식 변경 (Slf4j 플레이스홀더 사용) ⭐⭐
            log.info("행사 상세 정보 조회 성공: {}", event);
            return "event/eventDetail"; // 행사 상세 페이지 뷰 반환.
        } else {
            // ⭐⭐ 변경: 로그 메시지 형식 변경 (Slf4j 플레이스홀더 사용) ⭐⭐
            log.warn("행사 상세 정보 조회 실패: appId {}", appId);
            model.addAttribute("msg", "해당하는 행사를 찾을 수 없습니다."); // 오류 메시지 추가
            return "common/errorPage"; // 오류 페이지 뷰 반환.
        }
    }
}
