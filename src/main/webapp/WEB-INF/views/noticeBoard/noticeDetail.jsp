<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
</style>
</head>
<body class="bg-light">

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container bg-white p-4 shadow-sm rounded">
		<h4 class="border-bottom pb-2">공지사항 상세</h4>

		<!-- 메시지 -->
		<!--<c:if test="${not empty msg}">
        <div class="alert alert-info">${msg}</div>
    </c:if>-->

		<form:form id="noticeForm" modelAttribute="notice"
			action="${pageContext.request.contextPath}/noticeBoard/update"
			method="post">
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

			<div class="d-flex justify-content-between mt-4">
				<a href="${pageContext.request.contextPath}/noticeBoard"
					class="btn btn-outline-secondary">게시판으로 돌아가기</a>

				<div>
					<div style="display: flex; gap: 10px;">
						<button type="submit" class="btn btn-success"
							style="display: none;" id="saveBtn">저장</button>
						<button type="button" class="btn btn-secondary"
							onclick="cancelEdit()" style="display: none;" id="cancelBtn">취소</button>
					</div>
				</div>

				<div id="adminButtons" style="display: flex; gap: 10px;">
					<button type="button" class="btn btn-primary"
						onclick="enableEdit()">수정</button>
					<form
						action="${pageContext.request.contextPath}/noticeBoard/delete"
						method="post" style="display: inline;">
						<input type="hidden" name="noticeId" value="${notice.noticeId}" />
						<button type="submit" class="btn btn-danger"
							onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
					</form>
				</div>
			</div>
		</form:form>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		function enableEdit() {
			document.querySelector('[name="noticeTitle"]').removeAttribute(
					'readonly');
			document.querySelector('[name="noticeDetail"]').removeAttribute(
					'readonly');
			document.getElementById("adminButtons").style.display = "none";
			document.getElementById("saveBtn").style.display = "inline-block";
			document.getElementById("cancelBtn").style.display = "inline-block";
		}

		function cancelEdit() {
			location.reload();
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
