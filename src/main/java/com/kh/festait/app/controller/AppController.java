package com.kh.festait.app.controller;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.app.model.vo.AppManager;
import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.app.service.AppService;
import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.service.ImageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/myEventApp")
@RequiredArgsConstructor
@Slf4j
public class AppController {
	
	@Autowired
	private final AppService appService;
	
	@Autowired
	private final ImageService imgService;
	
	@Autowired
	private final ServletContext app;
	
	private String boardCode = "A";

	@GetMapping("/appWrite")
	public String appWrite(Model model) {
		EventApplication evApp = new EventApplication();
		evApp.setAppManager(new AppManager());
		model.addAttribute("eventApplication", evApp);
		return "app/eventApplicationForm";
	}
	
	@GetMapping("/appEdit/{appId}")
	public String loadApplying(@PathVariable("appId") int appId, Model model,RedirectAttributes ra) {
		EventApplication eventApplication = appService.getEvAppById(appId);
		eventApplication.setPosterImage(imgService.getImageByRefNoAndType(appId,boardCode));
		
		log.debug("evApp: {}", eventApplication);
		log.debug("appManager : {}", eventApplication.getAppManager());
		log.debug("image : {}", eventApplication.getPosterImage());
		
		if(eventApplication!=null) {
			if(eventApplication.getAppDetail()!=null)
				eventApplication.setAppDetail(Utils.newLineClear(eventApplication.getAppDetail()));
			model.addAttribute("eventApplication",eventApplication);
		}
			else
            ra.addFlashAttribute("msg", "해당하는 신청서를 찾을 수 없습니다.");
		return "app/eventApplicationForm";
	}
	
	@PostMapping("/appSave")
	public String applyingForm(
			@ModelAttribute("eventApplication") /*@Valid*/  EventApplication eventApplication,
			//BindingResult bindingResult, 유효성 결과
			Model model,
			//Authentication auth,
			@RequestParam("action") String action,
			RedirectAttributes ra,
			//@RequestParam(value="inputPoster",required=false) List<MultipartFile> upfiles, // inputPoster의 name 속성과 일치
			@RequestParam(value="inputPoster",required=false) MultipartFile upfile, // inputPoster의 name 속성과 일치
			@RequestParam(value="existingImgNo", required=false, defaultValue="0") int existingImgNo // JSP에서 hidden 필드로 전달된 기존 이미지 번호
			) {
		
		

		Image posterImage = null;
		String newChangeName = null;
		
		// 1. 새로운 파일이 업로드된 경우
        if (upfile != null && !upfile.isEmpty()) {
            // Utils.saveFile 함수를 사용하여 파일 저장 및 변경된 파일명(웹 접근 경로 포함) 얻기
            newChangeName = Utils.saveFile(upfile, app, boardCode); // "eventPoster"는 예시
            
            if (newChangeName == null) { // 파일 저장 실패
                ra.addFlashAttribute("msg", "파일 업로드 실패.");
                return "redirect:/app/errorPage"; // 적절한 오류 페이지로
            }
            // Image VO 객체 생성 및 설정
            posterImage = new Image();
            posterImage.setImgType(boardCode); // 이미지 타입 "A"로 고정
            posterImage.setOriginName(upfile.getOriginalFilename());
            posterImage.setChangeName(newChangeName); // Utils에서 반환된 웹 경로+변경명
            posterImage.setImgOrder(1); // 단일 포스터이므로 1로 고정
            posterImage.setImgNo(0);
        } else { // 2. 새로운 파일이 업로드되지 않은 경우
            if (existingImgNo != 0) { // 기존 이미지 번호가 0이 아니면 (기존 이미지가 있었음)
                if (existingImgNo == -1) { // -1은 JSP에서 삭제 요청으로 약속
                	System.out.println("check");
                    posterImage = new Image();
                    posterImage.setImgNo(-1); // 삭제 요청임을 Service에 알림
                } else {
                    // 기존 이미지를 유지하는 경우. posterImage는 null이 될 것입니다.
                    // Service에서 existingImgNo와 eventApplication.getAppId()를 바탕으로
                    // 기존 이미지를 유지하는 로직을 수행할 것입니다.
                }
            }
        }
     // EventApplication 객체에 posterImage 설정
        if (posterImage != null) {
            eventApplication.setPosterImage(posterImage);
        } else {
            // 새로운 파일도 없고, 삭제 요청도 아님 (기존 이미지가 없거나 그대로 유지).
            // Service에서 기존 이미지 정보가 없으면 유지하도록 처리할 것이므로 null로 설정.
            eventApplication.setPosterImage(null);
        }

		//P = 작성중
		if("save".equals(action))
			eventApplication.setStatCode("P");
		//S = 제출 완료
		else
			eventApplication.setStatCode("S");
		log.debug("evApp : {}" , eventApplication);

		int result = appService.saveOrUpdateApplication(eventApplication);
		
		if(result==0) {
			throw new RuntimeException("신청서 작성 실패");
		}
		ra.addFlashAttribute("alertMsg","신청서 작성 성공");
		if("save".equals(action)) {
			return "redirect:/myEventApp/appEdit/" + eventApplication.getAppId();
		}else
			return "redirect:/myEventApp/appEdit/" + eventApplication.getAppId();
	}
}