package com.kh.festait.handler;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	
	private final ObjectMapper objectMapper = new ObjectMapper();
	
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException exception) throws IOException, ServletException {
        // Ajax 요청 여부 확인
    	String errorMessage = "해당 페이지에 접근할 권한이 없습니다.";
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (isAjax) {
            // Ajax 요청이면 JSON으로 응답
        	log.info("response : {}",response);
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403 Forbidden
            response.getWriter().write("{\"message\":\"" + errorMessage + "\"}");
        } else {
			// 일반 웹 요청일 경우, 모달을 띄우는 JavaScript를 포함한 페이지로 리다이렉트
			// 이 방법이 fetch를 사용하는 것보다 훨씬 안정적입니다.
			// 경고 메시지를 URL 파라미터에 담아 보냅니다.
        	String contextPath = request.getContextPath();
        	String encodedErrorMessage = URLEncoder.encode(errorMessage, "UTF-8");
			String redirectUrl = contextPath +"/denied?message=" + encodedErrorMessage;
			response.sendRedirect(redirectUrl);
        }
    }
}