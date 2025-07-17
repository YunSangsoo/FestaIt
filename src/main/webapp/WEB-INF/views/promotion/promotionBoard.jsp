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

    <%-- CSS 파일 연결 --%>
    <link rel="stylesheet" href="${contextPath}/resources/css/promotion.css">

    <%-- Noto Sans KR 폰트 CDN 연결 (폰트 깨짐 방지 및 가독성 향상) --%>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <%-- 공통 헤더 포함 --%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper"> <%-- 페이지 전체 내용을 감싸는 래퍼 (1160px 고정 및 중앙 정렬) --%>
        <div class="top-spacer"></div> <%-- 헤더와 검색창 사이 공간 추가 --%>

        <div class="board-header-section"> <%-- 상단 검색/등록 버튼 영역 래퍼 --%>
            <div class="search-bar-area"> <%-- 검색창 전용 컨테이너 --%>
                <div class="search-wrapper">
                    <input type="text" placeholder="search" class="search-input">
                    <button class="search-button">
                        <img src="${contextPath}/resources/images/search_icon.png" alt="Search"> <%-- 검색 아이콘 경로 (실제 경로 확인) --%>
                    </button>
                </div>
            </div>
            <div class="register-button-area"> <%-- 등록하기 버튼 전용 컨테이너 --%>
                <button class="register-promo-btn">등록하기</button>
            </div>
            <hr class="section-divider"> <%-- 검색/등록 영역과 포스터 목록 사이의 구분선 --%>
        </div>

        <div class="promotion-container" id="postGrid">
            <%-- JavaScript가 동적으로 12개의 게시물을 여기에 추가할 것입니다. --%>
        </div>

        <div class="pagination"> <%-- 페이지네이션 영역 (임시 HTML 구조) --%>
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

    </div> <%-- .page-wrapper 닫는 태그 --%>

    <%-- JavaScript 파일 연결 --%>
    <script src="${contextPath}/resources/js/promotion.js"></script>

    <%-- 공통 푸터 포함 --%>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>