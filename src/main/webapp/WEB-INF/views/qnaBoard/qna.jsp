<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>문의 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
.container {
	max-width: 900px;
	margin-top: 30px;
}

.table th, .table td {
	vertical-align: middle;
}

.pagination .page-link {
	color: #7B4BB7;
}

.pagination .page-link:hover {
	color: #212529;
	background-color: #E9ECEF;
	border-color: #904EBC;
}

.pagination .page-item.active .page-link {
	background-color: #B481D9;
	border-color: #A069CB;
	color: white;
}

.custom-btn-primary {
	background-color: #b481d9 !important;
	border-color: #b481d9 !important;
	color: white !important;
}

.custom-btn-primary:hover {
	background-color: #b481d9 !important;
	border-color: #b481d9 !important;
	color: white !important;
}

.custom-btn-outline-primary {
  color: #b481d9 !important;
  border: 1px solid #d1d1d1 !important;
  background-color: transparent !important;
}

.custom-btn-outline-primary:hover {
  background-color: #b481d9 !important;
  color: white !important;
}

/* 문의 게시판 테이블 스타일을 공지게시판처럼 심플하게 변경 */
.table thead th{
    background-color: #eedbfd;  /* 연보라색 헤더 */
    color: #5E2B97;
    font-weight: bold;
    border-top: 2px solid #e8d6ff;
    border-bottom: 1px solid #ddd;
}

.table tbody tr:hover {
    background-color: #f9f7ff; /* 행 호버 시 연한 보라빛 배경 */
    cursor: pointer;
}

/* 테이블 전체에 테두리 선 제거하고 라인으로 구분 */
.table {
    border-collapse: collapse;
}

.table td, .table th {
    border: none;            /* 부트스트랩 기본 테두리 제거 */
    border-bottom: 1px solid #eee; /* 밑줄로 구분만 */
    vertical-align: middle;
}

/* 번호, 문의 종류 등 좌우 공간 확보 */
.table td, .table th {
    padding: 12px 10px;
}

/* 답변 상태 뱃지 스타일 수정 */
.badge.bg-success {
    background-color: #28a745; /* 완료: 초록 */
    font-size: 0.85rem;
    padding: 5px 10px;
}

.badge.bg-secondary {
    background-color: #6c757d; /* 검토중: 회색 */
    font-size: 0.85rem;
    padding: 5px 10px;
}

h2.fw-bold {
  margin-bottom: 30px;
}

.card-header {
  background-color: #eedbfd !important; /* 연보라색 */
  color: #5E2B97 !important;
}

html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

body > .container {
    flex: 1;
}



