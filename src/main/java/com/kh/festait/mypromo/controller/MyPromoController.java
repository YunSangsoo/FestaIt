package com.kh.festait.mypromo.controller;

import java.util.ArrayList;
import java.util.Date;
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
// import com.kh.festait.user.model.vo.User;

// 내 홍보 게시글 관련 웹 요청 처리 컨트롤러
@Controller
@RequestMapping("/myPage")
public class MyPromoController {

    @Autowired
    private MyPromoService promoService;

    @GetMapping("/myPromo")
    public String selectMyPromoList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            HttpSession session,
            Model model,
            Authentication authentication) {

        int userNo = 0;
        userNo = 1; // 임시로 userNo를 1로 고정하여 테스트합니다.

        // ⭐⭐⭐ 임시 데이터 삽입 로직 (테스트용) ⭐⭐⭐
        if (userNo == 1) {
            int listCount = 25;
            
            List<MyPromoVo> dummyPromoList = new ArrayList<>();
            for (int i = 1; i <= listCount; i++) { 
                dummyPromoList.add(MyPromoVo.builder()
                                    .promoId(i)
                                    .promoTitle("임시 홍보 게시글 " + i)
                                    .views(100 + i)
                                    .createDate(new Date())
                                    .build());
            }
            model.addAttribute("myPromoList", dummyPromoList);
            
            PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
            model.addAttribute("pi", pi);
            
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userNo", userNo);
            paramMap.put("searchType", searchType);
            paramMap.put("searchKeyword", searchKeyword);
            model.addAttribute("param", paramMap);

            // ⭐⭐ 수정: JSP 경로를 "promotion/myPromo"로 변경 (사용자님 지시사항 반영) ⭐⭐
            return "promotion/myPromo"; 
        }
        // ⭐⭐⭐ 임시 데이터 삽입 로직 끝 ⭐⭐⭐

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("searchType", searchType);
        paramMap.put("searchKeyword", searchKeyword);

        int listCount = promoService.selectListCount(paramMap);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
        List<MyPromoVo> myPromoList = promoService.selectMyPromoList(paramMap, pi);

        model.addAttribute("pi", pi);
        model.addAttribute("myPromoList", myPromoList);
        model.addAttribute("param", paramMap);

        // ⭐⭐ 수정: JSP 경로를 "promotion/myPromo"로 변경 (사용자님 지시사항 반영) ⭐⭐
        return "promotion/myPromo";
        
    }
    
}

