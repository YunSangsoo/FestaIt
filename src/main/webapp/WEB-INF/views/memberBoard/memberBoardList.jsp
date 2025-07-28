<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<title>회원 목록 - 관리자</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
a.btn.lavender-btn, button.lavender-btn {
	background-color: #b481d9;
	color: white;
	border: 1px solid #a069cb;
	padding: 5px 10px;
	border-radius: 3px;
	font-size: 0.9em;
}

a.btn.lavender-btn:hover, button.lavender-btn:hover {
	background-color: #a069cb;
	border-color: #904ebc;
	color: white;
}

thead.lavender-header th {
	background-color: #e6ccff;
	color: #5E2B97;
	cursor: pointer;
	padding: 10px 5px;
}

/* 테이블 스타일 Bootstrap 기반으로 깔끔하게 */
table {
	width: 100%;
}

/* 호버 시 배경색 */
tbody tr:hover {
	background-color: #f4e6ff;
}

/* 검색폼 아래 간격 조정 */
.search-form {
	margin-bottom: 20px;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container my-5" style="min-height: 600px;">
		<h2 class="fw-bold mb-4">회원 정보 목록</h2>

		<form method="get"
			action="${pageContext.request.contextPath}/memberBoard"
			class="search-form d-flex justify-content-end align-items-center">
			<input type="text" name="keyword" placeholder="아이디, 닉네임 검색"
				value="${param.keyword}" class="form-control me-2"
				style="max-width: 250px;" />
			<button type="submit" class="btn lavender-btn">검색</button>
		</form>

		<table class="table table-hover text-center align-middle">
			<thead class="lavender-header">
				<tr>
					<th>회원번호</th>
					<th>회원구분</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>가입일</th>
					<th>회원삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${userList}">
					<tr style="cursor: pointer;"
						onclick="location.href='${pageContext.request.contextPath}/memberBoard/detail?userNo=${user.userNo}'">
						<td>${user.userNo}</td>
						<td><c:choose>
								<c:when test="${user.userType eq 'ROLE_ADMIN'}">관리자</c:when>
								<c:when test="${user.userType eq 'ROLE_USER'}">일반회원</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose></td>
						<td>${user.userId}</td>
						<td>${user.nickname}</td>
						<td><fmt:formatDate value="${user.enrollDate}"
								pattern="yyyy-MM-dd" /></td>
						<td>
							<form
								action="${pageContext.request.contextPath}/memberBoard/deleteUser"
								method="post" style="margin: 0;">
								<input type="hidden" name="userNo" value="${user.userNo}" />
								<button type="submit" class="lavender-btn"
									onclick="event.stopPropagation(); return confirm('정말 삭제하시겠습니까?');">삭제</button>
							</form>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty userList}">
					<tr>
						<td colspan="6">조회된 회원이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/memberBoard?page=${currentPage - 1}&keyword=${keyword}">
								이전 </a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">이전</span></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<li class="page-item active"><span class="page-link">${i}</span></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/memberBoard?page=${i}&keyword=${keyword}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${currentPage < totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/memberBoard?page=${currentPage + 1}&keyword=${keyword}">
								다음 </a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">다음</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
