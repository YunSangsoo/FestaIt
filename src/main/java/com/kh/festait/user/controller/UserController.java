package com.kh.festait.user.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.security.model.vo.UserExt;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private UserService uService;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	
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
	public ModelAndView myPage(@AuthenticationPrincipal UserExt userDetails,
			Authentication auth
			) {
		
		User u = (User)auth.getPrincipal();
		log.info("user detail : {}",u);
		
		ModelAndView mv = new ModelAndView();
		
		/*String userId = userDetails.getUsername();
		
		User u = uService.myPageUserInfo(userId);
		System.out.println("u : "+u.toString());*/
		
		mv.addObject("userInfo", u);
		mv.setViewName("/user/myPage");
		return mv;
	}
	
	
	//아이디 비번찾기창 이동
	@RequestMapping(value = "/Idpw", method = RequestMethod.GET)
	public String Idpw() {
		System.out.println("check");
		return "user/Idpw";
	}
	//아이디찾기 컨트롤러
	//이거 유저 api컨트롤러로 옮겨야함
	@RequestMapping(value = "/findIdEmail", method = RequestMethod.GET)
	@ResponseBody
	public String findIdEmail(@RequestParam("email") String email) {
		
		String userId = uService.findUserIdEmail(email);
	    System.out.println("userId : " + userId);

		if (userId != null) {
			return userId;
		}else {
			return "해당 메일로 가입된 아이디가 없습니다";
		}
		
	}
	//비밀번호 변경페이지로 이동
	@RequestMapping(value = "/newPw", method = RequestMethod.GET)
	public String newPW() {
		return "user/newPw";
	}
	
	//닉,비밀번호 변경페이지로 이동
	@RequestMapping(value = "/mypage_nickPw", method = RequestMethod.GET)
	public String mypage_nickPw() {
		return "user/mypage_nickPw";
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
	
	//로그인
	@PostMapping("/login")
	public ModelAndView loginUser(User u, ModelAndView mv, Model model, 
			HttpSession session, // 로그인 성공시, 사용자 정보를 보관할 객체
			RedirectAttributes ra) {
		System.out.println("check");
		User loginUser = uService.login(u);
		log.info("user : {}",loginUser);
		if(loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			System.out.println("세션에 있는 아이디" + session.getAttribute("loginUser")); //테스트용
			ra.addFlashAttribute("alertMsg", "로그인 성공.");
		}else {
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
	//비밀번호 찾기
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String resetPassword(
			@RequestParam("email") String email,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			RedirectAttributes redirectAttributes) {
			
		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("alertMsg","비밀번호가 일치하지 않습니다.");
			return "redirect:/user/Idpw";
		}

	    System.out.println("업데이트 결과: " + email + " " + newPassword); // 테스트용
	    String encodedPwd = passwordEncoder.encode(newPassword);
		int result = uService.updatePasswordByEmail(email, encodedPwd);
	    System.out.println("업데이트 결과: " + result); // 테스트용
	    
		if (result > 0) { // 성공시
			log.info("result : {}",result);
			redirectAttributes.addFlashAttribute("alertMsg","비밀번호가 변경되었습니다");
			return "redirect:/user/login";

		} else { // 실패시
			redirectAttributes.addFlashAttribute("alertMsg","비밀번호 변경에 실패했습니다.");
	        return "redirect:/user/Idpw";
		}
	}
	
	// 닉네임변경
	@ResponseBody
	@RequestMapping(value = "/updateNick", method = RequestMethod.POST)
	public String updateNickname(@RequestParam("nickname") String nickname,
								Authentication auth,
								 @AuthenticationPrincipal UserExt userDetails) {
		
		System.out.println("호출완료");
		String userId = ((User)auth.getPrincipal()).getUserId(); // 이런식으로 가져와야함
		//String userId = userDetails.getUsername();
	    System.out.println("userId = " + userId + ", nickname = " + nickname);

		int result =uService.updateNick(userId, nickname);
	    System.out.println("update result = " + result);

		return result > 0 ? "success":"fail";
	}
	//비번 변경
	@ResponseBody
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword(
			@RequestParam("newPassword")String newPassword,
			Authentication auth,
			@AuthenticationPrincipal UserExt userDetails) {
		
		System.out.println("새 비밀번호 (평문) = " + newPassword);
		
	    String encodedPwd = passwordEncoder.encode(newPassword);
	    System.out.println("암호화된 비밀번호 ="+ encodedPwd);
	    
		String userId = ((User)auth.getPrincipal()).getUserId();
		log.info("user before : {}",((User)auth.getPrincipal()).getUserPwd());
		log.info("user : {}",encodedPwd);
		int result = uService.updatePassword(userId, encodedPwd);
		log.info("user : {}",userId);
		log.info("user : {}",encodedPwd);
		return result > 0 ? "success" : "fail";
 	}
	@ResponseBody
	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public String uploadProfile(@RequestParam("profileImage") MultipartFile file,
			HttpSession session) {
			if (file.isEmpty()) {
				return "fail";
			}
			try {
				String uploadDir = "C:/"; // 저장경로
				String originalFilename = file.getOriginalFilename();
				
				String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFilename;
				
				File savaFile = new File(uploadDir + uniqueFileName);
				file.transferTo(saveFile);
				
				String userId = (String) session.getAttribute("loginUserId");
				
				return "success";
				} catch (Exception e) {
					e.printStackTrace();
					return "fail";
				}
	}
	
}






