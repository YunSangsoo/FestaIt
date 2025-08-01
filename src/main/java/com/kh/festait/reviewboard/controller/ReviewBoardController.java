package com.kh.festait.reviewboard.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.reviewboard.model.service.ReviewBoardService;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
import com.kh.festait.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reviewBoard")
public class ReviewBoardController {

	@Autowired
	private ReviewBoardService reviewBoardService;
	private int userNo = -1;
	private int reviewIdentifier = 0;

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
    public String reviewList(@RequestParam(value = "page", defaultValue = "1") int page, Model model, 
    		@RequestParam Map<String, Object> paramMap, Authentication authentication) {
    	
    	setUserNo(authentication);
    	
//    	행사 세부 합친 후 아래 코드 1행 삭제===========================================================================================
    	paramMap.put("appId", 1);
		paramMap.put("userNo", userNo);
    	
    	
    	reviewIdentifier = reviewBoardService.setReviewIdentifier(paramMap); // 0이면 리뷰 작성한 적 X
    	
    	
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
        
        model.addAttribute("userNo", userNo);
        model.addAttribute("reviewIdentifier", reviewIdentifier);

        return "review/reviewList";
    }
    
	// 작성
	@PostMapping("/create")
    public String createReview(ReviewBoard review, RedirectAttributes ra, Authentication authentication,
    		@RequestParam Map<String, Object> paramMap, Model model) {
		
		setUserNo(authentication);
    	review.setUserNo(userNo);
    	if(userNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/reviewBoard/list";
    	}
    	
//    	행사 세부 합친 후 아래 코드로 수정===========================================================================================
//    	review.setAppId(paramMap.get(appId));
    	review.setAppId(1);
		
		int result = reviewBoardService.insertReview(review);
        ra.addFlashAttribute("msg", result > 0 ? "등록 완료" : "등록 실패");
        return "redirect:/reviewBoard/list";
    }
	
	// 수정
	@PostMapping("/update")
	public String updateReviewByUserNo(ReviewBoard review, RedirectAttributes ra, Authentication authentication, @RequestParam Map<String, Object> paramMap) {

		setUserNo(authentication);
    	
//    	행사 세부 합친 후 아래 코드 1행 삭제===========================================================================================
		review.setAppId(1);
		review.setUserNo(userNo);
		
    	if(userNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/reviewBoard/list";
    	}
    	
		int result = reviewBoardService.updateReviewByUserNo(review);
		
		ra.addFlashAttribute("msg", result > 0 ? "수정 완료" : "수정 실패");
		return "redirect:/reviewBoard/list";
	}

	// 삭제
	@PostMapping("/delete")
	public String deleteReviewByUserNo(@RequestParam Map<String, Object> paramMap,
			Authentication authentication,
			RedirectAttributes ra) {
		
		setUserNo(authentication);
    	if(userNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/reviewBoard/list";
    	}
		
//    	행사 세부 합친 후 아래 코드 1행 삭제===========================================================================================
    	paramMap.put("appId", 1);
		paramMap.put("userNo", userNo);
		int result = reviewBoardService.deleteReviewByUserNo(paramMap);
		ra.addFlashAttribute("msg", result > 0 ? "삭제 완료" : "삭제 실패");
		return "redirect:/reviewBoard/list";
	}
	
	public void setUserNo(Authentication authentication) {
		userNo = -1;
		if (authentication != null && authentication.isAuthenticated()) {
        	User loginUser = (User) authentication.getPrincipal();
            userNo = loginUser.getUserNo();
        }
	}
	
}