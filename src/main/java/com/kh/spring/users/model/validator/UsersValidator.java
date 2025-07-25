package com.kh.spring.users.model.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.kh.spring.users.model.vo.UsersVo;

public class UsersValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// 유효성 검사를 수행할 클래스를 지정하는 메서드
		return UsersVo.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// 유효성 검사 메서드
		UsersVo users = (UsersVo) target;

		// 유효성 검사 로직
		if(users.getUserId() != null) {
			if(users.getUserId().length() < 4 || users.getUserId().length() > 20) {
				errors.rejectValue("userId", "length", "아이디는 4~20자 이내여야 합니다.");
			}
		}
		if (!users.getUserId().matches("^[a-zA-Z0-9_]+$")) {
			errors.rejectValue("userId", "pattern","아이디는 영문, 숫자, _만 사용가능합니다.");
		}
	}
}
