<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>홍보 게시판</title>
    <meta charset="UTF-8">
    <%-- contextPath 설정 --%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <%-- 🌟 중요: CONTEXT_PATH 변수를 JavaScript에서 사용 가능하도록 선언 🌟 --%>
    <script>
        // 이 변수는 promotion.js에서 사용되므로, promotion.js가 로드되기 전에 선언되어야 합니다.
        const CONTEXT_PATH = "${contextPath}";
    </script>

    <%-- CSS 파일 연결 --%>
    <link rel="stylesheet" href="${contextPath}/resources/css/promotion.css">

    <%-- Noto Sans KR 폰트 CDN 연결 (폰트 깨짐 방지 및 가독성 향상) --%>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <%-- 공통 헤더 포함 --%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper">
        <div class="top-spacer"></div>

        <div class="board-header-section">
            <div class="search-bar-area">
                <div class="search-wrapper">
                    <input type="text" placeholder="search" class="search-input">
                    <button class="search-button">
                        <img src="${contextPath}/resources/images/search_icon.png" alt="Search">
                    </button>
                </div>
            </div>
            <div class="register-button-area">
                <%-- 🌟 수정: 등록하기 버튼에 id 추가 🌟 --%>
                <button class="register-promo-btn" id="openRegisterModalBtn">등록하기</button>
            </div>
            <hr class="section-divider">
        </div>

        <div class="promotion-container" id="postGrid">
            <%-- JavaScript가 동적으로 12개의 게시물을 여기에 추가할 것입니다. --%>
        </div>

        <div class="pagination">
            <a href="#">&lt;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">...</a>
            <a href="#">10</a>
            <a href="#">&gt;</a>
        </div>

    </div>

    <%-- 🌟 추가: 모달창 HTML 구조 (</body> 닫는 태그 바로 위에 배치) 🌟 --%>
    <div id="registerModal" class="modal"> <div class="modal-content">
            <span class="close-button">&times;</span>
            <p>행사를 등록하시겠습니까?</p> <div class="modal-buttons">
                <button id="confirmRegisterBtn" class="modal-button confirm">확인</button>
                <button id="cancelRegisterBtn" class="modal-button cancel">취소</button>
            </div>
        </div>
    </div>

    <%-- JavaScript 파일 연결 --%>
    <script src="${contextPath}/resources/js/promotion.js"></script>

    <%-- 공통 푸터 포함 --%>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>