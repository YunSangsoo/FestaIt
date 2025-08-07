package com.kh.festait.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
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

import com.kh.festait.bookmark.model.vo.Bookmark;
import com.kh.festait.reviewboard.model.vo.ReviewBoard;
import com.kh.festait.app.service.AppService;
import com.kh.festait.common.model.vo.Image;
import com.kh.festait.common.service.ImageService;
import com.kh.festait.security.model.vo.UserExt;
import com.kh.festait.user.model.vo.User;
import com.kh.festait.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/user")
@Slf4j
@RequiredArgsConstructor
@Controller
public class UserController {

	@Autowired
	private final UserService uService;

	@Autowired
	private final ImageService imageService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// GET
	// 회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinPage() {
		return "/join";
	}

	// 로그인 페이지 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginuser() {
		return "user/login";
	}

	// 로그아웃 처리 및 메인페이지 이동
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, SessionStatus status) {
		session.invalidate();
		status.setComplete();

		return "/main";
	}

	// 마이페이지 이동
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public ModelAndView myPage(@AuthenticationPrincipal UserExt userDetails, Authentication auth, Model model) {
		User u = (User) auth.getPrincipal();
		//프로필 이미지 설정
		Image img = imageService.getImageByRefNoAndType(u.getUserNo(), "U");
		u.setProfileImage(img);
		//유저 유형 가져오기
		boolean isManager = u.getCompId() != null;
		
		// 북마크 리스트 가져오기
		Map<String, Object> param = new HashMap<>();
		param.put("userNo", u.getUserNo());
		List<Bookmark> bookmarkList = uService.selectBookmarkList(param);
		model.addAttribute("bookmarkList", bookmarkList);
		// 리뷰 리스트 가져오기
		List<ReviewBoard> reviewList = uService.selectReviewList(param);
		model.addAttribute("reviewList", reviewList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("userInfo", u);
		mv.setViewName("/user/myPage");
		mv.addObject("isManager",isManager);
		return mv;
	}

	// 아이디 비번찾기창 이동
	@RequestMapping(value = "/Idpw", method = RequestMethod.GET)
	public String Idpw() {
		System.out.println("check");
		return "user/Idpw";
	}

	// 아이디찾기 컨트롤러
	// 이거 유저 api컨트롤러로 옮겨야함
	@RequestMapping(value = "/findIdEmail", method = RequestMethod.GET)
	@ResponseBody
	public String findIdEmail(@RequestParam("email") String email,
							  @RequestParam("name") String name) {

		String userId = uService.findUserIdEmail(email, name);
		System.out.println("userId : " + userId);

		if (userId != null) {
			return userId;
		} else {
			return "해당 메일로 가입된 아이디가 없습니다";
		}

	}

	// 비밀번호 변경페이지로 이동
	@RequestMapping(value = "/newPw", method = RequestMethod.GET)
	public String newPW() {
		return "user/newPw";
	}

	// 닉,비밀번호 변경페이지로 이동
	@RequestMapping(value = "/mypage_nickPw", method = RequestMethod.GET)
	public String mypage_nickPw() {
		return "user/mypage_nickPw";
	}

	/*********** POST MAPPING *////////
	// 회원 가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String insertUser(User m, Model model, RedirectAttributes ra) {

		System.out.println("m : " + model.toString());
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

	// 로그인
	@PostMapping("/login")
	public ModelAndView loginUser(User u, ModelAndView mv, Model model, HttpSession session, // 로그인 성공시, 사용자 정보를 보관할 객체
			RedirectAttributes ra) {
		System.out.println("check");
		User loginUser = uService.login(u);
		log.info("user : {}", loginUser);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			System.out.println("세션에 있는 아이디" + session.getAttribute("loginUser")); // 테스트용
			ra.addFlashAttribute("alertMsg", "로그인 성공.");
		} else {
			ra.addFlashAttribute("alertMsg", "로그인 실패.");
		}
		mv.setViewName("redirect:/");
		return mv;
	}

	// 회원탈퇴
	@RequestMapping(value = "/updateUserSecession", method = RequestMethod.POST)
	public String secessionUser(Authentication auth, HttpSession session) {
		User u = ((User) auth.getPrincipal());
		int succesYn = uService.updateUser(u);

		if (succesYn > 0) {
			session.invalidate();
		}
		return "redirect:/user/logout";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String resetPassword(@RequestParam("userId") String userId, @RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword, RedirectAttributes redirectAttributes) {

		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/user/Idpw";
		}

		System.out.println("업데이트 결과: " + userId + " " + newPassword); // 테스트용
		String encodedPwd = passwordEncoder.encode(newPassword);
		int result = uService.updatePasswordByEmail(userId, encodedPwd);
		System.out.println("업데이트 결과: " + result); // 테스트용

		if (result > 0) { // 성공시
			log.info("result : {}", result);
			redirectAttributes.addFlashAttribute("alertMsg", "비밀번호가 변경되었습니다");
			return "redirect:/user/login";

		} else { // 실패시
			redirectAttributes.addFlashAttribute("alertMsg", "비밀번호 변경에 실패했습니다.");
			return "redirect:/user/Idpw";
		}
	}

	// 닉네임변경
	@ResponseBody
	@RequestMapping(value = "/updateNick", method = RequestMethod.POST)
	public String updateNickname(@RequestParam("nickname") String nickname, Authentication auth,
			@AuthenticationPrincipal UserExt userDetails) {

		System.out.println("호출완료");
		String userId = ((User) auth.getPrincipal()).getUserId(); // 이런식으로 가져와야함
		// String userId = userDetails.getUsername();
		System.out.println("userId = " + userId + ", nickname = " + nickname);

		int result = uService.updateNick(userId, nickname);
		System.out.println("update result = " + result);

		return result > 0 ? "success" : "fail";
	}

	// 비번 변경
	@ResponseBody
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword(@RequestParam("newPassword") String newPassword, Authentication auth,
			@AuthenticationPrincipal UserExt userDetails) {

		System.out.println("새 비밀번호 (평문) = " + newPassword);

		String encodedPwd = passwordEncoder.encode(newPassword);
		System.out.println("암호화된 비밀번호 =" + encodedPwd);

		String userId = ((User) auth.getPrincipal()).getUserId();
		log.info("user before : {}", ((User) auth.getPrincipal()).getUserPwd());
		log.info("user : {}", encodedPwd);
		int result = uService.updatePassword(userId, encodedPwd);
		log.info("user : {}", userId);
		log.info("user : {}", encodedPwd);
		return result > 0 ? "success" : "fail";
	}

	// 파일 업로드
	@ResponseBody
	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public String uploadProfile(@RequestParam("profileImage") MultipartFile file,
			// @AuthenticationPrincipal UserExt userDetails,
			Authentication auth, HttpSession session) {

		System.out.println("contrer====================");
		if (file.isEmpty()) {
			return "fail";
		}
		int userNo = ((User) auth.getPrincipal()).getUserNo(); // 이런식으로 가져와야함
		Image result = uService.uploadProfile(file, userNo);

		((User) auth.getPrincipal()).setProfileImage(result);
		// userDetails.setProfileImg(result);
		session.setAttribute("loginUser", (User) auth.getPrincipal());

		return "success";
	}

	// 파일 가져오기

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String showMyPage(Model model, Authentication auth, @AuthenticationPrincipal UserExt userDetails) {

		String profileImageUrl = userDetails.getProfileImg();

		if (profileImageUrl != null || profileImageUrl.isEmpty()) {
			profileImageUrl = "/resources/img/U/default.jpg";
		}
		model.addAttribute("profileImageUrl", profileImageUrl);

		return "user/mypage";
	}

}
