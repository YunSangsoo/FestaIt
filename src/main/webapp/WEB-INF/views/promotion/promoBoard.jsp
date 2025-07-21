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

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <!-- Google Fonts: Noto Sans KR -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Custom CSS: promoBoard.css -->
    <link rel="stylesheet" href="${contextPath}/resources/css/promoBoard.css">

    <%-- JavaScript 파일에서 contextPath를 사용하기 위해 전역 변수로 선언 --%>
    <script>
        var contextPath = "<c:out value='${contextPath}'/>";
    </script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- 페이지 전체를 감싸는 래퍼 -->
    <div class="page-wrapper">

        <!-- 헤더와 검색창 사이 공간 -->
        <div class="top-spacer"></div>

        <!-- Flash Message (알림 메시지) -->
        <c:if test="${not empty alertMsg}">
            <div class="alert alert-info">${alertMsg}</div>
        </c:if>

        <!-- 상단 섹션 (검색창, 등록하기 버튼) -->
        <div class="board-header-section">
            <!-- 검색창 영역 -->
            <div class="search-bar-area">
                <form action="<c:url value="/promoBoard"/>" method="GET" class="search-form">
                    <div class="search-wrapper">
                        <input type="text" class="search-input" placeholder="search" aria-label="Search" name="searchKeyword" value="${param.searchKeyword}">
                        <button class="search-button" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                        <%-- 검색 시 항상 1페이지로 이동하도록 hidden input 추가 --%>
                        <input type="hidden" name="cpage" value="1">
                    </div>
                </form>
            </div>
            <!-- 등록하기 버튼 영역 -->
            <div class="register-button-area">
                <!-- 이 버튼 클릭 시 showCommonModal 함수 호출 -->
                <button type="button" class="register-promo-btn" id="registerPromoButton">
                    등록하기
                </button>
            </div>
        </div>

        <!-- 검색/등록 영역과 포스터 목록 사이의 구분선 -->
        <hr class="section-divider">

        <!-- 포스터 컨테이너 -->
        <div class="promotion-container">
            <c:set var="minPosts" value="12" /> <%-- 최소 표시할 포스터 개수 (4개씩 3줄을 채우기 위해 12개) --%>
            <c:set var="currentPromoCount" value="${fn:length(promoList)}" />
            <c:set var="displayCount" value="${currentPromoCount > minPosts ? currentPromoCount : minPosts}" />

            <c:forEach var="i" begin="0" end="${displayCount - 1}">
                <c:set var="promo" value="${promoList[i]}" /> <%-- i번째 promo 객체 가져오기 --%>

                <c:choose>
                    <c:when test="${not empty promo}">
                        <%-- 실제 게시글 데이터 --%>
                        <div class="post" onclick="location.href='<c:url value="/promoBoard/detail">
                                                                    <c:param name="promoId" value="${promo.promoId}"/>
                                                                </c:url>'">
                            <!-- 포스터 이미지 영역 -->
                            <div class="poster">
                                <img src="${contextPath}/resources/uploadFiles/${promo.posterPath}" alt="포스터 이미지" onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
                            </div>
                            <!-- 조회수 -->
                            <div class="views-count">조회수 ${promo.views}</div>
                            <!-- 제목 -->
                            <div class="post-title">${promo.promoTitle}</div>
                            <!-- 이벤트 날짜 -->
                            <div class="post-date">
                                <c:if test="${not empty promo.startDate and not empty promo.endDate}">
                                    <fmt:formatDate value="${promo.startDate}" pattern="yyyy.MM.dd" /> - <fmt:formatDate value="${promo.endDate}" pattern="yyyy.MM.dd" />
                                </c:if>
                                <c:if test="${empty promo.startDate or empty promo.endDate}">
                                    <!-- 시작/종료 날짜가 없는 경우 생성 날짜 사용 -->
                                    <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd" />
                                </c:if>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- 플레이스홀더 게시글 --%>
                        <div class="post placeholder-post">
                            <!-- 포스터 이미지 영역 -->
                            <div class="poster">
                                <img src="https://placehold.co/400x400/e0e0e0/ffffff?text=Preparing" alt="준비 중인 이미지">
                            </div>
                            <!-- 조회수 -->
                            <div class="views-count">조회수 0</div>
                            <!-- 제목 -->
                            <div class="post-title">준비 중인 게시글</div>
                            <!-- 이벤트 날짜 -->
                            <div class="post-date">날짜 미정</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <%-- 페이지네이션 --%>
        <div class="pagination-container d-flex justify-content-center">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <!-- 이전 페이지 버튼 -->
                    <li class="page-item ${pi.currentPage <= 1 ? 'disabled' : ''}">
                        <c:url var="prevPageUrl" value="/promoBoard">
                            <c:param name="cpage" value="${pi.currentPage - 1}"/>
                            <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                        </c:url>
                        <a class="page-link" href="${prevPageUrl}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <!-- 페이지 번호들 -->
                    <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                        <li class="page-item ${i == pi.currentPage ? 'active' : ''}">
                            <c:url var="pageUrl" value="/promoBoard">
                                <c:param name="cpage" value="${i}"/>
                                <c:param name="searchKeyword" value="${param.searchKeyword}"/>
                            </c:url>
                            <a class="page-link" href="${pageUrl}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 페이지 버튼 -->
                    <li class="page-item ${pi.currentPage >= pi.maxPage ? 'disabled' : ''}">
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

    </div> <!-- .page-wrapper 닫기 -->

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/modal.jsp" /> <%-- 공통 모달 포함 경로 수정 --%>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- Custom JS for promoBoard (검색 기능) -->
    <script src="${contextPath}/resources/js/promoBoard.js"></script>
    <script src="${contextPath}/resources/js/commonModal.js"></script> <%-- 공통 모달 JS 포함 --%>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // "등록하기" 버튼 요소 가져오기
            const registerPromoButton = document.getElementById('registerPromoButton');
            // 기존 검색 관련 JavaScript 로직 제거됨 (폼 제출 방식으로 변경)

            if (registerPromoButton) {
                registerPromoButton.addEventListener('click', async function() {
                    // showCommonModal 함수 호출 (Promise 반환)
                    const confirmed = await window.showCommonModal(
                        "행사 등록 확인", // 모달 제목
                        "행사를 등록하시겠습니까?" // 모달 내용
                    );

                    if (confirmed) {
                        // 사용자가 "확인"을 눌렀을 경우, 글쓰기 페이지로 이동
                        window.location.href = '${contextPath}/promoBoard/promoWrite';
                    } else {
                        // 사용자가 "취소"를 눌렀거나 모달을 닫았을 경우, 아무것도 하지 않음
                        console.log("행사 등록 취소됨.");
                    }
                });
            }
        });
    </script>
</body>
</html>
