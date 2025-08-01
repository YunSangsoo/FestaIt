<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>문의 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">

		<h3 class="mb-4">문의 게시판</h3>

		<!-- 문의 작성 폼 -->
		<form
			action="${pageContext.request.contextPath}/qnaBoard?action=create"
			method="post" class="mb-5">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<div class="row g-3 align-items-center mb-3">
				<div class="col-auto">
					<select name="qnaType" class="form-select" required>
						<option value="" disabled selected>문의 종류 선택</option>
						<option value="행사 관련">행사 관련</option>
						<option value="행사 등록 관련">행사 등록 관련</option>
						<option value="기술 지원">기술 지원</option>
						<option value="계정 문의">계정 문의</option>
						<option value="기타 문의">기타 문의</option>
					</select>
				</div>
				<div class="col-auto flex-grow-1">
					<input type="text" name="qnaTitle" class="form-control"
						placeholder="제목을 입력해주세요." required />
				</div>
				<div class="col-auto">
					<button type="submit" class="btn btn-primary">문의하기</button>
				</div>
			</div>
			<div class="mb-3">
				<textarea name="qnaDetail" class="form-control" rows="4"
					placeholder="문의 내용을 작성해주세요." required></textarea>
			</div>
		</form>

		<c:choose>

			<c:when test="${param.action == null || param.action == 'list'}">

				<div class="d-flex justify-content-between align-items-center mb-3">
					<h5 class="mb-0">QNA 목록</h5>
					<div class="d-flex gap-2">
						<a
							href="${pageContext.request.contextPath}/qnaBoard?action=list&view=all"
							class="btn ${viewMode eq 'all' ? 'btn-primary' : 'btn-outline-primary'} btn-sm">전체
							문의보기</a> <a
							href="${pageContext.request.contextPath}/qnaBoard?action=list&view=mine"
							class="btn ${viewMode eq 'mine' ? 'btn-primary' : 'btn-outline-primary'} btn-sm">내
							문의보기</a>
					</div>
				</div>

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
					<tbody>
						<c:forEach var="qna" items="${qnaList}">
							<tr
								onclick="location.href='${pageContext.request.contextPath}/qnaBoard?action=detail&id=${qna.qnaId}'"
								style="cursor: pointer;">
								<td>${qna.qnaId}</td>
								<td>${qna.qnaType}</td>
								<td><c:choose>
										<c:when test="${not empty qna.answerDetail}">
											<span class="badge bg-success">답변완료</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-secondary">검토중</span>
										</c:otherwise>
									</c:choose></td>
								<td>${qna.qnaTitle}</td>
								<!-- 링크 제거 -->
								<td>${qna.userNo}</td>
								<td><fmt:formatDate value="${qna.createDate}"
										pattern="yyyy.MM.dd" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center">
						<c:if test="${currentPage > 1}">
							<li class="page-item"><a class="page-link"
								href="?action=list&page=${currentPage - 1}&view=${viewMode}">이전</a></li>
						</c:if>
						<c:forEach begin="1" end="${totalPage}" var="pageNum">
							<li class="page-item ${pageNum == currentPage ? 'active' : ''}">
								<a class="page-link"
								href="?action=list&page=${pageNum}&view=${viewMode}">${pageNum}</a>
							</li>
						</c:forEach>
						<c:if test="${currentPage < totalPage}">
							<li class="page-item"><a class="page-link"
								href="?action=list&page=${currentPage + 1}&view=${viewMode}">다음</a></li>
						</c:if>
					</ul>
				</nav>

			</c:when>


			<c:when test="${param.action == 'detail'}">
				<c:if test="${not empty qna}">
					<div class="card mb-3">
						<div class="card-header">
							<h5>${qna.qnaTitle}</h5>
							<small class="text-muted"> 문의 종류: ${qna.qnaType} | 작성자:
								${qna.userNo} | 작성일: <fmt:formatDate value="${qna.createDate}"
									pattern="yyyy.MM.dd" />
							</small>
						</div>
						<div class="card-body">
							<p>
								<strong>문의 내용</strong>
							</p>
							<p style="white-space: pre-wrap;">${qna.qnaDetail}</p>

							<hr />

							<p>
								<strong>답변 상태:</strong>
								<c:choose>
									<c:when test="${not empty qna.answerDetail}">
										<span class="badge bg-success">답변완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">답변 대기중</span>
									</c:otherwise>
								</c:choose>
							</p>

							<!-- 답변 내용은 모두가 볼 수 있음 -->
							<c:if test="${not empty qna.answerDetail}">
								<div class="border rounded p-3 mb-3"
									style="background: #f9f9f9;">
									<p>
										<strong>관리자 답변:</strong>
									</p>
									<p style="white-space: pre-wrap;">${qna.answerDetail}</p>
									<small class="text-muted"> 등록일: <fmt:formatDate
											value="${qna.answerDate}" pattern="yyyy.MM.dd HH:mm:ss" />
									</small>
								</div>
							</c:if>

							<!-- 관리자만 답변 작성 가능 -->
							<c:if test="${sessionScope.isAdmin}">
								<c:if test="${empty qna.answerDetail}">
									<form
										action="${pageContext.request.contextPath}/qnaBoard?action=answer&id=${qna.qnaId}"
										method="post" class="mb-3">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<div class="mb-3">
											<label for="answerDetail" class="form-label">답변 작성</label>
											<textarea id="answerDetail" name="answerDetail"
												class="form-control" rows="5" placeholder="답변을 입력하세요."
												required></textarea>
										</div>
										<button type="submit" class="btn btn-primary">답변 등록</button>
									</form>
								</c:if>
							</c:if>

							<a
								href="${pageContext.request.contextPath}/qnaBoard?action=list&view=all"
								class="btn btn-secondary btn-sm">목록으로</a>
						</div>
					</div>
				</c:if>
			</c:when>
		</c:choose>

	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
