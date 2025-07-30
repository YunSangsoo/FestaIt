package com.kh.festait.reviewboard.controller;

import java.util.List;

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

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reviewBoard")
public class ReviewBoardController {

	@Autowired
	private ReviewBoardService reviewBoardService;

	// 1. 리뷰 관리 페이지
	@GetMapping("")
	public String reviewBoard(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
	    int limit = 10; // 한 페이지에 보여줄 게시글 수
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
    
	// 작성
	@PostMapping("/create")
    public String createReview(ReviewBoard review, RedirectAttributes ra) {
        int result = reviewBoardService.insertReview(review);
        ra.addFlashAttribute("msg", result > 0 ? "등록 완료" : "등록 실패");
        return "redirect:/reviewBoard/list";
    }
	
	// 수정
	@PostMapping("/update")
	public String updateReviewByUserNo(ReviewBoard review, RedirectAttributes ra) {
		int result = reviewBoardService.updateReviewByUserNo(review);
		ra.addFlashAttribute("msg", result > 0 ? "수정 완료" : "수정 실패");
		return "redirect:/reviewBoard/list";
	}

	// 삭제
	@PostMapping("/delete")
	public String deleteReviewByUserNo(@RequestParam("userNo") int userNo, RedirectAttributes ra) {
		int result = reviewBoardService.deleteReviewByUserNo(userNo);
		ra.addFlashAttribute("msg", result > 0 ? "삭제 완료" : "삭제 실패");
		return "redirect:/reviewBoard/list";
	}
	
}