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
import com.kh.festait.user.model.vo.User;

@Controller
@RequestMapping("/myPage") // 최종 요청 경로: /myPage/myPromo
public class MyPromoController {

    @Autowired
    private MyPromoService promoService;

    @GetMapping("/myPromo")
    // 인증 안 된 사용자는 로그인 페이지로 보내거나 빈 목록 처리 가능
    public String selectMyPromoList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            HttpSession session,
            Model model,
            Authentication authentication) {

        int userNo = 0; // 기본값

        if (authentication != null && authentication.isAuthenticated()
            && authentication.getPrincipal() instanceof User) {
            User loginUser = (User) authentication.getPrincipal();
            userNo = loginUser.getUserNo();
        } else {
            // 인증 안된 상태 처리:
            // 1. 로그인 페이지로 리다이렉트 (추천)
            // return "redirect:/login"; 
            // 2. 혹은 빈 목록을 보여주면서 올바른 JSP 페이지로 이동
            model.addAttribute("pi", Pagination.getPageInfo(0, currentPage, 10, 5));
            model.addAttribute("list", List.of());
            return "promotion/myPromo"; // <-- 이 부분을 "promotion/myPromo"로 수정했습니다.
        }

        int listCount = promoService.selectListCount(userNo);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

        Map<String, Object> params = new HashMap<>();
        params.put("userNo", userNo);
        params.put("offset", (pi.getCurrentPage() - 1) * pi.getBoardLimit());
        params.put("limit", pi.getBoardLimit());

        List<MyPromoVo> list = promoService.selectMyPromoList(params);

        model.addAttribute("pi", pi);
        model.addAttribute("list", list);

        return "promotion/myPromo";
    }
}
