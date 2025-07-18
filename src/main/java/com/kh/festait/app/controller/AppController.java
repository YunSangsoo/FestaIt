package com.kh.festait.app.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.app.model.vo.EventApplication;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/app")
@Slf4j
public class AppController {

	@GetMapping("/appForm")
	public String loginMember(@ModelAttribute("eventApplication") EventApplication eventApplication, Model model) {
		model.addAttribute("eventApplication", eventApplication);
		return "app/eventApplicationForm"; // forwarding 될 jsp의 경로
	}
	
	@PostMapping("/appForm")
	public String applyingForm(@ModelAttribute("eventApplication") /*@Valid*/  EventApplication eventApplication,
			//BindingResult bindingResult, 유효성 결과
			Model model,
			//Authentication auth,
			RedirectAttributes ra
			) {
		/*
		if (bindingResult.hasErrors()) {
            System.out.println("폼 유효성 검사 실패!");
            // 실패 시 폼 페이지로 다시 돌아가기 (이때 Model의 postVO 객체에 기존 입력값과 에러가 담겨 있음)
            return "app/eventApplicationForm"; 
        }*/
		
		log.debug("evApp : {}" , eventApplication);
		
		
		return "app/eventApplicationForm";
	}
}