package com.kh.festait.user.model.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.kh.festait.user.model.vo.User;

public class Uservalidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		//유효성 검사를 수행할 클래스를 지정하는 메서드
		
		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {

		//유효성 검사 메서드
		User user = (User) target;
		
		//유효성 검사 로직
		/*
		if(user.getUserId() != null) {
			if(user.getUserId().length() < 4 || user.getUserId().length() > 20) {
				errors.rejectValue("userId","length" ,"아이디는 4~20자 이내여야 합니다.");
			}
			
			if(!user.getUserId().matches("^[a-zA-z0-9_]+$")) {
				errors.rejectValue("userId","pattern" ,"아이디는 영문, 숫자, _만 사용 가능합니다.");
			}
		}*/
	}

}
