<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<style>
#searchForm {
	width: 70%;
}

/* 공지 작성 버튼 스타일 */
a.btn.lavender-btn, button.lavender-btn {
	background-color: #b481d9;
	color: white;
	border: 1px solid #a069cb;
	padding: 5px 10px;
	border-radius: 3px;
	font-size: 0.9em;
}

a.btn.lavender-btn:hover, button.lavender-btn:hover {
	background-color: #a069cb;
	border-color: #904ebc;
	color: white;
}

/* 테이블 헤더 스타일 */
thead.lavender-header th {
	background-color: #E6CCFF;
	color: #5E2B97;
}

.search-form {
	margin-bottom: 20px;
}

#select-list {
	width: fit-content;
}



</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container my-5" style="min-height: 600px;">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">리뷰 관리</h2>
        </div>
        
        <div class="d-flex justify-content-end align-items-center mb-3">
	        <select class="form-select" name="search-category" id="select-list">
				<option value="" selected>전국</option>
				<option value="seoul"
					${param.region eq 'seoul' ? 'selected' : ''}>서울시</option>
				<option value="incheon"
					${param.region eq 'incheon' ? 'selected' : ''}>인천시</option>
				<option value="gyeonggi"
					${param.region eq 'gyeonggi' ? 'selected' : ''}>경기도</option>
				<option value="gangwon"
					${param.region eq 'gangwon' ? 'selected' : ''}>강원도</option>
				<option value="chungcheong"
					${param.region eq 'chungcheong' ? 'selected' : ''}>충청도</option>
				<option value="jeonla"
					${param.region eq 'jeonla' ? 'selected' : ''}>전라도</option>
				<option value="gyeongsang"
					${param.region eq 'gyeongsang' ? 'selected' : ''}>경상도</option>
				<option value="jeju" ${param.region eq 'jeju' ? 'selected' : ''}>제주도</option>
	        </select>
	        
	        <form method="get"
				action="${pageContext.request.contextPath}/reviewBoard"
				class="search-form d-flex justify-content-end align-items-center">
				<input type="text" name="keyword" placeholder="search"
					value="${param.keyword}" class="form-control me-2"
					style="max-width: 250px;" />
				<button type="submit" class="btn lavender-btn">검색</button>
			</form>
        </div>
        
        

        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
                    <th style="width: 12%;">성명</th>
                    <th style="width: 12%;">아이디</th>
                    <th style="width: 14%;">닉네임</th>
                    <th>내용</th>
                    <th style="width: 14%;">작성일</th>
                    <th style="width: 10%;">리뷰 삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reviewBoard}">
                        <c:forEach var="review" items="${reviewBoard}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/reviewBoard/list?appId=${review.appId}'" style="cursor: pointer;">
                                <td>${review.userName}</td>
                                <td>${review.userId}</td>
                                <td>${review.nickname}</td>
                                <td class="text-start">${review.comment}</td>
                                <td>
                                    <fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd HH:mm:ss" />
                                </td>
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
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/reviewBoard?page=${currentPage - 1}">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">이전</span></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<li class="page-item active"><span class="page-link">${i}</span></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/reviewBoard?page=${i}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${currentPage < totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/reviewBoard?page=${currentPage + 1}">다음</a>
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
</body>
</html>