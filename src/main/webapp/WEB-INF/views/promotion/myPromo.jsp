<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 홍보 리스트</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    
    <!-- Custom CSS -->
    <link href="${contextPath}/resources/css/mypromo.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">내 홍보 리스트</h2>
            <!-- 내 홍보 리스트에서는 '홍보 작성' 버튼 대신 '내 정보' 등으로 변경될 수 있음 -->
            <!-- <a href="${contextPath}/promoBoard/promoWrite" class="btn lavender-btn">홍보 작성</a> -->
        </div>

        <!-- 검색 폼 (내 홍보 리스트에서도 필요하다면 유지) -->
        <div class="row mb-3 justify-content-end">
            <div class="col-md-4">
                <form action="${contextPath}/mypromo/search" method="get" class="d-flex">
                    <select class="form-select me-2" name="searchType">
                        <option value="title" <c:if test="${param.searchType eq 'title'}">selected</c:if>>제목</option>
                        <option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
                    </select>
                    <input type="text" class="form-control me-2" name="searchKeyword" placeholder="검색어 입력" value="${param.searchKeyword}">
                    <button type="submit" class="btn btn-outline-secondary">검색</button>
                </form>
            </div>
        </div>

        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th>제목</th>
                    <th style="width: 15%;">조회수</th>
                    <th style="width: 20%;">작성일</th>
                    <th style="width: 15%;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myPromoList}">
                        <c:forEach var="promo" items="${myPromoList}">
                            <tr>
                                <td>${promo.promoId}</td>
                                <td class="text-start">
                                    <a href="${contextPath}/promoBoard/detail?promoId=${promo.promoId}" class="text-decoration-none text-dark">
                                        ${promo.promoTitle}
                                    </a>
                                </td>
                                <td>${promo.promoViews}</td>
                                <td>
                                    <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
                                </td>
                                <td>
                                    <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn btn-sm btn-outline-primary me-1">수정</a>
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePromo(${promo.promoId})">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5">작성하신 홍보 게시글이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- 페이징 영역 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:url var="listUrl" value="${contextPath}/mypromo">
                    <c:forEach var="entry" items="${param}">
                        <c:if test="${entry.key ne 'currentPage'}">
                            <c:param name="${entry.key}" value="${entry.value}" />
                        </c:if>
                    </c:forEach>
                </c:url>

                <c:choose>
                    <c:when test="${pi.currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${listUrl}&currentPage=${pi.currentPage - 1}">이전</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <span class="page-link">이전</span>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${i == pi.currentPage}">
                            <li class="page-item active">
                                <span class="page-link">${i}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${listUrl}&currentPage=${i}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${pi.currentPage < pi.maxPage}">
                        <li class="page-item">
                            <a class="page-link" href="${listUrl}&currentPage=${pi.currentPage + 1}">다음</a>
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
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${contextPath}/resources/js/mypromo.js"></script>
    <script>
        // 삭제 버튼 클릭 시 호출될 함수 (mypromo.js로 옮길 수 있음)
        function deletePromo(promoId) {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                // 실제 삭제 로직 (AJAX 요청 등) 구현
                // 예: window.location.href = '${contextPath}/promoBoard/delete?promoId=' + promoId;
                console.log('게시글 삭제 요청:', promoId);
                alert('삭제 기능은 아직 구현되지 않았습니다.'); // 임시 메시지
            }
        }
    </script>
</body>
</html>
