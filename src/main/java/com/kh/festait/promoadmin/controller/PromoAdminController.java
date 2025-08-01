package com.kh.festait.promoadmin.controller;

import java.util.HashMap; // HashMap import 추가
import java.util.List;
import java.util.Map; // Map import 추가

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.promoadmin.model.service.PromoAdminService;
import com.kh.festait.promoadmin.model.vo.PromoAdminVo;
// import com.kh.festait.common.model.vo.PageInfo; // PageInfo 클래스를 사용한다면 import

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/promoAdmin")
@Slf4j
public class PromoAdminController {

    private final PromoAdminService promoAdminService;

    // 관리자용 홍보 게시글 목록 조회 및 검색
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("")
    public String promoBoardList(
            @RequestParam(value="searchType", defaultValue="title") String searchType,
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="page", defaultValue="1") int currentPage,
            Model model
    ) {
        if (keyword != null && keyword.trim().isEmpty()) {
            keyword = null;
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("keyword", keyword);

        // 페이징 처리 로직
        int limit = 10;
        int listCount = promoAdminService.getTotalPromoPostsCount(paramMap);
        log.info("조회된 총 홍보 게시글 수 (totalCount): {}", listCount);

        int totalPage = (int) Math.ceil((double) listCount / limit);
        if (totalPage == 0) totalPage = 1;

        int pageBlock = 5; // 한 블록에 보여줄 페이지 수
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;

        // DB에서 조회할 시작/끝 행 번호 계산
        int offset = (currentPage - 1) * limit;
        int startRow = offset + 1;
        int endRow = offset + limit;

        paramMap.put("limit", limit); 
        paramMap.put("offset", offset);
        paramMap.put("startRow", startRow); 
        paramMap.put("endRow", endRow);

        List<PromoAdminVo> promoList = promoAdminService.selectPromoPostsList(paramMap);

        log.info("--- 컨트롤러에서 조회된 홍보 게시글 정보 ---");
        log.info("조회된 홍보 게시글 수: " + promoList.size());
        if (!promoList.isEmpty()) {
            for (int i = 0; i < Math.min(promoList.size(), 5); i++) {
                PromoAdminVo promo = promoList.get(i);
                String logMessage = String.format("게시글 %d: promoId=%d, promoTitle=%s, appTitle=%s, promoWriter=%s, views=%d, createDate=%s, userStatus=%s",
                        i + 1, promo.getPromoId(), promo.getPromoTitle(), promo.getAppTitle(),
                        promo.getPromoWriter(), promo.getViews(), promo.getCreateDate(), promo.getUserStatus());
                log.info(logMessage);
            }
        } else {
            log.info("promoList가 비어 있습니다.");
        }
        log.info("-------------------------------------");

        model.addAttribute("promoList", promoList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchType", searchType); 
        model.addAttribute("keyword", keyword);

        return "promotion/promoadmin";
    }
    
    // 관리자용 홍보 게시글 삭제
    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/deletePromoPost")
    public String deletePromoPost(@RequestParam("promoId") int promoId,
                                  RedirectAttributes ra) {

        log.info("관리자 홍보 게시글 삭제 요청 - promoId: {}", promoId);
        try {
            promoAdminService.deletePromoPost(promoId);
            ra.addFlashAttribute("alertMsg", "게시글이 삭제되었습니다.");
        } catch (Exception e) { 
            log.error("홍보 게시글 삭제 중 오류 발생: promoId={}, 오류: {}", promoId, e.getMessage());
            ra.addFlashAttribute("alertMsg", "게시글 삭제에 실패했습니다. 관리자에게 문의하세요.");
        }
        return "redirect:/promoAdmin";
    }
    
    // 관리자용 홍보 게시글 상세 조회
    @PreAuthorize("hasRole('ADMIN')") 
    @GetMapping("/detail")
    public String promoDetail(@RequestParam("promoId") int promoId, Model model
    ) {
        log.info("관리자 홍보 게시글 상세 조회 요청 - promoId: {}", promoId);
        PromoAdminVo promo = promoAdminService.selectPromoDetail(promoId);
        model.addAttribute("promo", promo);
        return "promoadmin/promoDetail";
    }
}