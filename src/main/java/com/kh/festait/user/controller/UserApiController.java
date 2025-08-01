package com.kh.festait.user.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.festait.user.service.UserApiService;
import com.kh.festait.user.service.UserService;

@RestController // JSON으로만 나감
@SessionAttributes({"loginUser"})
public class UserApiController {
	
	@Autowired
	private UserApiService uApiService;

	@Autowired
	private JavaMailSender mailSender;
	
	/* 아이디 중복확인 */
	@RequestMapping(value = "/user/idChecker", method = RequestMethod.POST) 
	public Map<Object, Object> checkId(@RequestParam("userId") String userId) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		int result =  uApiService.idCheck(userId);
		
		map.put("cnt", result);
		return map;
	}
	
	/* 닉네임 중복확인 */
	@RequestMapping(value = "/user/nickChecker", method = RequestMethod.POST)
	public Map<String, Integer> checkNickName(@RequestParam("nickName") String nickName){
		Map<String, Integer> map = new HashMap<>();
		int result = uApiService.nickNameCheck(nickName);
		
		map.put("cnt", result);
		return map;
	}
	
	/* 이메일 인증코드 발송  */
	@RequestMapping(value = "/email/sendCode", method = RequestMethod.POST) 
	public String sendCode(@RequestBody Map<String, String> body, HttpSession session) {
		String email = body.get("email");
		
		String code = String.format("%06d", new Random().nextInt(999999));
		
		session.setAttribute("authCode", code);
		session.setAttribute("authTime", System.currentTimeMillis());
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("Festait이메일 인증번호");
		message.setText("인증번호: "+code+"\n해당 인증번호를 3분내에 입력해주세요!");
		
		try {
			mailSender.send(message);
			return "ok";
		} catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	/* 이메일 인증코드 제한시간  */
	@RequestMapping(value = "/email/verifyCode", method = RequestMethod.POST) 
	 public String verifyCode(@RequestBody Map<String, String> body, HttpSession session) {
		 	String inputCode = body.get("code");
		 	String saveCode = (String) session.getAttribute("authCode");
		 	Long sentTime = (Long) session.getAttribute("authTime");
		 	
		 	if (inputCode == null || saveCode == null || sentTime == null) return "fail";
		 	
		 	long now = System.currentTimeMillis();
		 	long elapsed = (now - sentTime) / 1000; // 초단위
		 	
		 	if (elapsed > 180) return "timeout";
		 	
		 	return inputCode.equals(saveCode) ? "success" : "fail";
	}
	
	
}













