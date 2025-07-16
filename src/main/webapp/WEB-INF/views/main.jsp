<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>프로젝트 메인페이지</title>
</head>
<body>
	
	<h1>Hello world!</h1>
	<P>The time on the server is ${serverTime}.</P>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
