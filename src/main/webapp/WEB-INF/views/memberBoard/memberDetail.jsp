<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<title>회원 상세 정보</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
.member-detail-table {
	border-collapse: collapse;
	width: 80%;
	margin: 0 auto;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	font-size: 1rem;
}

.member-detail-table td, .member-detail-table th {
	border: 1px solid #ddd;
	padding: 12px 20px;
}

.member-detail-table .label-col {
	background-color: #f3e6ff;
	font-weight: 600;
	width: 150px;
	text-align: left;
}

.member-detail-table tbody tr:hover {
	background-color: #faf0ff;
}

button, .btn {
	margin-right: 10px;
	min-width: 110px;
}

.btn-outline-secondary {
	color: #aaa;
	border-color: #aaa;
	pointer-events: none; /* 비활성화 */
}

.container {
	max-width: 900px;
	margin: 40px auto;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container my-5"
		style="min-height: 600px; padding-left: 300px; padding-right: 300px;">
		<h2 class="mb-4 fw-bold">회원 상세 정보</h2>

		<table class="table table-bordered member-detail-table">
			<tr>
				<td class="label-col">아이디</td>
				<td>${member.userId}</td>
			</tr>
			<tr>
				<td class="label-col">이름</td>
				<td>${member.userName}</td>
			</tr>
			<tr>
				<td class="label-col">닉네임</td>
				<td>${member.nickname}</td>
			</tr>
			<tr>
				<td class="label-col">가입일</td>
				<td><fmt:formatDate value="${member.enrollDate}"
						pattern="yyyy.MM.dd" /></td>
			</tr>
			<tr>
				<td class="label-col">최근 접속일</td>
				<td><c:choose>
						<c:when test="${not empty member.lastLoginAt}">
							<fmt:formatDate value="${member.lastLoginAt}"
								pattern="yyyy.MM.dd HH:mm" />
						</c:when>
						<c:otherwise>접속 기록 없음</c:otherwise>
					</c:choose></td>
			</tr>
			<tr>
				<td class="label-col">이메일</td>
				<td>${member.email}</td>
			</tr>
			<tr>
				<td class="label-col">전화번호</td>
				<td>${member.phone}</td>
			</tr>
			<tr>
				<td class="label-col">주소</td>
				<td>${member.addr}</td>
			</tr>
			<tr>
				<td class="label-col">등급</td>
				<td><c:choose>
						<c:when test="${not empty member.userType}">
      						${member.userType}
   						</c:when>
						<c:otherwise>일반</c:otherwise>
					</c:choose></td>
			</tr>
		</table>

		<div class="mt-4 d-flex justify-content-between flex-wrap">
			<div>
				<a href="${pageContext.request.contextPath}/memberBoard"
					class="btn btn-secondary">목록</a>
			</div>

			<div class="d-flex gap-2">
				<a
					href="${pageContext.request.contextPath}/reviewBoard?userId=${member.userId}"
					class="btn btn-outline-primary">작성 리뷰 보기</a> <a
					href="${pageContext.request.contextPath}/faqBoard?userId=${member.userId}"
					class="btn btn-outline-secondary">작성 문의 보기</a>

				<form
					action="${pageContext.request.contextPath}/memberBoard/deleteUser"
					method="post" id="deleteForm"
					class="d-inline" >
					<input type="hidden" name="userNo" value="${member.userNo}" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="submit" class="btn btn-outline-danger">회원 삭제</button>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		
		<script>
			document.getElementById('deleteForm').addEventListener('submit', async (event) => {
			    event.preventDefault();
			    
			    let modalTitle = "회원 삭제";
			    let modalContent = "회원을 삭제하시겠습니까?";
			    
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
