package com.kh.festait.qnaboard.controller;

import com.kh.festait.qnaboard.model.service.QnaBoardService;
import com.kh.festait.qnaboard.model.vo.QnaBoard;
import com.kh.festait.security.model.vo.UserExt;

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
                Integer sessionUserNo = (Integer) session.getAttribute("UserNo");
                if (sessionUserNo == null) {
                    return "redirect:/login";
                }
                userNo = sessionUserNo;
            }

            log.info("auth: {}",((UserExt)auth.getPrincipal()).getUserNo());
            List<QnaBoard> qnaList = qnaBoardService.selectQnaList(view, userNo, page);
            int totalPage = qnaBoardService.getTotalPage(view, userNo);

            model.addAttribute("qnaList", qnaList);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("viewMode", view);
            model.addAttribute("action", "list");
            return "qnaBoard/qna";

        } else if ("detail".equals(action) && id != null) {
            QnaBoard qna = qnaBoardService.selectQnaById(id);
            model.addAttribute("qna", qna);
            model.addAttribute("action", "detail");
            return "qnaBoard/qna";

        } else if ("create".equals(action)) {
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
        //Integer userNo = (Integer) session.getAttribute("UserNo");
    	int userNo = ((UserExt)auth.getPrincipal()).getUserNo();
        log.info("auth: {}",auth);
        System.out.println("세션 UserNo: " + userNo);
        if (userNo == 0) {
            return "redirect:/login";
        }
        qna.setUserNo(userNo);
        qnaBoardService.insertQna(qna);
        return "redirect:/qnaBoard?action=list";
    }

    @PostMapping(params = "action=answer")
    public String answerQna(@RequestParam("id") int qnaId,
                            @RequestParam("answerDetail") String answerDetail,
                            HttpSession session) {

        // (선택) 관리자 권한 체크
        Object isAdmin = session.getAttribute("isAdmin");
        if (isAdmin == null || !(Boolean) isAdmin) {
            return "redirect:/accessDenied";
        }

        qnaBoardService.updateAnswer(qnaId, answerDetail);
        return "redirect:/qnaBoard?action=detail&id=" + qnaId;
    }
}
