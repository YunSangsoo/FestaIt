package com.kh.festait.user.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.service.UserService;

@Controller
@RequestMapping("/user")
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
		return "/login";
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
	
	
	//회원 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST) 
	public ModelAndView loginUser(User u, Model model, HttpServletRequest request, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		User userInfo = new User();

		Map<String,String> loginMap = uService.loginUser(u);
		System.out.println("map : "+loginMap.toString());
		
		String succesYn = loginMap.get("SUCCES_YN");
	
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
		   session.setAttribute("loginUser", userInfo);
		   mav.setViewName("/main");
		} else {
		   mav.addObject("loginSuccesYn", succesYn);
		   //해당 회원이 없습니다. alert띄워야함
		   mav.setViewName("/user/login");
		}
		
		
//		session.setAttribute(succesYn, mav)
//		session.setAttribute("loginUserRole", "");
		return mav;
	}
	
	
	
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

