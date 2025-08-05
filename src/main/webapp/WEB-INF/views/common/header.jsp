<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* 기존 스타일 유지 */
.navbar {
	background-color: #6A1B9A;
	padding-top: 12px;
	padding-bottom: 12px;
}
.navbar-brand {
	font-size: 24px;
	font-weight: bold;
	color: white !important;
}
.nav-link {
	font-size: 18px;
	color: white !important;
}
.nav-link.active {
	color: #FFD700 !important;
	font-weight: bold;
}
.btn {
	font-size: 16px;
	padding: 8px 20px;
}
.navbar-nav .nav-item {
    margin: 0 20px; /* 좌우 여백 */
}
.navbar-nav {
	display: flex;
	align-items: center;
}
.navbar-nav .nav-link {
	font-size: 18px;
	color: white !important;
	padding: 0 8px; /* 메뉴 사이 간격 */
}
.navbar-nav .separator {
	color: white;
	font-size: 18px;
	padding: 0 4px;
	user-select: none;
}
/*마우스오버*/
.navbar-nav .nav-link {
  font-size: 18px;
  color: white !important;
  padding: 0 8px;
  transition: color 0.2s ease-in-out;
}
.navbar-nav .nav-link:hover {
  color: #FFD700 !important;
}
</style>
</head>
<body>
<!-- 헤더 시작 -->
<nav class="navbar navbar-expand-lg navbar-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="/festait">Festa-it</a>
		<button class="navbar-toggler" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarNav"
			aria-controls="navbarNav" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-between" id="navbarNav">
			<!-- 가운데: 메뉴 -->
			<ul class="navbar-nav mx-auto flex-row align-items-center">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/eventBoard/list">행사</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/promoBoard">홍보</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/noticeBoard">공지</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/qnaBoard">QNA</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reviewBoard">리뷰</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/memberBoard">회원</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_USER') and !hasRole('ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/eventBoard/list">행사</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/promoBoard">홍보</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/noticeBoard">공지</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/qnaBoard">QNA</a></li>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/eventBoard/list">행사</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/promoBoard">홍보</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/noticeBoard">공지</a></li>
					<li class="nav-item separator">|</li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/qnaBoard">QNA</a></li>
				</sec:authorize>
			</ul>
			<!-- 로그인/회원가입 or 마이페이지 -->
			<div class="d-flex align-items-center gap-2">
				<sec:authorize access="isAuthenticated()">
					   
					   <form:form class="me-2" action="${pageContext.request.contextPath}/user/logout" method="post" id="logoutForm">
							<a href="${pageContext.request.contextPath}/user/myPage" class="btn btn-outline-light me-2">
							   ${pageContext.request.userPrincipal.name}님 마이페이지</a>
						    <button type="submit" class="btn btn-warning">로그아웃</button>
						</form:form>
						
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<a href="/festait/user/login" class="btn btn-outline-light">로그인</a>
					<a href="/festait/security/join" class="btn btn-warning">회원가입</a>
				</sec:authorize>
			</div>
		</div>
	</div>
</nav>
</body>
</html>