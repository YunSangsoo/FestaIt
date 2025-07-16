<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 상세 보기</title>
    <style>
        /* 여기에 행사세부페이지(1).jpg 디자인에 맞는 CSS 스타일을 추가하세요 */
        body { font-family: Arial, sans-serif; margin: 20px; }
        .event-detail-container { max-width: 800px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .event-header h1 { color: #333; margin-bottom: 10px; }
        .event-header h2 { color: #666; font-size: 1.2em; margin-bottom: 20px; }
        .event-info p { margin-bottom: 5px; }
        .event-content { margin-top: 30px; line-height: 1.6; }
        .button-group { margin-top: 30px; text-align: center; }
        .button-group button { padding: 10px 15px; margin: 0 5px; border: none; border-radius: 5px; cursor: pointer; }
        .button-group .list-btn { background-color: #007bff; color: white; }
        .button-group .promote-btn { background-color: #28a745; color: white; }
        /* 이미지와 같은 다른 요소들을 위한 스타일도 여기에 추가 */
    </style>
</head>
<body>
    <div class="event-detail-container">
        <c:if test="${empty event}">
            <p>행사 정보를 찾을 수 없습니다.</p>
        </c:if>
        <c:if test="${not empty event}">
            <div class="event-header">
                <div class="event-poster">
                    <img src="/resources/images/event/${event.appId}_poster.jpg" alt="행사 포스터" style="width:100%; max-width: 600px; height: auto; display: block; margin: 0 auto 20px;">
                </div>
                <h1>${event.appTitle}</h1> <h2>${event.appSubTitle}</h2> </div>

            <hr>

            <div class="event-info">
                <p><strong>일시:</strong>
                    <%-- <fmt:parseDate value="${event.startDate}" pattern="yyyy/MM/dd" var="sDate"/> --%>
                    <%-- <fmt:parseDate value="${event.endDate}" pattern="yyyy/MM/dd" var="eDate"/> --%>
                    <fmt:formatDate value="${event.startDate}" pattern="yyyy년 MM월 dd일"/> <%-- sDate 대신 event.startDate 직접 사용 --%>
                    <fmt:formatDate value="${event.endDate}" pattern="yyyy년 MM월 dd일"/>   <%-- eDate 대신 event.endDate 직접 사용 --%>
                    (${event.startTime} ~ ${event.endTime})
                </p>
                <p><strong>장소:</strong> ${event.location} ${event.locationDetail} (${event.postCode})</p>
                <p><strong>요금:</strong> ${event.appFee}원</p>
                <p><strong>주최:</strong> ${event.appHost}</p>
                <p><strong>주관:</strong> ${event.appOrg}</p>
                <p><strong>후원:</strong> ${event.appSponser}</p>
                <c:if test="${not empty event.website}">
                    <p><strong>홈페이지:</strong> <a href="${event.website}" target="_blank">${event.website}</a></p>
                </c:if>
                </div>

            <hr>

            <div class="event-content">
                <h3>행사 내용</h3>
                <pre>${event.appDetail}</pre>
                <c:if test="${not empty event.adminComment}">
                    <h4>관리자 코멘트</h4>
                    <pre>${event.adminComment}</pre>
                </c:if>
            </div>

            <hr>

            <div class="button-group">
                <button class="list-btn" onclick="location.href='/event/list'">목록으로</button>
                <button class="promote-btn" onclick="alert('이 게시물을 홍보합니다!');">게시물 홍보하기</button>
                </div>
        </c:if>
    </div>
</body>
</html>