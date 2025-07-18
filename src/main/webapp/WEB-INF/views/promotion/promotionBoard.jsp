<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>홍보 게시판</title>
    <meta charset="UTF-8">
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <script>
        const CONTEXT_PATH = "${contextPath}";
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextPath}/resources/css/promotion.css">

    <%-- Bootstrap Icons CDN --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper">
        <div class="top-spacer"></div>

        <div class="board-header-section">
            <div class="search-bar-area">
                <div class="search-wrapper">
                    <input type="text" placeholder="search" class="search-input">
                    <button class="search-button">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>
            <div class="register-button-area">
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

    <%@ include file="/WEB-INF/views/common/modal.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <%-- ⭐⭐⭐ 바로 이 부분만 수정합니다! ⭐⭐⭐ --%>
    <script src="${contextPath}/resources/js/commonModal.js"></script> 
    <script src="${contextPath}/resources/js/promotion.js"></script>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>