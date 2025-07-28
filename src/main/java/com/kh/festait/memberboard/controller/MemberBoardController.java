package com.kh.festait.memberboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.festait.memberboard.model.service.MemberBoardService;
import com.kh.festait.memberboard.model.vo.MemberBoardList;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/memberBoard")
public class MemberBoardController {

    @Autowired
    private MemberBoardService memberBoardService;

    // 회원 목록 조회
    @GetMapping("")
    public String memberList(
            @RequestParam(value="keyword", required=false) String keyword,
            @RequestParam(value="page", defaultValue="1") int page,
            Model model) {

        int limit = 10;
        int offset = (page - 1) * limit;

        int totalCount = memberBoardService.getTotalCount(keyword);

        int totalPage = (int) Math.ceil((double) totalCount / limit);
        if (totalPage == 0) totalPage = 1;

        int pageBlock = 5;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;

        // offset과 limit을 기반으로 검색
        List<MemberBoardList> userList = memberBoardService.selectUserList(keyword, offset, limit);

        model.addAttribute("userList", userList);
        model.addAttribute("currentPage", page);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("keyword", keyword);

        return "memberBoard/memberBoardList";
    }
    
    //목록에서 삭제
    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("userNo") Long userNo) {
        memberBoardService.deleteUser(userNo);
        return "redirect:/memberBoard";  // 삭제 후 목록으로 이동
    }
    
    @GetMapping("/detail")
    public String memberDetail(@RequestParam("userNo") Long userNo, Model model) {
        MemberBoardList member = memberBoardService.selectUserById(userNo);
        model.addAttribute("member", member);
        return "memberBoard/memberDetail"; // 뷰 경로
    }
    
    
    
//    @GetMapping("/reviewBoard")
//    public String userReviewList(@RequestParam("userId") String userId, Model model) {
//        List<ReviewBoard> reviewList = reviewService.getReviewsByUser(userId);
//        model.addAttribute("reviewList", reviewList);
//        model.addAttribute("userId", userId);
//        return "reviewBoard/reviewBoardList";
//    }
    
//    @GetMapping("/faqBoard")
//    public String userInquiryList(@RequestParam("userId") String userId, Model model) {
//        List<FaqBoard> inquiryList = faqService.getInquiriesByUser(userId);
//        model.addAttribute("inquiryList", inquiryList);
//        model.addAttribute("userId", userId);
//        return "faqBoard/faqBoardList";
//    }
    
    
    
    
    
    
    
}
