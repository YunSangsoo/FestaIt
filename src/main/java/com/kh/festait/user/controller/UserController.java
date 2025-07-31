package com.kh.festait.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private UserService uService;
	
	//GET
	//회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinPage() {
		return "/join";
	}
	
	//로그인 페이지 이동  
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginuser() {
		return "user/login";
	}
	
	//로그아웃 처리 및 메인페이지 이동 
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, SessionStatus status) {
		session.invalidate(); 
		status.setComplete();
		
		return "/main";
	}
	
	//마이페이지 이동
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		User loginUserInfo = (User) session.getAttribute("loginUser");
		
		String userId = loginUserInfo.getUserId();
		
		User u = uService.myPageUserInfo(userId);
		System.out.println("u : "+u.toString());
		mv.addObject("userInfo", u);
		mv.setViewName("/user/myPage");
		return mv;
	}
	
	/*********** POST MAPPING *////////
	//회원 가입 
	@RequestMapping(value = "/join", method = RequestMethod.POST) 
	public String insertUser(User m, Model model,RedirectAttributes ra) {
		
		System.out.println("m : "+model.toString());
		int result = uService.insertUser(m);
		String viewName = "";
		
		if (result > 0) {
			ra.addFlashAttribute("alertMsg", "회원가입 성공.");
			viewName = "redirect:/";
		} else {
			model.addAttribute("errorMsg", "회원가입 실패.s");
			viewName = "/join";
		}
		
		return viewName;
	}
	
	@PostMapping("/login")
	public ModelAndView loginUser(User u, ModelAndView mv, Model model, 
	        HttpSession session, // 로그인 성공시, 사용자 정보를 보관할 객체
	        RedirectAttributes ra) {
	    System.out.println("check");
	    User loginUser = uService.login(u);
	    log.info("user : {}",loginUser);
	    if (loginUser != null) {
	        // 세션에 로그인 사용자 정보를 저장해야 이후 요청에서도 꺼낼 수 있어요!
	        session.setAttribute("loginUser", loginUser);

	        model.addAttribute("loginUser", loginUser); // 이건 없어도 됨, 세션이 더 중요
	        ra.addFlashAttribute("alertMsg", "로그인 성공.");
	    } else {
	        ra.addFlashAttribute("alertMsg", "로그인 실패.");
	    }
	    mv.setViewName("redirect:/");
	    return mv;
	}
	/*
	//회원 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST) 
	public ModelAndView loginUser(User u, ModelAndView mv ,Model model, HttpServletRequest request, HttpSession session) {

		System.out.println("check1");
		ModelAndView mav = new ModelAndView();
		User userInfo = new User();

		Map<String,String> loginMap = uService.loginUser(u);
		System.out.println("map : "+loginMap.toString());
		
		String succesYn = loginMap.get("SUCCES_YN");

		System.out.println("check2");
		if ("Y".equals(succesYn)) {
		   userInfo.setRole(loginMap.get("USER_ROLE"));
		   userInfo.setUserName(loginMap.get("USER_NAME"));
		   userInfo.setUserId(loginMap.get("USER_ID"));
		   userInfo.setEnrollDate(loginMap.get("USER_ID"));
//		   userInfo.setPhone(loginMap.get("PHONE"));
//		   userInfo.setAddr(loginMap.get("ADDR"));
//		   userInfo.setEmail(loginMap.get("EMAIL"));
		   
//		   userInfo.setUserNo(loginMap.get("USER_NO"))
//		   userInfo.setUserNo("N");
		   //session.setAttribute("loginUser", userInfo);
		   
		   model.addAttribute("loginUser",userInfo);
		   mav.setViewName("redirect:/");
		} else {
		   mav.addObject("loginSuccesYn", succesYn);
		   //해당 회원이 없습니다. alert띄워야함
		   mav.setViewName("/user/login");
		}
		
//		session.setAttribute(succesYn, mav)
//		session.setAttribute("loginUserRole", "");
		return mav;
	}
		*/
	
	
	
	//마이페이지 수정 
	@RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
	public String updateUserInfo(User u) {
		
		int succesYn = uService.updateUser(u);
		if (u.getProfileName() != null || u.getProfileName() != "") {
			
		}
		return "/user/myPage";
	}
	
	//회원탈퇴
	@RequestMapping(value = "/updateUserSecession", method = RequestMethod.POST)
	public String secessionUser(User u) {
		int succesYn = uService.updateUser(u);
		return "/main";
	}
	
	
}

