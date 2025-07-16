<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${contextPath }/resources/css/chat-style.css" rel="stylesheet">
<link href="${contextPath }/resources/css/main-style.css" rel="stylesheet">
<style>
	<!-- '행사' 관련 JSP 파일 -->
</style>
</head>
<body>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include> --%>

<h1>${event.title}</h1>
<p>장소: ${event.location}</p>
<p>홈페이지: <a href="${event.homepage}" target="_blank">바로가기</a></p>
<p>분류: ${event.category}</p>
<img src="/images/${event.imagePath}" alt="포스터" style="width:300px;">
<p>${event.content}</p>

<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include> --%>
</body>
</html>