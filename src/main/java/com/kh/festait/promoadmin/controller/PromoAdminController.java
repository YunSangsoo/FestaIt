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
            @RequestParam(value="searchType", defaultValue="title") String searchType, // ⭐ 추가: searchType 파라미터 받기 ⭐
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="page", defaultValue="1") int currentPage, // 변수명 page -> currentPage로 통일 권장
            Model model
    ) {
        // 검색어가 비어있을 경우 null로 처리
        if (keyword != null && keyword.trim().isEmpty()) {
            keyword = null;
        }

        // ⭐ Service 계층으로 전달할 파라미터 Map 생성 ⭐
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("searchType", searchType);
        paramMap.put("keyword", keyword);

        // 페이징 처리 로직
        int limit = 10; // 한 페이지에 보여줄 게시글 수
        int listCount = promoAdminService.getTotalPromoPostsCount(paramMap); // ⭐ paramMap 전달 ⭐
        log.info("조회된 총 홍보 게시글 수 (totalCount): {}", listCount);

        int totalPage = (int) Math.ceil((double) listCount / limit);
        if (totalPage == 0) totalPage = 1;

        int pageBlock = 5; // 한 블록에 보여줄 페이지 수
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;

        // DB에서 조회할 시작/끝 행 번호 계산
        int offset = (currentPage - 1) * limit; // ROWNUM 시작점 (0부터 시작)
        int startRow = offset + 1; // ROWNUM은 1부터 시작
        int endRow = offset + limit;

        // ⭐ paramMap에 페이징 정보 추가 ⭐
        paramMap.put("limit", limit); // 또는 pageInfo 객체를 사용한다면 pageInfo를 통째로 넘겨도 됨
        paramMap.put("offset", offset);
        paramMap.put("startRow", startRow); // Mapper에서 startRow, endRow를 사용할 경우
        paramMap.put("endRow", endRow);     // Mapper에서 startRow, endRow를 사용할 경우

        List<PromoAdminVo> promoList = promoAdminService.selectPromoPostsList(paramMap); // ⭐ paramMap 전달 ⭐

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
        model.addAttribute("searchType", searchType); // ⭐ 추가: searchType 다시 JSP로 전달 ⭐
        model.addAttribute("keyword", keyword);

        return "promotion/promoadmin";
    }
    
    // 관리자용 홍보 게시글 삭제
    @PreAuthorize("hasRole('ADMIN')") // ⭐ ADMIN 권한이 있는 사용자만 접근 허용
    @PostMapping("/deletePromoPost")
    public String deletePromoPost(@RequestParam("promoId") int promoId,
                                  RedirectAttributes ra) {

        log.info("관리자 홍보 게시글 삭제 요청 - promoId: {}", promoId);
        try {
            promoAdminService.deletePromoPost(promoId);
            ra.addFlashAttribute("alertMsg", "게시글이 삭제되었습니다.");
        } catch (Exception e) { // 삭제 중 발생할 수 있는 모든 예외를 잡습니다.
            log.error("홍보 게시글 삭제 중 오류 발생: promoId={}, 오류: {}", promoId, e.getMessage());
            ra.addFlashAttribute("alertMsg", "게시글 삭제에 실패했습니다. 관리자에게 문의하세요.");
        }
        return "redirect:/promoAdmin";
    }
    
    // 관리자용 홍보 게시글 상세 조회
    @PreAuthorize("hasRole('ADMIN')") // ⭐ ADMIN 권한이 있는 사용자만 접근 허용
    @GetMapping("/detail")
    public String promoDetail(@RequestParam("promoId") int promoId, Model model
    ) {
        log.info("관리자 홍보 게시글 상세 조회 요청 - promoId: {}", promoId);
        PromoAdminVo promo = promoAdminService.selectPromoDetail(promoId);
        model.addAttribute("promo", promo);
        return "promoadmin/promoDetail"; // ⭐ JSP 경로가 promoadmin/promoDetail 인지 확인해주세요. ⭐
    }
}