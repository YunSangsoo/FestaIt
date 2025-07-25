<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .login-container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); width: 300px; text-align: center; }
    .login-container h2 { margin-bottom: 20px; color: #333; }
    .login-container input[type="text"],
    .login-container input[type="password"] { width: calc(100% - 20px); padding: 10px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
    .login-container button { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
    .login-container button:hover { background-color: #0056b3; }
    .error-message { color: red; margin-top: 10px; }
    .logout-message { color: green; margin-top: 10px; }
</style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        
        <%-- 로그인 실패 메시지 (error=true 파라미터가 있을 경우) --%>
        <c:if test="${param.error eq 'true'}">
            <div class="error-message">아이디 또는 비밀번호가 잘못되었습니다.</div>
        </c:if>
        
        <%-- 로그아웃 성공 메시지 (logout=true 파라미터가 있을 경우) --%>
        <c:if test="${param.logout eq 'true'}">
            <div class="logout-message">성공적으로 로그아웃되었습니다.</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/users/loginProcess" method="post">
            <input type="text" name="userId" placeholder="아이디" required>
            <input type="password" name="userPwd" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
        
        <p style="margin-top: 20px;">
            계정이 없으신가요? <a href="${pageContext.request.contextPath}/security/insert">회원가입</a>
        </p>
    </div>
</body>
</html>