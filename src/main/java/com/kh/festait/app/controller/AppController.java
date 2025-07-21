package com.kh.festait.app.controller;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.app.model.vo.EventApplication;
import com.kh.festait.app.service.AppService;
import com.kh.festait.common.Utils;
import com.kh.festait.common.model.vo.Image;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/app")
@RequiredArgsConstructor
@Slf4j
public class AppController {
	
	private final AppService appService;
	private final ServletContext app;

	@GetMapping("/appForm")
	public String loginMember(@ModelAttribute("eventApplication") EventApplication eventApplication, Model model) {
		model.addAttribute("eventApplication", eventApplication);
		return "app/eventApplicationForm"; // forwarding 될 jsp의 경로
	}
	
	@PostMapping("/appForm")
	public String applyingForm(
			@ModelAttribute("eventApplication") /*@Valid*/  EventApplication eventApplication,
			//BindingResult bindingResult, 유효성 결과
			Model model,
			//Authentication auth,
			RedirectAttributes ra,
			@RequestParam(value="inputPoster",required=false) List<MultipartFile> upfiles
			) {
		/*
		if (bindingResult.hasErrors()) {
            System.out.println("폼 유효성 검사 실패!");
            // 실패 시 폼 페이지로 다시 돌아가기 (이때 Model의 postVO 객체에 기존 입력값과 에러가 담겨 있음)
            return "app/eventApplicationForm"; 
        }*/
		
		log.debug("evApp : {}" , eventApplication);
		

		//첨부파일 존재여부 체크
		List<Image> imgList = new ArrayList<>();
		int level = 0; // 첨부파일의 레벨
		// level = 0 -> 썸네일, 가장 첫번째 사진, 0이 아닌 값들은 썸네일이 아닌 기타 파일들
		for(MultipartFile upfile : upfiles) {
			if(upfile.isEmpty()) {
				continue;
			}
			//첨부파일이 존재한다면 WEB서버상에 첨부파일 저장
			//첨부파일 관리를 위해 DB에 첨부파일의 위치정보를 저장
			String changeName = Utils.saveFile(upfile,app,"A");
			Image img = new Image();
			img.setChangeName(changeName);
			img.setOriginName(upfile.getOriginalFilename());
			img.setImgOrder(level++);
			imgList.add(img); // 연관 게시글 번호 refBno값 추가 필요
		}
		
		/*Member loginUser = (Member)auth.getPrincipal();
		b.setBoardWriter(String.valueOf(loginUser.getUserNo()));*/
		
		//S = 제출 완료
		eventApplication.setStatCode("S");

		int result = appService.insertApplication(eventApplication, imgList);
		
		// 게시글 등록 결과에 따른 페이지 지정
		if(result==0) {
			throw new RuntimeException("게시글 작성 실패");
		}
		
		ra.addFlashAttribute("alertMsg","게시글 작성 성공");
		
		return "app/eventApplicationForm";
	}
}