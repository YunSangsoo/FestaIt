package com.kh.festait.app.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/app")
@Slf4j
public class AppController {

	@GetMapping("/appForm")
	public String loginMember() {
		return "app/eventApplicationForm"; // forwarding 될 jsp의 경로
	}
}