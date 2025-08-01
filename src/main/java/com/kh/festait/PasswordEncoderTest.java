package com.kh.festait;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String rawPassword = "manager"; // 예: "test1234"
        String encodedPassword = passwordEncoder.encode(rawPassword);
        System.out.println("인코딩된 비밀번호: " + encodedPassword);
    }
}
