package com.kh.spring.security.model.service;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface SecurityService extends UserDetailsService {
    // UserDetailsService의 loadUserByUsername 메서드를 상속받아 사용
}