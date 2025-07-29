package com.kh.festait.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.app.service.AppService;
import com.kh.festait.common.Pagination;
import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.PageInfo;
import com.kh.festait.common.service.ImageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/eventApp")
@RequiredArgsConstructor
@Slf4j
public class AdminAppController {


	@Autowired
	private final AppService appService;
	@Autowired
	private final ImageService imgService;
	@Autowired
	private final ServletContext app;
	

	/*
	 * 신청서의 BoardCode는 A이다.
	 * 이미지는 모두 한 테이블에 저장되기 때문에,
	 * 어느 페이지에서 사용된 이미지인지 분류하기 위해 사용
	 */
	private String boardCode = "A";

    
	

	@GetMapping("")
	public String appList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		int totalCount = appService.selectAppAllListCount();
		int limit = 10; // 한 페이지 하단에 보여질 페이지 목록 수
        int pageBlock = 10; // 한 페이지에 보여질 게시글 수
        
        //com.kh.festait.common에 Pagination 클래스를, com.kh.festait.common.model.vo에 pageInfo VO를 생성해뒀습니다.
        PageInfo pi = Pagination.getPageInfo(totalCount, page, limit, pageBlock);
        
        List<EventApplication> list = appService.selectAppAllList(pi);
        
        model.addAttribute("list", list);
        model.addAttribute("pi", pi);
        
        log.debug("총 게시글 수: {}", totalCount);
        log.debug("페이징 정보: {}", pi);
        log.debug("조회된 게시글 목록: {}", list.size());
		
		return "app/eventApplicationList";
	}
	
	
	@GetMapping("/appDetail/{appId}")
	public String loadApplying(@PathVariable("appId") int appId, Model model,RedirectAttributes ra) {
		EventApplication eventApplication = appService.getEvAppById(appId);
		eventApplication.setPosterImage(imgService.getImageByRefNoAndType(appId,boardCode));
		
		log.debug("evApp: {}", eventApplication);
		log.debug("appManager : {}", eventApplication.getAppManager());
		log.debug("image : {}", eventApplication.getPosterImage());
		log.debug("evCode : {}", eventApplication.getEventCode());
		
		if(eventApplication!=null) {
			
			if(eventApplication.getAppDetail()!=null)
				eventApplication.setAppDetail(Utils.newLineClear(eventApplication.getAppDetail()));
			model.addAttribute("eventApplication",eventApplication);
		}
			else
            ra.addFlashAttribute("msg", "해당하는 신청서를 찾을 수 없습니다.");
		return "app/eventApplicationForm";
	}
	
	@PostMapping("appApprove")
	public String approvingApp(
			@RequestParam("action") String action,
			@RequestParam(value="appId",required=true) String appId,
			@RequestParam("adminComment") String adminComment,
			 Model model,RedirectAttributes ra
			) {
		int result = 0;
		log.info("admin Comment : {}",adminComment);
		if(action.equals("A")) {
			result = appService.approvingApp(appId);
		}else {
			Map<String,String> setMap = new HashMap<>(); 
			setMap.put("appId", appId);
			setMap.put("adminComment", adminComment);
			result = appService.rejectingApp(setMap);
		}
		return "redirect:/eventApp";
	}
	
	
}
