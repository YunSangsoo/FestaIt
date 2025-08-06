<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextPath}/resources/css/common.css" rel="stylesheet">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<style>
#searchForm {
	width: 70%;
}

.search-form {
	display:flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

#select-list {
	width: fit-content;
	height: 100%;
	margin-right: 8px;
}

.search-btn {
	width: 100px;
	height: 38px !important;
}

</style>
</head>
<body>
	<c:if test="${not empty param}">
		<c:set var="searchParam" value="&search=${param.search}&keyword=${param.keyword}" />
	</c:if>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container" style="min-height: 600px;">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">리뷰 관리</h2>
        </div>
        
        <div class="d-flex justify-content-between align-items-center">
        <div class="total-num">총 ${pi.totalCount}건</div>
        
        <form method="get" action="${pageContext.request.contextPath}/reviewBoard"
			class="search-form d-flex justify-content-end align-items-center">
	        <select class="form-select" name="search" id="select-list">
				<option value="" selected>전체</option>
				<option value="name"
					${param.search eq 'name' ? 'selected' : ''}>성명</option>
				<option value="id"
					${param.search eq 'id' ? 'selected' : ''}>아이디</option>
				<option value="nickname"
					${param.search eq 'nickname' ? 'selected' : ''}>닉네임</option>
				<option value="title"
					${param.search eq 'title' ? 'selected' : ''}>행사명</option>
				<option value="content"
					${param.search eq 'content' ? 'selected' : ''}>내용</option>
	        </select>
			
			<input type="text" name="keyword" placeholder="search"
				value="${param.keyword}" class="form-control me-2"
				style="max-width: 250px;" />
			<button type="submit" class="btn lavender-btn search-btn">검색</button>
		</form>
	</div>
        
		
        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
                    <th style="width: 10%;">성명</th>
                    <th style="width: 10%;">아이디</th>
                    <th style="width: 10%;">닉네임</th>
                    <th style="width: 18%;">행사명</th>
                    <th>내용</th>
                    <th style="width: 14%;">작성일</th>
                    <th style="width: 8%;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reviewBoard}">
                        <c:forEach var="review" items="${reviewBoard}">
                            <tr>
                                <td class="over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">${review.userName}</td>
                                <td class="over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">${review.userId}</td>
                                <td class="over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">${review.nickname}</td>
                                <td class="text-start over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">${review.appTitle}</td>
                                <td class="text-start over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">${review.comment}</td>
                                <td class="over-hidden" onclick="location.href='${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container'" style="cursor: pointer;">
                                    <fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd HH:mm:ss" />
                                </td>
                                <td>
                                    <button type="button" class="btn-gray" onclick="openDeleteModal(${review.userNo}, ${review.appId})" data-userno="${review.userNo}">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7">등록된 리뷰가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                <!-- 삭제 확인 모달 -->
				<div class="modal fade" id="deleteConfirmModal" tabindex="-1"
					aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<form id="deleteForm"
							action="${pageContext.request.contextPath}/reviewBoard/delete"
							method="post">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="deleteConfirmModalLabel">댓글
										삭제</h5>
									<button type="button" class="btn-close"
										data-bs-dismiss="modal" aria-label="닫기"></button>
								</div>
								<div class="modal-body">댓글을 정말 삭제하시겠습니까?</div>
								<div class="modal-footer">
									<input type="hidden" name="appId" id="deleteParamAppId" />
									<input type="hidden" name="userNo" id="deleteUserNo" />
									<input type="hidden" name="admin" value="true"/>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-danger">삭제</button>
								</div>
							</div>
						</form>
					</div>
				</div>
            </tbody>
        </table>
		
		<!-- 페이징 영역 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${pi.currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/reviewBoard?page=${pi.currentPage - 1}${searchParam}">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">이전</span></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
					<c:choose>
						<c:when test="${i == pi.currentPage}">
							<li class="page-item active"><span class="page-link">${i}</span></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/reviewBoard?page=${i}${searchParam}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${pi.currentPage < pi.totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/reviewBoard?page=${pi.currentPage + 1}${searchParam}">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">다음</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<script type="text/javascript">
	
	// 삭제 모달 열기
	function openDeleteModal(userNo, appId) {
		document.getElementById('deleteUserNo').value = userNo;
		document.getElementById('deleteParamAppId').value = appId;
		const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
		deleteModal.show();
	}
	
	function handleEditClick(button) {
		const userNo = button.dataset.userno;
		const comment = button.dataset.comment;
		document.getElementById('editUserNo').value = userNo;
		document.getElementById('editComment').value = comment;
		new bootstrap.Modal(document.getElementById('saveConfirmModal')).show();
	}
	
	</script>
	
</body>
</html>