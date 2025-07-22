package com.kh.festait.mypromo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.template.Pagination;
import com.kh.festait.mypromo.model.service.MyPromoService;
import com.kh.festait.mypromo.model.vo.MyPromoVo;
// import com.kh.festait.user.model.vo.User; // User 객체 (Spring Security Principal)

// 내 홍보 게시글 관련 웹 요청 처리 컨트롤러
@Controller
@RequestMapping("/myPage") // 기본 요청 경로: /myPage
public class MyPromoController {

    @Autowired // MyPromoService 의존성 자동 주입
    private MyPromoService promoService;

    @GetMapping("/myPromo") // 최종 요청 경로: /myPage/myPromo
    public String selectMyPromoList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage, // 현재 페이지 번호
            @RequestParam(value = "searchType", required = false) String searchType, // 검색 타입 (제목/내용)
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, // 검색어
            HttpSession session, // 현재 사용되지 않음
            Model model, // 뷰에 데이터 전달용 Model
            Authentication authentication) { // Spring Security 인증 객체

        int userNo = 0; // 사용자 번호 기본값

        // TODO: Spring Security 미사용 시, userNo를 세션 등 다른 방식으로 가져오거나
        //       임시로 고정된 userNo를 사용해야 함.
        // 현재는 임시로 userNo를 1로 고정하여 테스트합니다. (김관리 계정)
        userNo = 1; 

        // Spring Security 사용자 인증 로직 (주석 처리됨)
        // if (authentication != null && authentication.isAuthenticated()
        //      && authentication.getPrincipal() instanceof User) {
        //      User loginUser = (User) authentication.getPrincipal();
        //      userNo = loginUser.getUserNo();
        // } else {
        //      // 인증 안된 상태 처리:
        //      // session.setAttribute("alertMsg", "로그인 후 이용해주세요.");
        //      // return "redirect:/login";
        //      // 혹은 빈 목록을 보여주면서 올바른 JSP 페이지로 이동
        //      model.addAttribute("pi", Pagination.getPageInfo(0, currentPage, 10, 5));
        //      model.addAttribute("myPromoList", List.of()); // 빈 리스트 전달
        //      return "promotion/myPromo"; // JSP 경로 반환.
        // }

        // 검색 파라미터를 담을 Map 생성
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo); // 사용자 번호 추가 (필수)
        paramMap.put("searchType", searchType); // 검색 타입 추가
        paramMap.put("searchKeyword", searchKeyword); // 검색어 추가

        // 1. 전체 게시글 개수 조회 (검색 조건 포함)
        int listCount = promoService.selectListCount(paramMap); // paramMap 전달

        // 2. PageInfo 객체 생성 (페이지네이션 정보 계산)
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

        // 3. 현재 페이지에 필요한 게시글 목록 조회 (검색 조건 및 페이징 포함)
        List<MyPromoVo> myPromoList = promoService.selectMyPromoList(paramMap, pi); // paramMap과 pi 전달

        // 4. Model에 데이터 추가
        model.addAttribute("pi", pi); // 페이지네이션 정보
        model.addAttribute("myPromoList", myPromoList); // 게시글 목록
        model.addAttribute("param", paramMap); // 검색 파라미터 (JSP에서 검색어/타입 유지용)

        // 5. 뷰 이름 반환
        return "promotion/myPromo"; // JSP 경로 반환.
    }
}
