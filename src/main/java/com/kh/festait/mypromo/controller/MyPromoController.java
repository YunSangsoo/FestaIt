package com.kh.festait.mypromo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession; // HttpSession은 현재 사용되지 않지만, 필요시를 위해 유지

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication; // Spring Security Authentication 객체
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;
import com.kh.festait.mypromo.model.service.MyPromoService;
import com.kh.festait.mypromo.model.vo.MyPromoVo;
import com.kh.festait.user.model.vo.User; // User 객체 (Spring Security Principal)

// 내 홍보 게시글 관련 웹 요청 처리 컨트롤러
@Controller
@RequestMapping("/myPage") // 기본 요청 경로: /myPage
public class MyPromoController {

    @Autowired // MyPromoService 의존성 자동 주입
    private MyPromoService promoService;

    @GetMapping("/myPromo") // 최종 요청 경로: /myPage/myPromo
    public String selectMyPromoList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage, // 현재 페이지 번호
            HttpSession session, // 현재 사용되지 않음
            Model model, // 뷰에 데이터 전달용 Model
            Authentication authentication) { // Spring Security 인증 객체

        int userNo = 0; // 사용자 번호 기본값

        // --- Spring Security 사용자 인증 로직 (현재 사용 안 함: 주석 처리) ---
        // if (authentication != null && authentication.isAuthenticated()
        //     && authentication.getPrincipal() instanceof User) {
        //     User loginUser = (User) authentication.getPrincipal();
        //     userNo = loginUser.getUserNo();
        // } else {
        //     // 인증 안된 상태 처리:
        //     // 1. 로그인 페이지로 리다이렉트 (필요시 주석 해제)
        //     // return "redirect:/login";
        //     // 2. 혹은 빈 목록을 보여주면서 올바른 JSP 페이지로 이동
        //     model.addAttribute("pi", Pagination.getPageInfo(0, currentPage, 10, 5));
        //     model.addAttribute("list", List.of());
        //     return "promotion/myPromo"; // JSP 경로 반환.
        // }
        // --- Spring Security 사용자 인증 로직 끝 ---

        // TODO: Spring Security 미사용 시, userNo를 세션 등 다른 방식으로 가져오거나
        //       임시로 고정된 userNo를 사용해야 함.
        // 예시: (임시) userNo = 1; // 실제 환경에서는 로그인된 사용자 번호를 가져와야 함.
        // 예시: HttpSession에서 userNo 가져오기 (Spring Security 미사용 시)
        // User loginUser = (User)session.getAttribute("loginUser");
        // if(loginUser != null) {
        //     userNo = loginUser.getUserNo();
        // } else {
        //     // 로그인되지 않은 경우 처리 (예: 로그인 페이지로 리다이렉트)
        //     return "redirect:/login";
        // }


        // 1. 전체 게시글 개수 조회
        int listCount = promoService.selectListCount(userNo);
        // 2. PageInfo 객체 생성 (페이지네이션 정보 계산)
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

        // 3. 현재 페이지에 필요한 게시글 목록 조회
        Map<String, Object> params = new HashMap<>();
        params.put("userNo", userNo); // 사용자 번호 추가
        params.put("offset", (pi.getCurrentPage() - 1) * pi.getBoardLimit()); // 조회 시작 위치
        params.put("limit", pi.getBoardLimit()); // 조회할 게시글 개수

        List<MyPromoVo> list = promoService.selectMyPromoList(params);

        // 4. Model에 데이터 추가
        model.addAttribute("pi", pi); // 페이지네이션 정보
        model.addAttribute("list", list); // 게시글 목록

        // 5. 뷰 이름 반환
        return "promotion/myPromo"; // JSP 경로 반환.
    }
}
