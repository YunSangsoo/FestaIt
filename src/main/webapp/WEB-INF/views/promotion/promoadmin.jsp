<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 홍보 관리 게시판</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; }
        .container { margin-top: 50px; }
        .table img {
            max-width: 80px;
            max-height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        .pagination-area {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .search-area {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            flex-wrap: nowrap; 
        }
        .search-area input {
            margin-right: 10px;
            flex-shrink: 0; 
            width: auto; 
            min-width: 150px; 
            max-width: 250px; 
        }
        .search-area button {
            flex-shrink: 0;
            white-space: nowrap; 
        }
        .lavender-header {
            background-color: #e6e6fa; 
        }
        .table-hover tbody tr:hover {
            background-color: inherit;
        }
        .table tbody tr td a {
            text-decoration: none; 
            color: inherit; 
        }
        .table tbody tr td a:hover {
            text-decoration: underline; 
        }
        .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
    <h2 class="mb-4">홍보 관리 게시판</h2>

    <div class="search-area">
        <form action="${contextPath}/promoAdmin" method="get" class="d-flex">
            <select name="searchType" class="form-select me-2" style="width: auto;">
                <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${searchType eq 'writer' ? 'selected' : ''}>작성자</option>
            </select>
            <input type="text" name="keyword" class="form-control me-2" placeholder="검색어를 입력하세요" value="${keyword}">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>

    <table class="table table-hover table-striped">
        <thead class="lavender-header">
            <tr>
                <th class="text-center">번호</th>
                <th class="text-center">제목</th>
                <th class="text-center">작성자</th>
                <th class="text-center">작성일</th>
                <th class="text-center">조회수</th>
                <th class="text-center">상태</th>
                <th class="text-center">관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty promoList}">
                    <tr>
                        <td colspan="7" class="text-center">조회된 홍보 게시글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="promo" items="${promoList}">
                        <tr onclick="location.href='${contextPath}/promoBoard/detail?promoId=${promo.promoId}'" style="cursor: pointer;">
                            <td class="text-center"><c:out value="${promo.promoId}" /></td>
                            <td class="text-center">
                                <a href="${contextPath}/promoBoard/detail?promoId=${promo.promoId}">
                                    <c:out value="${promo.promoTitle}" />
                                </a>
                            </td>
                            <td class="text-center"><c:out value="${promo.promoWriter}" /></td>
                            <td class="text-center"><fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd" /></td>
                            <td class="text-center"><c:out value="${promo.views}" /></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${promo.userStatus eq 'T'}">활성</c:when>
                                    <c:when test="${promo.userStatus eq 'F'}">비활성</c:when>
                                    <c:otherwise><c:out value="${promo.userStatus}" /></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <form action="${contextPath}/promoAdmin/deletePromoPost" method="post" style="display:inline;">
                                    <input type="hidden" name="promoId" value="${promo.promoId}" />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <nav class="pagination-area">
        <ul class="pagination">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${contextPath}/promoAdmin?page=${currentPage - 1}&searchType=${searchType}&keyword=${keyword}">이전</a>
                </li>
            </c:if>
            <c:if test="${currentPage == 1}">
                <li class="page-item disabled"><span class="page-link">이전</span></li>
            </c:if>

            <c:forEach var="p" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${p == currentPage}">
                        <li class="page-item active"><span class="page-link">${p}</span></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="${contextPath}/promoAdmin?page=${p}&searchType=${searchType}&keyword=${keyword}">${p}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPage}">
                <li class="page-item">
                    <a class="page-link" href="${contextPath}/promoAdmin?page=${currentPage + 1}&searchType=${searchType}&keyword=${keyword}">다음</a>
                </li>
            </c:if>
            <c:if test="${currentPage == totalPage}">
                <li class="page-item disabled"><span class="page-link">다음</span></li>
            </c:if>
        </ul>
    </nav>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>