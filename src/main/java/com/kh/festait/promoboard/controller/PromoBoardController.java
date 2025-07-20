package com.kh.festait.promoboard.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.service.PromoBoardService;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promotion")
@Slf4j
public class PromoBoardController {

    private final PromoBoardService promoService;

    // 홍보 게시글 목록 조회
    @GetMapping("/list")
    public String selectPromotionList(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> paramMap,
            Model model) {

        log.info("Promotion list request - currentPage: {}, paramMap: {}", currentPage, paramMap);

        PageInfo pi = promoService.getPromoPageInfo(currentPage);
        List<PromoBoardVo> list = promoService.getPromoList(pi, paramMap);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", paramMap);

        return "promotion/promoBoard";
    }

    // 홍보 게시글 검색 결과 조회
    @GetMapping("/search")
    public String searchPromotions(
            @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam Map<String, Object> searchParams,
            Model model) {

        log.info("Promotion search request - currentPage: {}, searchParams: {}", currentPage, searchParams);

        PageInfo pi = promoService.getSearchPromoPageInfo(currentPage, searchParams);
        List<PromoBoardVo> list = promoService.searchPromo(searchParams, pi);

        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        model.addAttribute("param", searchParams);

        return "promotion/promotionBoard";
    }

    // 홍보 게시글 상세 조회
    @GetMapping("/detail/{promotionNo}")
    public String selectPromotionDetail(
            @PathVariable("promotionNo") int promotionNo,
            Model model) {

        // 상세 조회 기능 구현 시 추가 예정
        // PromoBoardVO promo = promoService.selectPromotion(promotionNo);
        // model.addAttribute("promo", promo);

        return "promotion/promotionDetail";
    }

    // 프로모션 등록, 수정, 삭제 기능 추가 시 여기에 작성
}
