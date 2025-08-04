<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>권한 없음</title>
	<c:url var="contextPath" value="/" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <jsp:include page="/WEB-INF/views/common/modal.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/commonModal.js"></script>
	
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			const urlParams = new URLSearchParams(window.location.search);
			const message = urlParams.get('message');
			
			if (message) {
				window.showCommonModal('권한 없음', message, {
					confirmButtonText: '확인',
					showCancelButton: false
				}).then(() => {
					window.history.go(-1);
				});
			}
		});
	</script>
</body>
</html>