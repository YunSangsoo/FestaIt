package com.kh.festait.promoboard.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.promoboard.model.service.PromoBoardService;
import com.kh.festait.promoboard.model.vo.PromoBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promoBoard")
@Slf4j
public class PromoBoardController {

    private final PromoBoardService promoService;

    // 홍보 게시글 목록 조회
    // URL: /promoBoard
    @GetMapping
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
    // URL: /promoBoard/search
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

        return "promotion/promoBoard";
    }

    // 홍보 게시글 상세 조회
    // URL: /promoBoard/detail?promoId=${boardNo}
    @GetMapping("/detail")
    public String selectPromoDetail(
            @RequestParam("promoId") int promoId,
            Model model,
            RedirectAttributes redirectAttributes) {

        log.info("홍보 상세 페이지 요청 - 게시글 번호: {}", promoId);

        int result = promoService.increasePromoViews(promoId);

        PromoBoardVo promo = null;
        if (result > 0) {
            promo = promoService.selectPromotionDetail(promoId);
        }

        if (promo != null) {
            model.addAttribute("promo", promo);
            log.info("홍보 상세 조회 성공: {}", promo);
            return "promotion/promoDetail";
        } else {
            log.warn("홍보 게시물을 찾기 실패: 게시글 번호 {}", promoId);
            redirectAttributes.addFlashAttribute("alertMsg", "해당 홍보 게시물을 찾을 수 없습니다.");
            return "redirect:/promoBoard";
        }
    }

    // 홍보 게시글 작성 페이지로 이동
    // URL: /promoBoard/promoWrite (GET)
    @GetMapping("/promoWrite")
    public String enrollForm() {
        return "promotion/promoWrite"; // ⭐️ "promotion/promoWriteForm" -> "promotion/promoWrite"로 변경
    }

    // 홍보 게시글 작성 처리
    // URL: /promoBoard/promoWrite (POST)
    @PostMapping("/promoWrite")
    public String insertMyPromo(PromoBoardVo promo,
                                HttpServletRequest request,
                                RedirectAttributes redirectAttributes) {

        int result = promoService.insertPromo(promo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 작성되었습니다.");
            return "redirect:/promoBoard";
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 작성에 실패했습니다.");
            return "common/errorPage";
        }
    }

    // 홍보 게시글 수정 페이지로 이동
    // URL: /promoBoard/promoUpdate?promoId=${boardNo}
    @GetMapping("/promoUpdate")
    public String updateMyPromoForm(@RequestParam("promoId") int promoId, Model model, RedirectAttributes redirectAttributes) {
        PromoBoardVo promo = promoService.selectPromotionDetail(promoId);

        if (promo == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 존재하지 않는 게시글입니다.");
            return "redirect:/promoBoard";
        }

        model.addAttribute("promo", promo);
        return "promotion/promoUpdateForm"; // 이 뷰 이름은 그대로 유지합니다.
    }

    // 홍보 게시글 수정 처리
    // URL: /promoBoard/update
    @PostMapping("/update")
    public String updateMyPromo(PromoBoardVo promo,
                                HttpServletRequest request,
                                RedirectAttributes redirectAttributes) {

        int result = promoService.updatePromo(promo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 수정되었습니다.");
            return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 수정에 실패했습니다.");
            return "common/errorPage";
        }
    }

    // 홍보 게시글 삭제 처리
    // URL: /promoBoard/delete
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, String> deleteMyPromo(@RequestParam("promoId") int promoId) {

        Map<String, String> response = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("promoId", promoId);

        int result = promoService.deletePromo(params);

        if (result > 0) {
            response.put("msg", "success");
        } else {
            response.put("msg", "fail");
        }
        return response;
    }
}
