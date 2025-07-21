<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <title>행사 - List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
       
        <style>
            /* 공지 작성 버튼 스타일 */
            a.btn.lavender-btn {
                background-color: #b481d9;
                color: white;
                border: 1px solid #a069cb;
            }

            a.btn.lavender-btn:hover {
                background-color: #a069cb;
                border-color: #904ebc;
            }

            /* 테이블 헤더 스타일 */
            thead.lavender-header th {
                background-color: #e6ccff;
                color: #5E2B97;
            }
            
            
        </style>
</head>

<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-5" style="min-height: 600px;">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">공지 게시판</h2>
            <a href="${pageContext.request.contextPath}/noticeBoard/noticeWrite" class="btn lavender-btn">공지 작성</a>
        
        <!--<c:if test="${not empty msg}">
        	<div class="alert alert-info">${msg}</div>
    	</c:if>-->
        
        </div>

        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th>제목</th>
                    <th style="width: 20%;">작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty noticeList}">
                        <c:forEach var="notice" items="${noticeList}">
                            <tr>
                                <td>${notice.noticeId}</td>
                                <td class="text-start">
                                    <a href="${pageContext.request.contextPath}/noticeBoard/detail?noticeId=${notice.noticeId}" class="text-decoration-none text-dark">
    									${notice.noticeTitle}
									</a>
                                </td>
                                <td>
                                    <fmt:formatDate value="${notice.createDate}" pattern="yyyy.MM.dd HH:mm" />
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3">등록된 공지사항이 없습니다.</td>
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
                	<li class="page-item">
                    	<a class="page-link" href="${pageContext.request.contextPath}/noticeBoard/list?page=${currentPage - 1}">이전</a>
                	</li>
            	</c:when>
            	<c:otherwise>
                	<li class="page-item disabled">
                    	<span class="page-link">이전</span>
                	</li>
            	</c:otherwise>
        	</c:choose>

        	<!-- 페이지 번호 -->
        	<c:forEach var="i" begin="${startPage}" end="${endPage}">
            	<c:choose>
                	<c:when test="${i == currentPage}">
                    	<li class="page-item active">
                        	<span class="page-link">${i}</span>
                    	</li>
                	</c:when>
                	<c:otherwise>
                    	<li class="page-item">
                        	<a class="page-link" href="${pageContext.request.contextPath}/noticeBoard/list?page=${i}">${i}</a>
                    	</li>
                	</c:otherwise>
            	</c:choose>
        	</c:forEach>

        	<!-- 다음 버튼 -->
        	<c:choose>
            	<c:when test="${currentPage < totalPage}">
                	<li class="page-item">
                    	<a class="page-link" href="${pageContext.request.contextPath}/noticeBoard/list?page=${currentPage + 1}">다음</a>
                	</li>
            	</c:when>
            	<c:otherwise>
                	<li class="page-item disabled">
                    	<span class="page-link">다음</span>
                	</li>
            	</c:otherwise>
        	</c:choose>

    	</ul>
	</nav>

    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>