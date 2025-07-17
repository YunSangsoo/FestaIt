package com.kh.festait.promotion.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promotion.model.service.PromotionServiceImpl;
import com.kh.festait.promotion.model.vo.PromotionVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promotion")
@Slf4j
public class PromotionController {
	// 김현주 : 홍보게시판, 홍보세부페이지 요청 처리

    private final PromotionServiceImpl promotionService;

    // Promotion 게시판 목록 조회 서비스
    @GetMapping("/list")
    public String selectPromotionList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {

        log.info("Promotion list request - currentPage: {}, paramMap: {}", currentPage, paramMap);

        PageInfo pi = promotionService.getPromotionPageInfo(currentPage);
        List<PromotionVO> list = promotionService.getPromotionList(pi, paramMap);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", paramMap);

        // ★★★ JSP 경로 수정: promotionListView -> promotionBoard
        return "promotion/promotionBoard"; 
    }

    // Promotion 게시판 검색 목록 조회 서비스
    @GetMapping("/search")
    public String searchPromotions(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> searchParams,
            Model model) {

        log.info("Promotion search request - currentPage: {}, searchParams: {}", currentPage, searchParams);

        PageInfo pi = promotionService.getSearchedPromotionPageInfo(currentPage, searchParams);
        List<PromotionVO> list = promotionService.searchPromotions(searchParams, pi);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", searchParams);

        // ★★★ JSP 경로 수정: promotionListView -> promotionBoard
        return "promotion/promotionBoard"; 
    }

    // 프로모션 상세 보기
    @GetMapping("/detail/{promotionNo}")
    public String selectPromotionDetail(
        @PathVariable("promotionNo") int promotionNo,
        Model model) {
        // 상세 보기 로직
        // PromotionVO promo = promotionService.selectPromotion(promotionNo); // 실제 서비스 호출 필요
        // model.addAttribute("promo", promo);
        
        // ★★★ JSP 경로 확인: promotionDetailView -> promotionDetail (맞다면 그대로)
        return "promotion/promotionDetail"; 
    }

    // 여기에 프로모션 등록, 수정, 삭제 등의 메소드를 추가하면 됩니다.
    // 예시: 프로모션 등록 폼 (현재 BoardController에는 boardEnrollForm)
    // @GetMapping("/enroll")
    // public String enrollForm() {
    //    return "promotion/promotionEnrollForm"; // 필요하다면 이 JSP 파일을 생성해야 합니다.
    // }

    // 예시: 프로모션 등록 기능 (현재 BoardController에는 POST /insert)
    // @PostMapping("/insert")
    // public String insertPromotion(...) {
    //    // 등록 로직
    //    return "redirect:/promotion/list";
    // }
}