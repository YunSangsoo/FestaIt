<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">

    <%-- 부트스트랩 아이콘 CDN 추가 --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Festa-it - 행사 상세</title>

    <%-- contextPath 설정 --%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <%-- 외부 CSS 파일 연결 --%>
    <link rel="stylesheet" href="${contextPath}/resources/css/eventDetail.css">

    <%-- jQuery 라이브러리 --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <%-- 카카오맵 JavaScript API 라이브러리 로드 (필요하다면 API 키 등을 추가) --%>
    <%-- <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services"></script> --%>


    <%-- Noto Sans KR 폰트 CDN 추가 (event.css에서 사용) --%>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

    <script>
        // JSP에서 JavaScript로 필요한 변수 토스~
        var contextPath = "${contextPath}";
        var eventLocation = "${event.location}"; // LOCATION만 사용
    </script>
</head>
<body>
    <%-- 공통 헤더 포함 --%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="container">
        <c:if test="${empty event}">
            <p style="text-align: center; margin-top: 50px;">행사 정보를 찾을 수 없습니다.</p>
        </c:if>
        <c:if test="${not empty event}">
            <div class="content-wrapper">
                <aside class="left-sidebar">
                    <div class="poster-section">
                        <%-- 행사 포스터 이미지 --%>
                        <img src="${contextPath}/resources/images/${event.appId}_poster.png" alt="행사 포스터" class="event-poster-img">

                        <%-- 홈페이지 링크 (있을 경우에만 표시) --%>
                        <c:if test="${not empty event.website}">
                            <a href="${event.website}" target="_blank" class="homepage-link">홈페이지 바로가기 <span class="external-icon">↗</span></a>
                        </c:if>
                    </div>
                    <div class="map-section">
                        <%-- 지도가 표시될 영역에 ID 부여 --%>
                        <div id="map" class="placeholder-box map-box"></div> 
                    </div>
                </aside>

                <section class="main-content">
                    <div class="content-header">
                        <span class="category">[${event.appItem}]</span> <%-- 목록명으로 분류 --%>
                        <div class="views-share">
                            <span>
                                <%-- 조회수 아이콘: Bootstrap Icons (bi-eye) 사용 --%>
                                <i class="bi bi-eye"></i> 8 <%-- 실제 조회수 값은 ${event.views} 같은 방식으로 넣어주세요 --%>
                            </span>
                            <span>
                                <%-- 북마크 아이콘: Bootstrap Icons (bi-bookmark) 사용 --%>
                                <i class="bi bi-bookmark"></i> 3 <%-- 실제 북마크 수 값 넣어주세요 --%>
                            </span>
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
                            <%-- LOCATION_DETAIL과 POST_CODE는 제거되었습니다. LOCATION만 사용합니다. --%>
                            <p class="info-value">${event.location}</p>
                        </div>
                    </div>

                    <div class="event-description">
                        <h2 class="section-title">행사 소개</h2>
                        <%-- 상세 내용은 <pre> 태그로 줄바꿈 유지 --%>
                        <pre>${event.appDetail}</pre>
                    </div>

                    <div class="event-details-list">
                        <h2 class="section-title">상세 정보</h2>
                        <p><span class="label">[입장료]</span> ${event.appFee}원</p>
                        <p><span class="label">[전시품목]</span> ${event.appItem}</p>
                        <p><span class="label">[주최]</span> ${event.appHost}</p>
                        <p><span class="label">[주관]</span> ${event.appOrg}</p>
                        <p><span class="label">[후원]</span> ${event.appSponser}</p>
                    </div>

                    <%-- 담당자 정보 표시 --%>
                    <div class="contact-info">
                        <h2 class="section-title">담당자 정보</h2>
                        <p><span class="label">[담당자]</span> ${event.managerName}</p>
                        <p><span class="label">EMAIL</span> ${event.email}</p>
                        <p><span class="label">TEL</span> ${event.tel}</p>
                        <p><span class="label">FAX</span> ${event.fax}</p>
                    </div>
                </section>
            </div>

            <div class="bottom-buttons-wrapper"> 
                <div class="bottom-left-buttons">
                    <button class="btn list-btn" onclick="location.href='${contextPath}/promotion/list.do'">목록 보기</button>
                </div>
                <div class="bottom-right-buttons">
                    <button class="btn promote-btn">게시물 홍보하기</button>
                </div>
            </div>
        </c:if>
    </main>

    <%-- 공통 푸터 포함 --%>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <%-- 외부 JavaScript 파일 연결 --%>
    <script src="${contextPath}/resources/js/event.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const shareButton = document.getElementById('shareLinkButton');
            if (shareButton) {
                shareButton.addEventListener('click', function() {
                    const currentUrl = window.location.href;
                    navigator.clipboard.writeText(currentUrl).then(function() {
                        alert('링크 복사 완료'); 
                        console.log('링크 복사 성공:', currentUrl);
                    }).catch(function(err) {
                        console.error('링크 복사 실패:', err);
                        alert('링크 복사 실패');
                    });
                });
            }
        });
    </script>
</body>
</html>