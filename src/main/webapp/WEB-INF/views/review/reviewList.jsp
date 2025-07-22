<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>행사 세부 페이지 내 리뷰창</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<style>
.review {
	width: 100%;
}

.reviewAction {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container my-5">
		<table class="table table-hover text-center align-middle">

			<p>ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ</p>
			<h2>리뷰 (총 ** 건)</h2>
			
			<thead>
				<div class=review>
					<div class="input-group mb-3">
						<svg aria-label="Placeholder" height="60" width="60" xmlns="http://www.w3.org/2000/svg">
							<title>Placeholder</title><rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect>
						</svg>
						<textarea class="form-control" id="exampleFormControlTextarea1"
							rows="3"></textarea>
						<div class="reviewAction" style="margin-left: 5px;">
							<select class="form-select form-select-sm"
								aria-label="Large select example">
								<option selected>☆☆☆☆☆</option>
								<option value="1">★☆☆☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="3">★★★☆☆</option>
								<option value="4">★★★★☆</option>
								<option value="5">★★★★★</option>
							</select>
							<button class="btn btn-outline-secondary" type="button"
								id="button-addon2" style="font-size: 20px;">작성</button>
						</div>
					</div>
			</thead>
			
			<p>ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ</p>

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