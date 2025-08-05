package com.kh.festait.qnaboard.controller;

import com.kh.festait.qnaboard.model.service.QnaBoardService;
import com.kh.festait.qnaboard.model.vo.QnaBoard;
import com.kh.festait.security.model.vo.UserExt;
import com.kh.festait.common.Utils;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/qnaBoard")
public class QnaBoardController {

    private final QnaBoardService qnaBoardService;

    @GetMapping
    public String handleQna(@RequestParam(value = "action", required = false, defaultValue = "list") String action,
                            @RequestParam(value = "id", required = false) Integer id,
                            @RequestParam(value = "view", defaultValue = "all") String view,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                    		Authentication auth,
                            Model model,
                            HttpSession session) {
    	
    	if ("list".equals(action)) {
    	    int userNo = 0;
    	    if ("mine".equals(view)) {
    	        if (auth == null || auth.getPrincipal() == null || !(auth.getPrincipal() instanceof UserExt)) {
    	            return "redirect:/login";
    	        }
    	        userNo = ((UserExt) auth.getPrincipal()).getUserNo();
    	    }

    	    int limit = 10;  // 한 페이지에 보여줄 항목 수
    	    List<QnaBoard> qnaList = qnaBoardService.selectQnaList(view, userNo, page, limit);
    	    int totalCount = qnaBoardService.getTotalCount(view, userNo);  // 전체 게시글 수
    	    
    	    // userId 마스킹 처리
    	    for (QnaBoard qna : qnaList) {
    	        String originalId = qna.getUserId();
    	        if (originalId != null) {
    	            int showCount = 4;
    	            int maxLength = 12;
    	            String masked;
    	            if (originalId.length() <= showCount) {
    	                masked = originalId;
    	            } else {
    	                int maskLength = Math.min(originalId.length(), maxLength) - showCount;
    	                String stars = "*".repeat(maskLength);
    	                masked = originalId.substring(0, showCount) + stars;
    	            }
    	            qna.setUserId(masked);
    	        }
    	    }

    	    
    	    
    	    int totalPage = (int) Math.ceil((double) totalCount / limit);

    	    int pageBlock = 5;  // 한 번에 보여줄 페이지 번호 개수
    	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
    	    int endPage = startPage + pageBlock - 1;
    	    if (endPage > totalPage) {
    	        endPage = totalPage;
    	    }

    	    model.addAttribute("qnaList", qnaList);
    	    model.addAttribute("currentPage", page);
    	    model.addAttribute("totalPage", totalPage);
    	    model.addAttribute("startPage", startPage);
    	    model.addAttribute("endPage", endPage);
    	    model.addAttribute("limit", limit);
    	    model.addAttribute("viewMode", view);
    	    model.addAttribute("action", "list");
    	    return "qnaBoard/qna";

        } else if ("detail".equals(action) && id != null) {
            QnaBoard qna = qnaBoardService.selectQnaById(id);
            int userNo = 0;
            if (auth != null && auth.getPrincipal() instanceof UserExt) {
                userNo = ((UserExt)auth.getPrincipal()).getUserNo();
            }

            // 비밀글 권한 체크
            boolean isAdmin = auth != null && auth.getAuthorities().stream()
                            .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if ("Y".equals(qna.getIsPrivate()) && userNo != qna.getUserNo() && !isAdmin) {
                model.addAttribute("errorMessage", "비밀글입니다. 작성자와 관리자만 내용 확인이 가능합니다.");
            }

            model.addAttribute("qna", qna);
            model.addAttribute("action", "detail");
            model.addAttribute("user", auth != null && auth.getPrincipal() instanceof UserExt ? (UserExt)auth.getPrincipal() : null);
            return "qnaBoard/qna";

        } else if ("create".equals(action)) {
        	if (auth == null || auth.getPrincipal() == null || !(auth.getPrincipal() instanceof UserExt)) {
                return "redirect:/login";
            }
            model.addAttribute("action", "create");
            return "qnaBoard/qna";
        }

        return "redirect:/qnaBoard?action=list";
    }

    // 문의 등록
    @PostMapping
    public String createQna(@ModelAttribute QnaBoard qna, 
    		Authentication auth,
    		HttpSession session) {
    	if (auth == null || !(auth.getPrincipal() instanceof UserExt)) {
            // 로그인 안 했으면 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }
        //Integer userNo = (Integer) session.getAttribute("UserNo");
    	int userNo = ((UserExt)auth.getPrincipal()).getUserNo();
        log.info("auth: {}",auth);
        System.out.println("세션 UserNo: " + userNo);
        if (userNo == 0) {
            return "redirect:/login";
        }
        qna.setUserNo(userNo);
        
        qna.setQnaTitle(Utils.XSSHandling(qna.getQnaTitle()));
        qna.setQnaDetail(Utils.newLineHandling(Utils.XSSHandling(qna.getQnaDetail())));
        
        if (qna.getIsPrivate() == null || !"Y".equals(qna.getIsPrivate())) {
            qna.setIsPrivate("N");
        }
        
        qnaBoardService.insertQna(qna);
        return "redirect:/qnaBoard?action=list";
    }

    @PostMapping(params = "action=answer")
    public String answerQna(@RequestParam("id") int qnaId,
                            @RequestParam("answerDetail") String answerDetail,
                            Authentication auth,
                            Model model) {

        // 권한 체크 (스프링 시큐리티 권한으로 체크하는 게 더 좋음)
        if (auth == null || auth.getAuthorities().stream().noneMatch(
                a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            // 권한 없을 때 메시지 전달
            model.addAttribute("errorMessage", "답변 작성 권한이 없습니다.");
            
            // 답변 대상 qna 정보 다시 조회해서 모델에 담기
            QnaBoard qna = qnaBoardService.selectQnaById(qnaId);
            model.addAttribute("qna", qna);
            model.addAttribute("action", "detail");
            
            return "qnaBoard/qna";  // 뷰 이름 반환 (같은 상세 페이지 뷰)
        }

        // 권한 있으면 답변 등록
        qnaBoardService.updateAnswer(qnaId, answerDetail);
        return "redirect:/qnaBoard?action=detail&id=" + qnaId;
    }
    
    @PostMapping(params = "action=delete")
    public String deleteQna(@RequestParam("id") int qnaId, Authentication auth, Model model) {
        if (auth == null || !(auth.getPrincipal() instanceof UserExt)) {
            return "redirect:/login";
        }

        UserExt user = (UserExt) auth.getPrincipal();
        QnaBoard qna = qnaBoardService.selectQnaById(qnaId);
        if (qna == null) {
            model.addAttribute("errorMessage", "존재하지 않는 문의입니다.");
            return "qnaBoard/qna";
        }

        boolean isAdmin = auth.getAuthorities().stream()
                              .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        // 작성자 또는 관리자만 삭제 가능
        if (user.getUserNo() != qna.getUserNo() && !isAdmin) {
            model.addAttribute("errorMessage", "삭제 권한이 없습니다.");
            model.addAttribute("qna", qna);
            model.addAttribute("action", "detail");
            return "qnaBoard/qna";
        }

        qnaBoardService.deleteQna(qnaId);
        return "redirect:/qnaBoard?action=list";
    }
    
}