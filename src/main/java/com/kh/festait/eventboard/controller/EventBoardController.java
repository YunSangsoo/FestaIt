package com.kh.festait.eventboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.noticeboard.model.service.NoticeBoardService;
import com.kh.festait.noticeboard.model.vo.NoticeBoard;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/eventBoard")
public class EventBoardController {

	
	
	
	
	@Autowired
	private NoticeBoardService noticeBoardService;
	
	//1. 행사 리스트
	@GetMapping("/list")
	public String eventList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		
//		int limit = 10; // 한 페이지에 보여줄 게시글 수
//	    int offset = (page - 1) * limit;
//
//	    List<NoticeBoard> list = noticeBoardService.selectNoticeList(offset, limit);
//	    int totalCount = noticeBoardService.getNoticeCount();
//
//	    // 페이징 계산
//	    int totalPage = (int) Math.ceil((double) totalCount / limit);
//	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
//	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
//	    int endPage = startPage + pageBlock - 1;
//	    if (endPage > totalPage) endPage = totalPage;
//
//	    model.addAttribute("noticeList", list);
//	    model.addAttribute("totalCount", totalCount);
//	    model.addAttribute("currentPage", page);
//	    model.addAttribute("limit", limit);
//	    model.addAttribute("totalPage", totalPage);
//	    model.addAttribute("startPage", startPage);
//	    model.addAttribute("endPage", endPage);

	    return "event/eventBoardList";
	}
	@GetMapping("/calendar")
	public String eventCalendar(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		
//		int limit = 10; // 한 페이지에 보여줄 게시글 수
//	    int offset = (page - 1) * limit;
//
//	    List<NoticeBoard> list = noticeBoardService.selectNoticeList(offset, limit);
//	    int totalCount = noticeBoardService.getNoticeCount();
//
//	    // 페이징 계산
//	    int totalPage = (int) Math.ceil((double) totalCount / limit);
//	    int pageBlock = 5; // 한 번에 보여줄 페이지 번호 개수
//	    int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
//	    int endPage = startPage + pageBlock - 1;
//	    if (endPage > totalPage) endPage = totalPage;
//
//	    model.addAttribute("noticeList", list);
//	    model.addAttribute("totalCount", totalCount);
//	    model.addAttribute("currentPage", page);
//	    model.addAttribute("limit", limit);
//	    model.addAttribute("totalPage", totalPage);
//	    model.addAttribute("startPage", startPage);
//	    model.addAttribute("endPage", endPage);
		
		return "event/eventBoardCalendar";
	}
	
	//2. 공지사항 상세 보기
    @GetMapping("/detail")
    public String noticeDetail(@RequestParam("noticeId") int noticeId, Model model) {
        NoticeBoard notice = noticeBoardService.selectNoticeById(noticeId);
        model.addAttribute("notice", notice);
        return "noticeBoard/noticeDetail";
    }

//	/*
//	 * //3. 작성 폼
//	 * 
//	 * @GetMapping("/noticeWrite") public String showWriteForm() { return
//	 * "noticeBoard/noticeWrite"; }
//	 * 
//	 * @PostMapping("/create") public String createNotice(NoticeBoard notice,
//	 * RedirectAttributes ra) { int result =
//	 * noticeBoardService.insertNotice(notice); ra.addFlashAttribute("msg", result >
//	 * 0 ? "등록 완료" : "등록 실패"); return "redirect:/noticeBoard/list"; }
//	 * 
//	 * //4. 수정
//	 * 
//	 * @PostMapping("/update") public String updateNotice(NoticeBoard notice,
//	 * RedirectAttributes ra) { int result =
//	 * noticeBoardService.updateNotice(notice); ra.addFlashAttribute("msg", result >
//	 * 0 ? "수정 완료" : "수정 실패"); return "redirect:/noticeBoard/detail?noticeId=" +
//	 * notice.getNoticeId(); }
//	 * 
//	 * //5. 공지 삭제
//	 * 
//	 * @PostMapping("/delete") public String deleteNotice(@RequestParam("noticeId")
//	 * int noticeId, RedirectAttributes ra) { int result =
//	 * noticeBoardService.deleteNotice(noticeId); ra.addFlashAttribute("msg", result
//	 * > 0 ? "삭제 완료" : "삭제 실패"); return "redirect:/noticeBoard/list"; }
//	 */
	
	
}

