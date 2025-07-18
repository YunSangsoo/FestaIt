<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>홍보 게시글 세부 정보</title>
    <meta charset="UTF-8">
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/promotionDetail.css"> <%-- 이 페이지 전용 CSS --%>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper">
        <div class="top-spacer"></div>

        <div class="promotion-detail-container">
            <h1 class="post-title">${promotion.promotionTitle}</h1>
            <div class="post-meta">
                <span class="post-date">작성일 : <fmt:formatDate value="${promotion.createDate}" pattern="yyyy.MM.dd HH:mm" /></span>
                <span class="post-views">
                    <i class="bi bi-eye"></i> ${promotion.readCount}
                </span>
            </div>
            <hr>

            <div class="poster-display-area">
                <%-- promotion 객체에 isPromoted 플래그와 promotionPageUrl 속성이 있다고 가정 --%>
                <c:choose>
                    <%-- isPromoted가 true이고 promotionPageUrl이 존재할 경우에만 링크를 걸어줍니다. --%>
                    <c:when test="${promotion.isPromoted and not empty promotion.promotionPageUrl}">
                        <a href="${promotion.promotionPageUrl}" target="_blank">
                            <img src="${contextPath}${promotion.posterPath}" alt="포스터 이미지" class="detail-poster-img">
                        </a>
                    </c:when>
                    <%-- 그 외의 경우에는 단순 이미지로 표시 (클릭 기능 없음) --%>
                    <c:otherwise>
                        <img src="${contextPath}${promotion.posterPath}" alt="포스터 이미지" class="detail-poster-img">
                    </c:otherwise>
                </c:choose>
                <p class="poster-placeholder-text" style="display:${empty promotion.posterPath ? 'block' : 'none'};">포스터</p>
            </div>

            <%-- ⭐⭐ 여기에 사용자가 작성한 '내용'을 표시하는 부분 추가 ⭐⭐ --%>
            <div class="post-content">
                ${promotion.content} <%-- promotion 객체에서 내용 필드 (예: content)를 가져옵니다. --%>
            </div>
            <%-- ⭐⭐ 여기까지 추가 ⭐⭐ --%>

            <div class="button-area">
                <button class="btn btn-secondary" onclick="location.href='${contextPath}/promotion'">게시판 돌아가기</button>
            </div>
        </div>

        <div class="bottom-spacer"></div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <script src="${contextPath}/resources/js/promotionDetail.js"></script>
</body>
</html>