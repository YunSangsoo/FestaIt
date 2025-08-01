package com.kh.festait.security.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.user.model.validator.Uservalidator;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.model.vo.User2;
import com.kh.festait.user.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/security")
public class SecurityController {
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private UserService uService;

	
	//에러페이지 포워딩용 url
	@RequestMapping("/accessDenied")
	public String accessDenied(Model model) {
		model.addAttribute("errorMsg","접근불가!!!");
		return "common/errorPage";
	}
	
	//회원가입 페이지 이동
	@GetMapping("join")
	public String joinPage(Model model) {
		User m = new User();
		m.setManager(new User2());
		model.addAttribute("joinUser",m);
		return "user/join";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.addValidators(new Uservalidator());
		
		//추가해야할 바인딩 형태 추가
		
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
	@PostMapping("join")
	public String insertUser(
			@Validated @ModelAttribute("joinUser") User m,
			BindingResult bindingResult,
			RedirectAttributes ra) {
		
		

		//유효성 검사
		if(bindingResult.hasErrors()) {
			return "user/join";
		}
		

		log.info("user: {} ",m);
		
		//유효성 검사 통과시 비밀번호 정보는 암호화하여, 회원가입 진행
		String encryptedPassword = passwordEncoder.encode(m.getUserPwd());
		m.setUserPwd(encryptedPassword);

		int result = uService.insertUser(m);
		
		return "redirect:/user/login";
	}
	
	/*
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
	*/
	
	
}
