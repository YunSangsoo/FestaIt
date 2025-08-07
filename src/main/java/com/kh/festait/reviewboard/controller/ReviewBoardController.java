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

import com.kh.festait.common.Pagination;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.service.ImageService;
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
	@Autowired
	private final ImageService imgService;
	
	private User loginUser = null;
	private int loginUserNo = -1;
	private int reviewIdentifier = 0;
	private String boardCode = "U";

	// 1. 리뷰 관리 페이지
	@GetMapping("")
	public String reviewBoard(@RequestParam Map<String, Object> paramMap, 
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
	    int limit = 10; // 한 페이지에 보여줄 게시글 수
	    int offset = (page - 1) * limit;
        
        paramMap.put("startRow", offset);
        paramMap.put("endRow", offset + limit);
	    
	    List<ReviewBoard> list = reviewBoardService.selectReviewList(paramMap);
	    int totalCount = reviewBoardService.getReviewCount(paramMap);

	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
		PageInfo pi = Pagination.getPageInfo(totalCount, page, pageBlock, limit);
	    
	    model.addAttribute("reviewBoard", list);
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("limit", limit);
	    model.addAttribute("pi", pi);

	    return "review/reviewBoard";
	}
	
	// 리뷰 리스트 페이지
    public String reviewList(
    		@RequestParam("appId") int appId,
    		@RequestParam(value = "page", defaultValue = "1") int page,
    		Model model, 
    		@RequestParam Map<String, Object> paramMap, 
    		Authentication authentication) {
    	
    	setloginUser(authentication);
		paramMap.put("loginUserNo", loginUserNo);
    	
    	reviewIdentifier = reviewBoardService.setReviewIdentifier(paramMap); // 0이면 리뷰 작성한 적 X
    	
        int limit = 5;
        int offset = (page - 1) * limit;
        
        paramMap.put("startRow", offset);
        paramMap.put("endRow", offset + limit);
        
        List<ReviewBoard> list = reviewBoardService.selectReviewList(paramMap);
        setProfileImage(list);
        
        int totalCount = reviewBoardService.getReviewCount(paramMap);

        int totalPage = (int) Math.ceil((double) totalCount / limit);
        int pageBlock = 5;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;
        
        String loginProfileImage = setLoginProfileImage(loginUserNo);
        
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginProfileImage", loginProfileImage);
        model.addAttribute("reviewList", list);
        model.addAttribute("param", paramMap);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("limit", limit);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        
        model.addAttribute("loginUserNo", loginUserNo);
        model.addAttribute("reviewIdentifier", reviewIdentifier);

        return "review/reviewList";
    }
    
	// 작성
	@PostMapping("/create")
    public String createReview(@RequestParam("appId") int appId, ReviewBoard review, 
    		RedirectAttributes ra, Authentication authentication,
    		@RequestParam Map<String, Object> paramMap, Model model) {
		
		setloginUser(authentication);
    	review.setUserNo(loginUserNo);
    	if(loginUserNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/eventBoard/detail?appId="+appId;
    	}
    	
    	review.setAppId(appId);
		
		int result = reviewBoardService.insertReview(review);
        ra.addFlashAttribute("msg", result > 0 ? "등록 완료" : "등록 실패");
        return "redirect:/eventBoard/detail?appId="+appId+"#review-container";
    }
	
	// 수정
	@PostMapping("/update")
	public String updateReviewByUserNo(@RequestParam("appId") int appId, 
			@RequestParam("userNo") int userNo,
			ReviewBoard review,
			RedirectAttributes ra, Authentication authentication,
			@RequestParam Map<String, Object> paramMap) {

		setloginUser(authentication);
		
		review.setAppId(appId);
		review.setUserNo(userNo);
		
    	if(loginUserNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/eventBoard/detail?appId="+appId+"#review-container";
    	}
    	
		int result = reviewBoardService.updateReviewByUserNo(review);
		
		ra.addFlashAttribute("msg", result > 0 ? "수정 완료" : "수정 실패");
		return "redirect:/eventBoard/detail?appId="+appId+"#review-container";
	}

	// 삭제
	@PostMapping("/delete")
	public String deleteReviewByUserNo(@RequestParam("appId") int appId, 
			@RequestParam("userNo") int userNo,
			@RequestParam Map<String, Object> paramMap,
			Authentication authentication,
			RedirectAttributes ra) {
		
		setloginUser(authentication);
		
    	if(loginUserNo == -1) {
    		ra.addFlashAttribute("msg", "로그인 후 사용할 수 있는 기능입니다.");
    		return "redirect:/eventBoard/detail?appId="+appId+"#review-container";
    	}
		
    	paramMap.put("appId", appId);
		paramMap.put("userNo", userNo);
		int result = reviewBoardService.deleteReviewByUserNo(paramMap);
		ra.addFlashAttribute("msg", result > 0 ? "삭제 완료" : "삭제 실패");
		
		return "redirect:/eventBoard/detail?appId="+appId+"#review-container";
	}
	
	public void setloginUser(Authentication authentication) {
		loginUserNo = -1;
		if (authentication != null && authentication.isAuthenticated()) {
        	loginUser = (User) authentication.getPrincipal();
        	loginUserNo = loginUser.getUserNo();
        }
	}
	
	public void setProfileImage(List<ReviewBoard> list) {
		if (list != null) {
			for(ReviewBoard review : list) {
				Image profileImage = imgService.getImageByRefNoAndType(review.getUserNo(), boardCode);
				if(profileImage != null) review.setProfileImage(profileImage);
			}
		}
	}
	
	public String setLoginProfileImage(int loginUserNo) {
		if (loginUserNo != -1) {
			Image profileImage = imgService.getImageByRefNoAndType(loginUserNo, "U");
			return profileImage == null ? "" : profileImage.getChangeName();
		}
		return "";
	}
	
}