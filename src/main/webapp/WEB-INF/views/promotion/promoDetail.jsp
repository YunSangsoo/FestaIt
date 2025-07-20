<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${promo.promoTitle} - 홍보 상세 페이지</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextPath}/resources/css/promoDetail.css"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <script>
        const CONTEXT_PATH = "${contextPath}"; // JavaScript에서 contextPath 사용을 위함
    </script>
</head>
<body>
    <%-- 공통 헤더 포함 --%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper">
        <div class="top-spacer"></div>

        <div class="promo-detail-section">
            <h1 class="promo-title">${promo.promoTitle}</h1>

            <div class="promo-meta-info">
                <span class="meta-item">작성일 : <fmt:formatDate value="${promo.promoDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                <span class="meta-item views">
                    <i class="bi bi-eye-fill"></i> ${promo.promoViews} </span>
            </div>
            <hr>

            <div class="promo-poster-area">
                <c:choose>
                    <c:when test="${not empty promo.posterPath}">
                        <img src="${contextPath}${promo.posterPath}" alt="홍보 포스터" class="promo-poster-img">
                    </c:when>
                    <c:otherwise>
                        <div class="no-poster-placeholder">
                            <i class="bi bi-image"></i> 포스터 이미지가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="promo-content-area">
                <p>[${promo.promoWriter}]님(이) 여러분을 초대합니다!</p>
                <p>${promo.promoContent}</p>

                <div class="event-info-box">
                    <h3>- 행사 정보 -</h3>
                    <p>• **일시**: [날짜 및 시간]</p> <p>• **장소**: [장소명 및 주소]</p> <p>• **대상**: [참가 대상 - 예: 누구나, 대학생, 직장인 등]</p> <p>• **참가비**: [무료 / 유료 - 금액 기재]</p> <p>• **문의**: [연락처 또는 이메일]</p> <h4>• **주요 프로그램**</h4>
                    <ul>
                        <li>[프로그램 1 간단 설명]</li> <li>[프로그램 2 간단 설명]</li>
                    </ul>
                </div>

                <p class="promo-closing-ment">참가자 전원에게 [기념품/경품/간식 등]도 드립니다!<br>많은 관심과 참여 부탁드립니다~^^</p>
            </div>

            <div class="button-area">
                <c:if test="${promo.isPromoted == 'Y' && not empty promo.promotionPageUrl}">
                    <button type="button" class="btn btn-primary promo-button" onclick="window.open('${promo.promotionPageUrl}', '_blank');">게시물 보러가기</button>
                </c:if>
                <button type="button" class="btn btn-secondary promo-button" onclick="location.href='${contextPath}/promotion/list';">게시판 돌아가기</button>
            </div>
        </div>
    </div>

    <%-- 공통 모달 및 푸터 포함 (필요시) --%>
    <%@ include file="/WEB-INF/views/common/modal.jsp" %>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <script src="${contextPath}/resources/js/commonModal.js"></script> <script src="${contextPath}/resources/js/promoDetail.js"></script> </body>
</html>