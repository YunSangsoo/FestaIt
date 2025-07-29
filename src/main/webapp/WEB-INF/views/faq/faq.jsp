<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>문의 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
.container {
	max-width: 900px;
	margin-top: 30px;
}
.table th, .table td {
	vertical-align: middle;
}
</style>
</head>
<body>

	<div class="container">

		<h3 class="mb-4">문의 게시판</h3>

		<!-- 문의 작성 폼 -->
		<form action="${pageContext.request.contextPath}/inquiry/create" method="post" class="mb-5">
			<div class="row g-3 align-items-center mb-3">
				<div class="col-auto">
					<select name="inquiryType" class="form-select" required>
						<option value="" disabled selected>문의 종류 선택</option>
						<option value="행사 관련">행사 관련</option>
						<option value="행사 등록 관련">행사 등록 관련</option>
						<option value="기술 지원">기술 지원</option>
						<option value="계정 문의">계정 문의</option>
						<option value="기타 문의">기타 문의</option>
					</select>
				</div>
				<div class="col-auto flex-grow-1">
					<input type="text" name="title" class="form-control" placeholder="제목을 입력해주세요." required />
				</div>
				<div class="col-auto">
					<button type="submit" class="btn btn-primary">문의하기</button>
				</div>
			</div>
			<div class="mb-3">
				<textarea name="content" class="form-control" rows="4" placeholder="문의 내용을 작성해주세요." required></textarea>
			</div>
		</form>

		<div class="d-flex justify-content-between align-items-center mb-3">
			<h5 class="mb-0">문의 목록</h5>
			<div class="d-flex gap-2">
				<a href="${pageContext.request.contextPath}/inquiry/list?view=all"
					class="btn ${viewMode eq 'all' ? 'btn-primary' : 'btn-outline-primary'} btn-sm">
					전체 문의보기
				</a>
				<a href="${pageContext.request.contextPath}/inquiry/list?view=mine"
					class="btn ${viewMode eq 'mine' ? 'btn-primary' : 'btn-outline-primary'} btn-sm">
					내 문의보기
				</a>
			</div>
		</div>

		<!-- 문의 목록 테이블 -->
		<table class="table table-bordered table-hover">
			<thead class="table-light">
				<tr>
					<th style="width: 60px;">번호</th>
					<th style="width: 120px;">문의 종류</th>
					<th style="width: 100px;">답변 상태</th>
					<th>제목</th>
					<th style="width: 120px;">문의자</th>
					<th style="width: 120px;">등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="inquiry" items="${inquiryList}">
					<tr>
						<td>${inquiry.id}</td>
						<td>${inquiry.inquiryType}</td>
						<td>
							<c:choose>
								<c:when test="${inquiry.answered}">
									<span class="badge bg-success">답변완료</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-secondary">검토중</span>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<a href="${pageContext.request.contextPath}/inquiry/detail?id=${inquiry.id}">
								${inquiry.title}
							</a>
						</td>
						<td>${inquiry.writer}</td>
						<td><fmt:formatDate value="${inquiry.createdDate}" pattern="yyyy.MM.dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이징 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:if test="${currentPage > 1}">
					<li class="page-item">
						<a class="page-link" href="?page=${currentPage - 1}&view=${viewMode}">이전</a>
					</li>
				</c:if>

				<c:forEach begin="1" end="${totalPage}" var="pageNum">
					<li class="page-item ${pageNum == currentPage ? 'active' : ''}">
						<a class="page-link" href="?page=${pageNum}&view=${viewMode}">${pageNum}</a>
					</li>
				</c:forEach>

				<c:if test="${currentPage < totalPage}">
					<li class="page-item">
						<a class="page-link" href="?page=${currentPage + 1}&view=${viewMode}">다음</a>
					</li>
				</c:if>
			</ul>
		</nav>

	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
