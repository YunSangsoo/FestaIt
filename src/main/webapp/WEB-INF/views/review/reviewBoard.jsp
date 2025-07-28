<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
#searchForm {
	width: 70%;
}

/* 공지 작성 버튼 스타일 */
a.btn.lavender-btn {
	background-color: #B481D9;
	color: white;
	border: 1px solid #A069CB;
}

a.btn.lavender-btn:hover {
	background-color: #A069CB;
	border-color: #904EBC;
}
/* 테이블 헤더 스타일 */
thead.lavender-header th {
	background-color: #E6CCFF;
	color: #5E2B97;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container my-5" style="min-height: 600px;">

		<div class="d-flex justify-content-between align-items-center mb-3"
			style="vertical-align: bottom;">
			<h2 class="fw-bold"><a href="review/list">리뷰 관리</a></h2>
			<p>총 ** 건</p>
		</div>
		
		<table class="table table-hover text-center align-middle">
			<thead class="lavender-header">
				<tr>
					<th style="width: 12%;">성명</th>
					<th style="width: 12%;">아이디</th>
					<th style="width: 12%;">닉네임</th>
					<th>내용</th>
					<th style="width: 12%;">작성일▼</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty noticeList}">
						<c:forEach var="notice" items="${noticeList}">
							<tr>
								<td>${notice.noticeId}</td>
								<td class="text-start"><a
									href="${pageContext.request.contextPath}/noticeBoard/detail?id=${notice.noticeId}"
									class="text-decoration-none text-dark"
									class="text-decoration-none text-dark">
										${notice.noticeTitle} </a></td>
								<td><fmt:formatDate value="${notice.createDate}"
										pattern="yyyy.MM.dd HH:mm" /></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">등록된 리뷰가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<!-- 페이징 영역 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled"><a class="page-link">이전</a></li>
				<li class="page-item active"><a class="page-link">1</a></li>
				<li class="page-item"><a class="page-link">2</a></li>
				<li class="page-item"><a class="page-link">다음</a></li>
			</ul>
		</nav>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>