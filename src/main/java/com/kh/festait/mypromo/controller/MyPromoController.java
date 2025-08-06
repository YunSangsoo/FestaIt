package com.kh.festait.mypromo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;  // Authentication import
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.Pagination;
import com.kh.festait.mypromo.model.service.MyPromoService;
import com.kh.festait.mypromo.model.vo.MyPromoVo;
import com.kh.festait.security.model.vo.UserExt;  // UserExt import

@Controller
@RequestMapping("/user/myPage")
public class MyPromoController {

    @Autowired
    private MyPromoService promoService;

    @GetMapping("/myPromo")
    public String selectMyPromoList(
        @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
        @RequestParam(value = "searchType", required = false) String searchType,
        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
        Model model,
        Authentication authentication
    ) {
        int userNo = 0;
        if(authentication != null && authentication.getPrincipal() instanceof UserExt) {
            UserExt loginUser = (UserExt) authentication.getPrincipal();
            userNo = loginUser.getUserNo();
        } else {
            model.addAttribute("alertMsg", "로그인 후 이용해 주세요.");
            return "redirect:/user/login";
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("searchType", searchType);
        paramMap.put("searchKeyword", searchKeyword);

        int listCount = promoService.selectListCount(paramMap);
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        List<MyPromoVo> myPromoList = promoService.selectMyPromoList(paramMap, pi);

        model.addAttribute("pi", pi);
        model.addAttribute("myPromoList", myPromoList);
        model.addAttribute("param", paramMap);

        return "promotion/myPromo";
    }
}
