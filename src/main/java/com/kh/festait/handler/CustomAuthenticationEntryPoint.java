package com.kh.festait.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        String errorMessage = "로그인이 필요한 기능입니다.";
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (isAjax) {
            // Ajax 요청이면 JSON으로 401 응답
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized

            Map<String, String> data = new HashMap<>();
            data.put("message", errorMessage);

            objectMapper.writeValue(response.getWriter(), data);
        } else {
            // 일반 웹 요청이면 로그인 페이지로 리다이렉트
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/user/login");
        }
    }
}