</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">

		<h2 class="fw-bold">문의 게시판</h2>

		<!-- 문의 작성 폼 -->
		<sec:authorize access="isAuthenticated()">
			<c:if test="${param.action != 'detail'}">
				<form action="${pageContext.request.contextPath}/qnaBoard"
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

						<div class="col-auto">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="isPrivate"
									id="isPrivate" value="Y" /> <label class="form-check-label"
									for="isPrivate">비밀글로 작성</label>
							</div>
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
			</c:if>
		</sec:authorize>

		<sec:authorize access="!isAuthenticated()">
			<div class="alert alert-warning">
				문의를 작성하려면 <a href="${pageContext.request.contextPath}/login">로그인</a>이
				필요합니다.
			</div>
		</sec:authorize>

		<c:choose>

			<c:when test="${param.action == null || param.action == 'list'}">

				<div class="d-flex justify-content-between align-items-center mb-3">
					<h5 class="mb-0">QNA 목록</h5>
					<div class="d-flex gap-2">
						<a
							href="${pageContext.request.contextPath}/qnaBoard?action=list&view=all"
							class="btn ${viewMode eq 'all' ? 'custom-btn-primary' : 'custom-btn-outline-primary'} btn-sm">전체
							문의보기</a> <a
							href="${pageContext.request.contextPath}/qnaBoard?action=list&view=mine"
							class="btn ${viewMode eq 'mine' ? 'custom-btn-primary' : 'custom-btn-outline-primary'} btn-sm">내
							문의보기</a>

					</div>
				</div>

				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 60px; text-align: center;">번호</th>
							<th style="width: 140px; text-align: center;">문의 종류</th>
							<th style="width: 100px;">답변 상태</th>
							<th style="text-align: center;">제목</th>
							<th style="width: 120px; text-align: center;">문의자</th>
							<th style="width: 120px; text-align: center;">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty qnaList}">
							<tr>
								<td colspan="6" class="text-center">등록된 문의가 없습니다.</td>
							</tr>
						</c:if>


						<c:forEach var="qna" items="${qnaList}">
							<tr
								onclick="location.href='${pageContext.request.contextPath}/qnaBoard?action=detail&id=${qna.qnaId}'"
								style="cursor: pointer;">
								<td style="text-align: center;">${qna.qnaId}</td>
								<td class="text-center">${qna.qnaType}</td>
								<td><c:choose>
										<c:when test="${not empty qna.answerDetail}">
											<span class="badge bg-success">답변완료</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-secondary">검토중</span>
										</c:otherwise>
									</c:choose></td>
								<!-- 비밀글 표시 추가 -->
								<td><c:if test="${qna.isPrivate == 'Y'}">
  								<i class="bi bi-lock-fill text-secondary me-1" title="비밀글"></i>
								</c:if> ${qna.qnaTitle}</td>
								<!-- 링크 제거 -->
								<td class="text-center"><c:out value="${qna.userId}" /></td>
								<td class="text-center"><fmt:formatDate value="${qna.createDate}"
										pattern="yyyy.MM.dd" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
							<a class="page-link" href="?page=${currentPage - 1}"
							tabindex="-1">이전</a>
						</li>
						<c:forEach var="i" begin="1" end="${totalPage}">
							<li class="page-item ${i == currentPage ? 'active' : ''}"><a
								class="page-link" href="?page=${i}">${i}</a></li>
						</c:forEach>
						<li
							class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
							<a class="page-link" href="?page=${currentPage + 1}">다음</a>
						</li>
					</ul>
				</nav>

			</c:when>


			<c:when test="${param.action == 'detail'}">
				<!-- 여기에 에러 메시지 출력 추가 -->
				<c:if test="${not empty errorMessage}">
					<div class="alert alert-danger" role="alert">${errorMessage}
					</div>
				</c:if>

				<c:if test="${not empty qna}">
					<div class="card mb-3">
						<div class="card-header">
							<h5>
								<c:out value="${qna.qnaTitle}" />
							</h5>
							<small class="text-muted"> 문의 종류: ${qna.qnaType} | 작성자:
								${qna.userId} | 작성일: <fmt:formatDate value="${qna.createDate}"
									pattern="yyyy.MM.dd" />
							</small>
						</div>
						<div class="card-body">
							<p>
								<strong>문의 내용</strong>
							</p>
							<c:choose>
								<c:when
									test="${qna.isPrivate == 'Y' && (user == null || user.userNo != qna.userNo) && !pageContext.request.isUserInRole('ROLE_ADMIN')}">
									<p class="text-muted">비밀글입니다. 작성자와 관리자만 내용 확인이 가능합니다.</p>
								</c:when>
								<c:otherwise>
									<p style="white-space: pre-wrap;"><c:out value="${qna.qnaDetail}" /></p>
								</c:otherwise>
							</c:choose>

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
								<c:choose>
									<c:when
										test="${qna.isPrivate == 'Y' && (user == null || user.userNo != qna.userNo) && !pageContext.request.isUserInRole('ROLE_ADMIN')}">
										<p class="text-muted">관리자 답변도 비밀글이므로 작성자와 관리자만 확인할 수 있습니다.</p>
									</c:when>
									<c:otherwise>
										<div class="border rounded p-3 mb-3"
											style="background: #f9f9f9;">
											<p>
												<strong>관리자 답변:</strong>
											</p>
											<p style="white-space: pre-wrap;">${qna.answerDetail}</p>
											<small class="text-muted"> 등록일: <fmt:formatDate
													value="${qna.answerDate}" pattern="yyyy.MM.dd HH:mm:ss" /></small>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>

							<!-- 답변 작성 폼 (관리자이면서, 아직 답변이 없을 때만) -->
							<sec:authorize access="hasRole('ROLE_ADMIN')">
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
							</sec:authorize>
							<a
								href="${pageContext.request.contextPath}/qnaBoard?action=list&view=all"
								class="btn btn-secondary btn-sm">목록으로</a>

							<sec:authorize access="isAuthenticated()">
								<c:if
									test="${user.userNo == qna.userNo or pageContext.request.isUserInRole('ROLE_ADMIN')}">
									<form
										action="${pageContext.request.contextPath}/qnaBoard?action=delete&id=${qna.qnaId}"
										method="post"
										style="position: absolute; bottom: 15px; right: 15px; margin: 0;" id="deleteForm">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<button type="submit" class="btn btn-danger btn-sm">삭제</button>
									</form>
								</c:if>
							</sec:authorize>


						</div>
					</div>

				</c:if>
			</c:when>
		</c:choose>

	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		
	<script>
		document.getElementById('deleteForm').addEventListener('submit', async (event) => {
		    event.preventDefault();
		    
		    let modalTitle = "문의 삭제";
		    let modalContent = "문의 내용을 삭제하시겠습니까?";
		    
		    const result = await window.showCommonModal(
		            modalTitle,
		            modalContent,
		        {
		            cancelButtonText: "아니오",
		            confirmButtonText: "네, 진행합니다"
	        	}
	        );
		    if (result)
		        event.target.submit();
		});
	</script>

</body>
</html>
