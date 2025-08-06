package com.kh.festait.handler;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	

    private final ObjectMapper objectMapper = new ObjectMapper();
	
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
    	// 실패 사유에 따라 메시지 설정
        String errorMessage = "알 수 없는 이유로 로그인에 실패했습니다.";
        String errorCode = "UNKNOWN";

        if (exception instanceof BadCredentialsException) {
            errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
            errorCode = "BAD_CREDENTIALS";
        } else if (exception instanceof CredentialsExpiredException) {
            errorMessage = "비밀번호 유효기간이 만료되었습니다.";
            errorCode = "CREDENTIALS_EXPIRED";
        }
        // 그 외 여러 예외 클래스를 추가할 수 있습니다. (e.g., DisabledException, LockedException 등)

    	// Ajax 요청 여부 확인
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if (isAjax) {
            // Ajax 요청이면 JSON으로 응답
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
            
            Map<String, String> data = new HashMap<>();
            data.put("message", errorMessage);
            data.put("errorCode", errorCode);
            data.put("targetUrl", "/user/login");
            
            objectMapper.writeValue(response.getWriter(), data);
        } else {

			// 일반 웹 요청일 경우, 모달을 띄우는 JavaScript를 포함한 페이지로 리다이렉트
			// 이 방법이 fetch를 사용하는 것보다 훨씬 안정적입니다.
			// 경고 메시지를 URL 파라미터에 담아 보냅니다.
			String redirectUrl = request.getContextPath() + "/denied?message=" + URLEncoder.encode(errorMessage, "UTF-8");
			response.sendRedirect(redirectUrl);
        }
    }
}
