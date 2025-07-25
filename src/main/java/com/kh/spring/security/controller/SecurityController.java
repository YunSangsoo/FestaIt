package com.kh.spring.security.controller;



import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;


import com.kh.spring.users.model.service.UsersService; // 사용하지 않으면 제거 가능


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/security")
public class SecurityController {
	
	// BCryptPasswordEncoder는 여전히 필요할 수 있습니다 (예: 인증 제공자).
	// 직접적인 암호화 로직이 컨트롤러에서 제거되면 필수는 아닙니다.
	private BCryptPasswordEncoder passwordEncoder; 
	// UsersService는 이 컨트롤러에서 더 이상 직접 사용되지 않습니다.
	private UsersService uService;
	
	public SecurityController(BCryptPasswordEncoder passwordEncoder, UsersService uService) {
		this.passwordEncoder = passwordEncoder;
		this.uService = uService;
	}
	
	@RequestMapping("/accessDenied")
	public String accessDenied(Model model) {
		model.addAttribute("errorMsg","접근불가!!!");
		return "common/errorPage";
	}
	
}