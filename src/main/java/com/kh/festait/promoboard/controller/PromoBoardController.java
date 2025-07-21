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

// 홍보 게시판 웹 요청 처리 컨트롤러
@Controller
@RequiredArgsConstructor // final 필드를 사용하는 생성자를 자동으로 생성하여 의존성 주입
@RequestMapping("/promoBoard") // 기본 요청 경로: /promoBoard
@Slf4j // 로깅을 위한 Lombok 어노테이션
public class PromoBoardController {

    private final PromoBoardService promoService; // PromoBoardService 의존성 주입

    // 홍보 게시글 목록 조회 및 검색 결과 조회 통합
    // URL: /promoBoard (전체 목록) 또는 /promoBoard?searchKeyword=... (검색)
    @GetMapping
    public String selectPromotionList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage, // 현재 페이지 번호
            @RequestParam Map<String, Object> paramMap, // 검색 키워드 등 모든 요청 파라미터
            Model model) { // 뷰에 데이터 전달용 Model

        log.info("홍보 게시글 목록/검색 요청 - 현재 페이지: {}, 파라미터: {}", currentPage, paramMap);

        PageInfo pi;
        List<PromoBoardVo> list;

        // 검색어가 존재하는지 확인 (searchKeyword 파라미터가 있고 비어있지 않은 경우)
        String searchKeyword = (String) paramMap.get("searchKeyword");
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // 검색어가 있을 경우 검색 로직 수행
            pi = promoService.getSearchPromoPageInfo(currentPage, paramMap);
            list = promoService.searchPromo(paramMap, pi);
        } else {
            // 검색어가 없을 경우 전체 목록 조회 로직 수행
            pi = promoService.getPromoPageInfo(currentPage);
            list = promoService.getPromoList(pi, paramMap);
        }

        model.addAttribute("list", list); // 게시글 목록 추가
        model.addAttribute("pi", pi);     // 페이지네이션 정보 추가
        model.addAttribute("param", paramMap); // 검색 파라미터 유지 (JSP에서 검색어 입력 필드에 표시)

        return "promotion/promoBoard"; // 홍보 게시판 목록 뷰 반환.
    }

    // 홍보 게시글 상세 조회
    // URL: /promoBoard/detail?promoId={promoId}
    @GetMapping("/detail")
    public String selectPromoDetail(
            @RequestParam("promoId") int promoId, // 조회할 게시글 ID
            Model model, // 뷰에 데이터 전달용 Model
            RedirectAttributes redirectAttributes) { // 리다이렉트 시 메시지 전달용

        log.info("홍보 상세 페이지 요청 - 게시글 번호: {}", promoId);

        // 조회수 증가
        int result = promoService.increasePromoViews(promoId);

        PromoBoardVo promo = null;
        if (result > 0) {
            // 조회수 증가 성공 시 상세 정보 조회
            promo = promoService.selectPromotionDetail(promoId);
        }

        // 조회 결과에 따라 뷰 반환
        if (promo != null) {
            model.addAttribute("promo", promo); // Model에 게시글 객체 추가
            log.info("홍보 상세 조회 성공: {}", promo);
            return "promotion/promoDetail"; // 상세 페이지 뷰 반환.
        } else {
            log.warn("홍보 게시물을 찾기 실패: 게시글 번호 {}", promoId);
            redirectAttributes.addFlashAttribute("alertMsg", "해당 홍보 게시물을 찾을 수 없습니다."); // 메시지 추가
            return "redirect:/promoBoard"; // 목록 페이지로 리다이렉트.
        }
    }

    // 홍보 게시글 작성 페이지로 이동
    // URL: /promoBoard/promoWrite (GET)
    @GetMapping("/promoWrite")
    public String enrollForm() {
        return "promotion/promoWrite"; // 작성 폼 뷰 반환.
    }

    // 홍보 게시글 작성 처리
    // URL: /promoBoard/promoWrite (POST)
    @PostMapping("/promoWrite")
    public String insertMyPromo(PromoBoardVo promo,
                                HttpServletRequest request, // 세션에서 사용자 정보 가져올 때 필요 (현재 사용 안 함)
                                RedirectAttributes redirectAttributes) {

        // ⭐⭐⭐ 임시: eventId를 하드코딩하여 테스트합니다. ⭐⭐⭐
        // 실제 애플리케이션에서는 사용자 입력 또는 선택 (예: 드롭다운 목록)을 통해 받아야 합니다.
        // 사용자님이 제공한 SQL 데이터에 따르면 EVENT_ID 1, 2, 3이 존재합니다.
        // 여기서는 테스트를 위해 1번 이벤트를 가정합니다.
        promo.setEventId(1); // 또는 2, 3 등 유효한 EVENT_ID로 설정

        // --- Spring Security 미사용 시 사용자 인증/권한 로직 (주석 처리) ---
        // 현재 로그인된 사용자 정보 (예: userNo)를 promo 객체에 설정해야 합니다.
        // User loginUser = (User)request.getSession().getAttribute("loginUser"); // 세션에서 사용자 객체 가져오기
        // if(loginUser != null) {
        //     promo.setUserNo(loginUser.getUserNo()); // PromoBoardVo에 작성자 userNo 설정
        // } else {
        //     redirectAttributes.addFlashAttribute("alertMsg", "로그인 후 이용해주세요.");
        //     return "redirect:/login"; // 로그인 페이지로 리다이렉트.
        // }
        // --- Spring Security 미사용 시 사용자 인증/권한 로직 끝 ---

        // 홍보 게시글 DB에 삽입
        int result = promoService.insertPromo(promo);

        // 결과에 따른 리다이렉트 및 메시지 설정
        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 작성되었습니다.");
            return "redirect:/promoBoard"; // 목록 페이지로 리다이렉트.
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 작성에 실패했습니다.");
            return "common/errorPage"; // 오류 페이지 뷰 반환.
        }
    }

    // 홍보 게시글 수정 페이지로 이동
    // URL: /promoBoard/promoUpdate?promoId={promoId}
    @GetMapping("/promoUpdate")
    public String updateMyPromoForm(
            @RequestParam(value = "promoId", required = false) Integer promoId, // promoId를 선택적(optional)으로 변경
            Model model,
            RedirectAttributes redirectAttributes) {

        // promoId가 전달되지 않았을 경우 (직접 URL 접근 등)
        if (promoId == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "수정할 게시글 번호가 지정되지 않았습니다.");
            return "redirect:/promoBoard"; // 목록 페이지로 리다이렉트.
        }

        // --- Spring Security 미사용 시 사용자 권한 확인 로직 (주석 처리) ---
        // 게시글 작성자와 현재 로그인한 사용자가 일치하는지 확인하는 로직이 필요할 수 있습니다.
        // User loginUser = (User)request.getSession().getAttribute("loginUser");
        // PromoBoardVo originalPromo = promoService.selectPromotionDetail(promoId);
        // if (originalPromo == null || (loginUser != null && originalPromo.getUserNo() != loginUser.getUserNo())) {
        //     redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 존재하지 않는 게시글입니다.");
        //     return "redirect:/promoBoard";
        // }
        // --- Spring Security 미사용 시 사용자 권한 확인 로직 끝 ---

        // 게시글 상세 정보 조회
        PromoBoardVo promo = promoService.selectPromotionDetail(promoId);

        // 조회 결과에 따른 뷰 반환
        if (promo == null) {
            redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없거나 존재하지 않는 게시글입니다.");
            return "redirect:/promoBoard"; // 목록 페이지로 리다이렉트.
        }

        model.addAttribute("promo", promo); // Model에 게시글 객체 추가
        return "promotion/promoUpdate"; // 수정 폼 뷰 반환.
    }

    // 홍보 게시글 수정 처리
    // URL: /promoBoard/update
    @PostMapping("/update")
    public String updateMyPromo(PromoBoardVo promo,
                                HttpServletRequest request, // 세션에서 사용자 정보 가져올 때 필요 (현재 사용 안 함)
                                RedirectAttributes redirectAttributes) {

        // --- Spring Security 미사용 시 사용자 권한 확인 로직 (주석 처리) ---
        // 게시글 작성자와 현재 로그인한 사용자가 일치하는지 확인하는 로직이 필요할 수 있습니다.
        // User loginUser = (User)request.getSession().getAttribute("loginUser");
        // if(loginUser == null || promo.getUserNo() != loginUser.getUserNo()){ // promo 객체에 userNo가 설정되어 있다고 가정
        //     redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정 권한이 없습니다.");
        //     return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId();
        // }
        // --- Spring Security 미사용 시 사용자 권한 확인 로직 끝 ---

        // 홍보 게시글 DB 업데이트
        int result = promoService.updatePromo(promo);

        // 결과에 따른 리다이렉트 및 메시지 설정
        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글이 성공적으로 수정되었습니다.");
            return "redirect:/promoBoard/detail?promoId=" + promo.getPromoId(); // 상세 페이지로 리다이렉트.
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "홍보 게시글 수정에 실패했습니다.");
            return "common/errorPage"; // 오류 페이지 뷰 반환.
        }
    }

    // 홍보 게시글 삭제 처리
    // URL: /promoBoard/delete
    @PostMapping("/delete")
    @ResponseBody // 응답 본문에 데이터를 직접 포함 (Ajax 요청용)
    public Map<String, String> deleteMyPromo(@RequestParam("promoId") int promoId) { // 삭제할 게시글 ID

        Map<String, String> response = new HashMap<>(); // 응답 데이터 맵
        Map<String, Object> params = new HashMap<>(); // 서비스/DAO에 전달할 파라미터 맵
        params.put("promoId", promoId);

        // --- Spring Security 미사용 시 사용자 권한 확인 로직 (주석 처리) ---
        // 게시글 작성자와 현재 로그인한 사용자가 일치하는지 확인하는 로직이 필요할 수 있습니다.
        // User loginUser = (User)request.getSession().getAttribute("loginUser"); // HttpServletRequest 필요
        // if(loginUser == null || !promoService.isWriter(promoId, loginUser.getUserNo())){ // isWriter 메서드 가정
        //     response.put("msg", "unauthorized"); // 권한 없음 메시지
        //     return response;
        // }
        // --- Spring Security 미사용 시 사용자 권한 확인 로직 끝 ---

        // 홍보 게시글 DB에서 삭제
        int result = promoService.deletePromo(params);

        // 결과에 따른 응답 메시지 설정
        if (result > 0) {
            response.put("msg", "success"); // 성공 메시지
        } else {
            response.put("msg", "fail"); // 실패 메시지
        }
        return response; // 응답 맵 반환.
    }
}
