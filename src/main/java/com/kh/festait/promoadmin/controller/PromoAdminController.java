package com.kh.festait.promoadmin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.festait.promoadmin.model.service.PromoAdminService;
import com.kh.festait.promoadmin.model.vo.PromoAdminVo;
import com.kh.festait.common.Pagination;
import com.kh.festait.common.model.vo.PageInfo;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promoAdmin")
public class PromoAdminController {

    private final PromoAdminService promoAdminService;

    // 관리자용 홍보 게시글 목록 조회 및 검색
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("")
    public String promoBoardList(
            @RequestParam(value = "searchType", defaultValue = "title") String searchType,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            Model model
    ) {
        if (keyword != null && keyword.trim().isEmpty()) {
            keyword = null;
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("keyword", keyword);

        int listCount = promoAdminService.getTotalPromoPostsCount(paramMap);
        
        int boardLimit = 10;
        int pageLimit = 10;
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, boardLimit, pageLimit);

        // DAO의 RowBounds 방식에 맞게 offset과 limit을 paramMap에 담는다.
        paramMap.put("offset", pi.getOffset());
        paramMap.put("limit", pi.getBoardLimit());

        List<PromoAdminVo> promoList = promoAdminService.selectPromoPostsList(paramMap);
        
        model.addAttribute("promoList", promoList);
        model.addAttribute("pi", pi);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        return "promotion/promoAdmin";
    }

    // 관리자용 홍보 게시글 삭제
    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/deletePromoPost")
    @ResponseBody
    public Map<String, String> deletePromoPost(@RequestParam("promoId") int promoId) {
        Map<String, String> response = new HashMap<>();
        try {
            promoAdminService.deletePromoPost(promoId);
            response.put("msg", "success");
        } catch (Exception e) {
            response.put("msg", "failure");
        }
        return response;
    }

    // 관리자용 홍보 게시글 상세 조회
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/detail")
    public String promoDetail(@RequestParam("promoId") int promoId, Model model) {
        PromoAdminVo promo = promoAdminService.selectPromoDetail(promoId);
        model.addAttribute("promo", promo);
        return "promotion/promoDetail";
    }
}