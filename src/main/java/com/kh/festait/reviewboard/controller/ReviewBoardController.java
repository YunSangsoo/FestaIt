package com.kh.festait.reviewboard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.reviewboard.model.service.ReviewBoardService;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
import com.kh.festait.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reviewBoard")
public class ReviewBoardController {

	private final ReviewBoardService reviewBoardService;

	// 리뷰 관리 페이지
	@GetMapping("")
	public String reviewBoard(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
	    int limit = 10;
	    int offset = (page - 1) * limit;

	    List<ReviewBoard> list = reviewBoardService.selectReviewList(offset, limit);
	    int totalCount = reviewBoardService.getReviewCount();

	    // 페이징 계산
	    int totalPage = (int) Math.ceil((double) totalCount / limit);
	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
	    int endPage = startPage + pageBlock - 1;
	    if (endPage > totalPage) endPage = totalPage;

	    model.addAttribute("reviewBoard", list);
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("limit", limit);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);

	    return "review/reviewBoard";
	}
	
	// 리뷰 리스트 페이지
    @GetMapping("/list")
    public String reviewList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int limit = 5;
        int offset = (page - 1) * limit;

        List<ReviewBoard> list = reviewBoardService.selectReviewList(offset, limit);
        int totalCount = reviewBoardService.getReviewCount();

        int totalPage = (int) Math.ceil((double) totalCount / limit);
        int pageBlock = 5;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;

        model.addAttribute("reviewList", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("limit", limit);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "review/reviewList";
    }
    
    // 리뷰 등록
    @PostMapping("/create")
    public String insertReview(ReviewBoard review, RedirectAttributes ra, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        System.out.println("insertReview에서 loginUser: " + loginUser);

        if (loginUser != null) {
            review.setUserNo(loginUser.getUserNo());
            review.setAppId(1);  // 앱 ID가 동적으로 필요한 게 아니라면 이렇게라도 넣어줘야 함
        } else {
            ra.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/user/login";
        }

        int result = reviewBoardService.insertReview(review);
        ra.addFlashAttribute("msg", result > 0 ? "등록 완료" : "등록 실패");
        return "redirect:/reviewBoard/list";
    }
	
    // 리뷰 등록
    @PostMapping("/update")
    public String updateReviewByUserNo(ReviewBoard review, RedirectAttributes ra, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");

        // ✅ 로그인 여부 및 권한 확인
        if (loginUser == null || loginUser.getUserNo() != review.getUserNo()) {
            ra.addFlashAttribute("msg", "수정 권한이 없습니다.");
            return "redirect:/reviewBoard/list";
        }

        int result = reviewBoardService.updateReviewByUserNo(review);
        ra.addFlashAttribute("msg", result > 0 ? "수정 완료" : "수정 실패");
        return "redirect:/reviewBoard/list";
    }

    // 리뷰 삭제
    @PostMapping("/delete")
    public String deleteReviewByUserNo(@RequestParam("userNo") int userNo, HttpSession session, RedirectAttributes ra) {
        User loginUser = (User) session.getAttribute("loginUser");

        // ✅ 본인만 삭제 가능하게 체크
        if (loginUser == null || loginUser.getUserNo() != userNo) {
            ra.addFlashAttribute("msg", "삭제 권한이 없습니다.");
            return "redirect:/reviewBoard/list";
        }

        int result = reviewBoardService.deleteReviewByUserNo(userNo);
        ra.addFlashAttribute("msg", result > 0 ? "삭제 완료" : "삭제 실패");
        return "redirect:/reviewBoard/list";
    }
	
}