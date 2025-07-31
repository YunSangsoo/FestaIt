<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.container {
	max-width: 800px;
	margin-top: 50px;
}

.action-buttons {
	display: flex;
	gap: 10px;
}
</style>
</head>
<body class="bg-light">

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container bg-white p-4 shadow-sm rounded">
		<h4 class="border-bottom pb-2">공지사항 상세</h4>

		<!-- 수정 폼 시작 -->
		<form:form id="noticeForm" modelAttribute="notice"
			action="${pageContext.request.contextPath}/noticeBoard/update"
			method="post" enctype="multipart/form-data">
			<form:hidden path="noticeId" />

			<div class="mb-3">
				<label class="form-label"><strong>제목</strong></label>
				<form:input path="noticeTitle" cssClass="form-control"
					readonly="true" />
			</div>

			<div class="mb-3">
				<label class="form-label"><strong>작성일</strong></label>
				<div>
					<fmt:formatDate value="${notice.createDate}"
						pattern="yyyy.MM.dd HH:mm" />
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label"><strong>내용</strong></label>
				<form:textarea path="noticeDetail" cssClass="form-control" rows="10"
					readonly="true" />
			</div>

			<!-- 첨부파일 표시 및 수정 -->
			<div class="mb-3">
				<label class="form-label"><strong>첨부파일</strong></label><br>

				<c:choose>
					<c:when test="${not empty noticeImage}">
						<!-- 기존 파일 다운로드 링크 (이건 항상 보여야 하므로 숨기지 않음) -->
						<a
							href="${pageContext.request.contextPath}/noticeBoard/download?filePath=/resources/upload/notice/${noticeImage.changeName}"
							class="btn btn-link"> ${noticeImage.originName} </a>

						<div id="fileEditArea" style="display: none;">
							<!-- 삭제 체크박스 -->
							<div class="form-check mt-2">
								<input class="form-check-input" type="checkbox" id="deleteFile"
									name="deleteFile" value="true" disabled /> <label
									class="form-check-label" for="deleteFile">첨부파일 삭제</label>
							</div>

							<!-- 새 파일 업로드 input -->
							<input type="file" name="noticeFile" class="form-control mt-2"
								disabled />
						</div>
					</c:when>
					<c:otherwise>
						<span class="text-muted">첨부된 파일이 없습니다.</span>
						<div id="fileEditArea" style="display: none;">
							<input type="file" name="noticeFile" class="form-control mt-2"
								disabled />
						</div>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="d-flex justify-content-between align-items-center mt-4">
				<!-- 돌아가기 -->
				<a href="${pageContext.request.contextPath}/noticeBoard"
					class="btn btn-outline-secondary"> 게시판으로 돌아가기 </a>

				<!-- 버튼 그룹 -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div class="action-buttons">
						<!-- 수정/삭제 버튼 -->
						<div id="adminButtons">
							<button type="button" class="btn btn-primary"
								onclick="enableEdit()">수정</button>
						</div>

						<!-- 저장/취소 버튼 -->
						<div id="editButtons" style="display: none; gap: 16px;">
							<button type="submit" class="btn btn-success">저장</button>
							<button type="button" class="btn btn-secondary"
								onclick="cancelEdit()">취소</button>
						</div>
					</div>
				</sec:authorize>
			</div>
		</form:form>

		<!-- 삭제는 반드시 form:form 밖에 위치 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<form action="${pageContext.request.contextPath}/noticeBoard/delete"
				method="post"
				style="position: relative; display: inline-block; margin-top: -42px; float: right; margin-right: 90px;">
				<input type="hidden" name="noticeId" value="${notice.noticeId}" />
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<button type="submit" class="btn btn-danger"
					onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
			</form>
		</sec:authorize>
	</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		function enableEdit() {
			document.querySelector('[name="noticeTitle"]').removeAttribute(
					'readonly');
			document.querySelector('[name="noticeDetail"]').removeAttribute(
					'readonly');

			// 첨부파일 영역 보여주기
			document.getElementById("fileEditArea").style.display = "block";

			// 파일 input 활성화
			const fileInput = document
					.querySelector('input[name="noticeFile"]');
			if (fileInput)
				fileInput.removeAttribute('disabled');

			// 삭제 체크박스 활성화
			const deleteCheckbox = document
					.querySelector('input[name="deleteFile"]');
			if (deleteCheckbox)
				deleteCheckbox.removeAttribute('disabled');

			document.getElementById("adminButtons").style.display = "none";
			document.getElementById("editButtons").style.display = "flex";

			// 삭제 버튼 숨기기 (선택 사항)
			document.querySelector('form[action$="/noticeBoard/delete"]').style.display = "none";
		}

		function cancelEdit() {
			location.reload();
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
