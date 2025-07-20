package com.kh.festait.promodetail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.festait.promodetail.model.service.PromoDetailService;
import com.kh.festait.promodetail.model.vo.PromoDetailVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor // final 필드 (PromoDetailService)를 위한 생성자 자동 주입
@RequestMapping("/promotion") // 홍보 관련 URL의 공통 접두사
@Slf4j // 로깅을 위한 Lombok 어노테이션
public class PromoDetailController {

    private final PromoDetailService promoDetailService; // 서비스 계층 의존성 주입

    /**
     * 홍보 게시글 상세 페이지를 조회하고 표시합니다.
     * 게시글 조회수 증가 로직도 포함됩니다.
     * @param promoNo 조회할 홍보 게시글 번호
     * @param model 뷰로 데이터를 전달하기 위한 Model 객체
     * @return JSP 뷰 경로
     */
    @GetMapping("/detail/{promoNo}") // /promotion/detail/{promoNo} 요청 처리
    public String selectPromoDetail(
            @PathVariable("promoNo") int promoNo, // URL 경로의 promoNo 값을 파라미터로 받음
            Model model) {

        log.info("홍보 상세 페이지 요청 - 게시글 번호: {}", promoNo); // 요청 로그

        // 1. 서비스 계층을 통해 홍보 게시글 상세 정보 조회 (조회수 증가 포함)
        PromoDetailVo promo = promoDetailService.selectPromoDetail(promoNo);

        if (promo != null) {
            // 조회 성공 시, 데이터를 Model에 담아 JSP로 전달
            model.addAttribute("promo", promo);
            log.info("홍보 상세 조회 성공: {}", promo);
            return "promotion/promoDetail"; // src/main/webapp/WEB-INF/views/promotion/promoDetail.jsp
        } else {
            // 게시글을 찾지 못한 경우
            log.warn("홍보 게시물을 찾기 실패: 게시글 번호 {}", promoNo);
            model.addAttribute("msg", "해당 홍보 게시물을 찾을 수 없습니다.");
            // 에러 페이지 또는 목록 페이지로 리다이렉트 등 적절한 처리
            return "common/errorPage"; // 또는 "redirect:/promotion/list"
        }
    }
}