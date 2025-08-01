<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Festa-it - 행사 상세</title>

    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <link rel="stylesheet" href="${contextPath}/resources/css/eventDetail.css">

    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc4b58676401783f2a8902047f4150c4&libraries=services"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <script>
        var contextPath = "${contextPath}";
        var eventLocation = "${event.location}";
        var eventAppId = ${not empty event.appId ? event.appId : 'null'};
        var eventBookmarked = ${event.bookmarked ? 'true' : 'false'};
        var loginMemberUserNo = ${loginUser != null && loginUser.userNo != null ? loginUser.userNo : 0};
    </script>

</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="container">
        <c:if test="${empty event}">
            <p style="text-align: center; margin-top: 50px;">행사 정보를 찾을 수 없습니다.</p>
        </c:if>

        <c:if test="${not empty event}">
            <div class="content-wrapper">
                <aside class="left-sidebar">
                    <div class="poster-section">
                        <img src="${contextPath}/resources/images/${event.appId}_poster.png" alt="행사 포스터" class="event-poster-img">

                        <c:if test="${not empty event.website}">
                            <a href="${event.website}" target="_blank" class="homepage-link">홈페이지 바로가기</a>
                        </c:if>
                    </div>

                    <div class="map-section">
                        <div id="map" class="placeholder-box map-box"></div>
                    </div>
                </aside>

                <section class="main-content">
                    <div class="content-header">
                        <span class="category">
                            <c:choose><c:when test="${not empty event.eventCategoryName}">
                                [${event.eventCategoryName}]
                            </c:when><c:otherwise>
                                [카테고리 없음]
                            </c:otherwise></c:choose>
                        </span>

                        <div class="views-share">
                            <%-- 북마크 아이콘 표시 로직 (로그인 여부에 따라 다르게 표시) --%>
                            <c:if test="${not empty loginUser}">
                                <span>
                                    <i class="bi ${event.bookmarked ? 'bi-bookmark-star-fill' : 'bi-bookmark'}" id="bookmarkIcon" style="cursor: pointer;"></i>
                                    <span id="bookmarkText">${event.bookmarked ? '북마크됨' : '북마크'}</span>
                                </span>
                            </c:if>
                            <c:if test="${empty loginUser}">
                                <span>
                                    <i class="bi bi-bookmark" id="bookmarkIcon" style="color: #ccc; cursor: default;" title="로그인 후 사용 가능"></i>
                                    <span id="bookmarkText">북마크 (로그인 필요)</span>
                                </span>
                            </c:if>

                            <span id="shareLinkButton" style="cursor: pointer;" title="클릭하여 링크 복사">
                                <i class="bi bi-share"></i> <span>공유하기</span>
                            </span>
                        </div>
                    </div>

                    <h1 class="event-title">${event.appTitle}</h1>
                    <p class="event-date">
                        <fmt:formatDate value="${event.startDate}" pattern="yyyy년 MM월 dd일"/> -
                        <fmt:formatDate value="${event.endDate}" pattern="yyyy년 MM월 dd일"/>
                    </p>

                    <div class="detail-info-grid">
                        <div class="info-box time-box">
                            <span class="info-label">[관람 시간]</span>
                            <p class="info-value">${event.startTime} - ${event.endTime}</p>
                        </div>
                        <div class="info-box location-box">
                            <span class="info-label">[행사 장소]</span>
                            <p class="info-value">${event.location}</p>
                            <c:if test="${not empty event.locationDetail}">
                                <p class="info-value">${event.locationDetail}</p>
                            </c:if>
                            <c:if test="${not empty event.postCode}">
                                <p class="info-value">(${event.postCode})</p>
                            </c:if>
                        </div>
                    </div>

                    <div class="event-description">
                        <h2 class="section-title">행사 소개</h2>
                        <pre>${event.appDetail}</pre>
                    </div>

                    <div class="event-details-list">
                        <h2 class="section-title">상세 정보</h2>
                        <p><span class="label">[입장료]</span> ${event.appFee}</p>
                        <p><span class="label">[품목명]</span> ${event.appItem}</p>
                        <p><span class="label">[주최]</span> ${event.appHost}</p>
                        <p><span class="label">[주관처명]</span> ${event.appOrg}</p>
                        <p><span class="label">[후원사명]</span> ${event.appSponsor}</p>
                    </div>

                    <div class="contact-info">
                        <h2 class="section-title">담당자 정보</h2>
                        <p><span class="label">[담당자]</span> ${event.managerName}</p>
                        <p><span class="label">[EMAIL]</span> ${event.email}</p>
                        <p><span class="label">[TEL]</span> ${event.tel}</p>
                        <p><span class="label">[FAX]</span> ${event.fax}</p>
                    </div>
                </section>
            </div>

            <div class="bottom-buttons-wrapper">
                <div class="bottom-left-buttons">
                    <button class="btn list-btn" onclick="location.href='${contextPath}/eventBoard/list'">목록 보기</button>
                </div>
                <div class="bottom-right-buttons">
                    <sec:authorize access="hasRole('ROLE_MANAGER')">
                        <button class="btn promote-btn">게시물 홍보하기</button>
                    </sec:authorize>
                </div>
            </div>
        </c:if>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="${contextPath}/resources/js/eventDetail.js"></script>

</body>
</html>