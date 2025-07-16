package com.kh.festait;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String home() {
		return "main";
	}

	@GetMapping("/common")
	public String homTest() {
		return "/common/footer";
	}
	
}