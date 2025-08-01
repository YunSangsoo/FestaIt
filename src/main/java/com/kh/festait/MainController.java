package com.kh.festait;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.festait.mainpage.controller.MainpageController;

@Controller
public class MainController {
	
	@Autowired
    private MainpageController mainpageController;
	
	@GetMapping("/")
	public String home(Model model, Authentication authentication) {
		mainpageController.mainpageLoading(model, authentication);
		return "main";
	}
	
	@GetMapping("/board")
	public String homeBoard() {
		return "/board/boardListView";
	}
	
	@GetMapping("/review")
	public String review() {
		return "/review/reviewBoard";
	}
	
	@GetMapping("/review/list")
	public String reviewList() {
		return "/review/reviewList";
	}

	@GetMapping("/common")
	public String homTest() {
		return "/common/footer";
	}
	
	@GetMapping("/intro")
	public String intro() {
		return "intro/intro";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/user/join";
	}
}


