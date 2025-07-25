<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홍보 게시판</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/promoBoard.css">

    <script>
        var contextPath = "<c:out value='${contextPath}'/>";
    </script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="page-wrapper">

        <div class="top-spacer"></div>

        <c:if test="${not empty alertMsg}">
            <div class="alert alert-info">${alertMsg}</div>
        </c:if>

        <div class="board-header-section">
            <div class="search-bar-area">
                <form action="<c:url value="/promoBoard"/>" method="GET" class="search-form">
                    <div class="search-wrapper">
                        <input type="text" class="search-input" placeholder="search" aria-label="Search" name="searchKeyword" value="${param.searchKeyword}">
                        <button class="search-button" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                        <input type="hidden" name="cpage" value="1">
                    </div>
                </form>
            </div>
            <div class="register-button-area">
                <c:if test="${not empty loginUser}">
                    <%-- 로그인된 사용자 정보가 있을 경우 --%>
                    <c:set var="hasManagerRole" value="false" />
                    <c:forEach var="authority" items="${loginUser.authorities}">
                        <c:if test="${authority eq 'ROLE_MANAGER'}">
                            <c:set var="hasManagerRole" value="true" />
                        </c:if>
                    </c:forEach>

                    <c:if test="${hasManagerRole}">
                        <button type="button" class="register-promo-btn" id="registerPromoButton">
                            등록하기
                        </button>
                    </c:if>
                </c:if>
                </div>
        </div>

        <hr class="section-divider">

        <div class="promotion-container">
            <c:set var="minPosts" value="12" /> <c:forEach var="promo" items="${list}">
                <div class="post" onclick="location.href='<c:url value="/promoBoard/detail">
                                        <c:param name="promoId" value="${promo.promoId}"/>
                                    </c:url>'">
                    <div class="poster">
                        <%-- ⭐⭐ promo.posterPath가 이미 /resources/images/ 를 포함하므로, 여기서는 contextPath만 붙입니다. ⭐⭐ --%>
                        <img src="${contextPath}${promo.posterPath}" alt="포스터 이미지" />
                    </div>
                    <div class="views-count">조회수 ${promo.views}</div>
                    <div class="post-title">${promo.promoTitle}</div>
                    <div class="post-date">
                        <c:if test="${not empty promo.startDate and not empty promo.endDate}">
                            <fmt:formatDate value="${promo.startDate}" pattern="yyyy.MM.dd" /> - <fmt:formatDate value="${promo.endDate}" pattern="yyyy.MM.dd" />
                        </c:if>
                        <c:if test="${empty promo.startDate or empty promo.endDate}">
                            <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd" />
                        </c:if>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${fn:length(list) lt minPosts}">
                <c:forEach begin="${fn:length(list)}" end="${minPosts - 1}">
                    <div class="post placeholder-post">
                        <div class="poster">
                            <img src="https://placehold.co/400x400/e0e0e0/ffffff?text=Preparing" alt="준비 중인 이미지">
                        </div>
                        <div class="views-count">조회수 0</div>
                        <div class="post-title">준비 중인 게시글</div>
                        <div class="post-date">날짜 미정</div>
                    </div>
                </c:forEach>
            </c:if>
        </div>

        <div class="pagination-container d-flex justify-content-center">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item ${pi.currentPage <= 1 ? 'disabled' : ''}">
                        <c:url var="prevPageUrl" value="/promoBoard">
                            <c:param name="cpage" value="${pi.currentPage - 1}"/>
                            <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                        </c:url>
                        <a class="page-link" href="${prevPageUrl}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                        <li class="page-item ${i == pi.currentPage ? 'active' : ''}">
                            <c:url var="pageUrl" value="/promoBoard">
                                <c:param name="cpage" value="${i}"/>
                                <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                            </c:url>
                            <a class="page-link" href="${pageUrl}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${pi.currentPage >= pi.totalPage ? 'disabled' : ''}">
                        <c:url var="nextPageUrl" value="/promoBoard">
                            <c:param name="cpage" value="${pi.currentPage + 1}"/>
                            <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                        </c:url>
                        <a class="page-link" href="${nextPageUrl}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

    </div> 
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/modal.jsp" />    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="${contextPath}/resources/js/promoBoard.js"></script>
    <script src="${contextPath}/resources/js/commonModal.js"></script> 
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Get "Register" button element
            const registerPromoButton = document.getElementById('registerPromoButton');

            // 버튼이 존재할 때만 클릭 이벤트 리스너를 추가
            if (registerPromoButton) {
                registerPromoButton.addEventListener('click', async function() {
                    // Call showCommonModal function (returns Promise)
                    const confirmed = await window.showCommonModal(
                        "행사 등록 확인", // Modal title
                        "행사를 등록하시겠습니까?" // Modal content
                    );

                    if (confirmed) {
                        // If user confirms, navigate to the write page
                        window.location.href = '${contextPath}/promoBoard/promoWrite';
                    } else {
                        // If user cancels or closes modal, do nothing
                        console.log("행사 등록 취소됨.");
                    }
                });
            }
        });
    </script>
</body>
</html>