<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<title>행사 - Calendar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:set var="contextPath" value="${pageContext.request.contextPath}"
	scope="application" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${contextPath}/resources/js/event/calendar.js"></script>
<link href="${contextPath}/resources/css/eventboard.css"
	rel="stylesheet">


<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">




<style>
/* 공지 작성 버튼 스타일 */
a.btn.lavender-btn {
	background-color: #b481d9;
	color: white;
	border: 1px solid #a069cb;
}

a.btn.lavender-btn:hover {
	background-color: #a069cb;
	border-color: #904ebc;
}

/* 테이블 헤더 스타일 */
thead.lavender-header th {
	background-color: #e6ccff;
	color: #5E2B97;
}

.btn.white-btn {
	background-color: #ffffff;
	color: black;
	border: 1px solid #000000;
}

.btn.white-btn:hover {
	background-color: #ea870e;
	border-color: #ffffff;
	color: #ffffff;
}

.btn.white-btn:active {
	/* -------------------------------------------------------클릭했을 때 색 */
	background-color: #ea870e;
	border-color: #000000;
	color: #000000;
}
</style>
</head>

<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<c:if test="${not empty param}">
		<c:set var="searchParam"
			value="&eventCode=${param.eventCode}&region=${param.region}&keyword=${param.keyword}&startDate=${param.startDate}&endDate=${param.endDate}" />
	</c:if>

	<div class="container" id="container">
		<h2 class="fw-bold">행사 일정</h2>

		<!-- 검색 영역 -->
		<form:form modelAttribute="eventSearch"
			action="${pageContext.request.contextPath}/eventBoard/calendar"
			method="get">
			<div class="search-section">
				<div class="search-grid date">
					<div class="search-option">기간</div>
					<div class="flex-area stretch date-btns">
						<button class="btn btn-light rounded-pill px-3 btn-date"
							type="button" id="btn-search" data-period="7">일주일</button>
						<button class="btn btn-light rounded-pill px-3 btn-date"
							type="button" id="btn-search" data-period="30">1개월</button>
						<button class="btn btn-light rounded-pill px-3 btn-date"
							type="button" id="btn-search" data-period="90">3개월</button>
						<button class="btn btn-light rounded-pill px-3 btn-date"
							type="button" id="btn-search" data-period="180">6개월</button>
					</div>
					<div class="flex-area stretch dateInput">
						<form:input type="text" path="startDate"
							class="form-control dateInput" id="startDate"
							placeholder="행사 시작일" value="${param.startDate}" />
						<div>-</div>
						<form:input type="text" path="endDate"
							class="form-control dateInput" id="endDate" placeholder="행사 종료일"
							value="${param.endDate}" />
					</div>
				</div>

				<div class="v-line"></div>

				<div class="search-grid right">
					<div class="flex-area stretch">
						<div class="search-option">검색어</div>

						<form:select path="region" name="region">
							<option value="" selected>전국</option>
							<option value="seoul"
								${param.region eq 'seoul' ? 'selected' : ''}>서울시</option>
							<option value="incheon"
								${param.region eq 'incheon' ? 'selected' : ''}>인천시</option>
							<option value="gyeonggi"
								${param.region eq 'gyeonggi' ? 'selected' : ''}>경기도</option>
							<option value="gangwon"
								${param.region eq 'gangwon' ? 'selected' : ''}>강원도</option>
							<option value="chungcheong"
								${param.region eq 'chungcheong' ? 'selected' : ''}>충청도</option>
							<option value="jeonla"
								${param.region eq 'jeonla' ? 'selected' : ''}>전라도</option>
							<option value="gyeongsang"
								${param.region eq 'gyeongsang' ? 'selected' : ''}>경상도</option>
							<option value="jeju" ${param.region eq 'jeju' ? 'selected' : ''}>제주도</option>
						</form:select>

						<input type="search" name="keyword" value="${param.keyword}"
							class="form-search" />
						<button type="submit" class="btn white-btn small-btn">검색</button>
					</div>

					<div class="flex-area stretch">
						<div class="search-option">카테고리</div>



						<button
							class="btn btn-light rounded-pill px-3 btn-category ${param.eventCode.contains('L') ? 'selected active' : ''}"
							type="button" id="btn-search" value="L">지역행사</button>
						<button
							class="btn btn-light rounded-pill px-3 btn-category ${param.eventCode.contains('F') ? 'selected active' : ''}"
							type="button" id="btn-search" value="F">박람회</button>
						<button
							class="btn btn-light rounded-pill px-3 btn-category ${param.eventCode.contains('E') ? 'selected active' : ''}"
							type="button" id="btn-search" value="E">전시회</button>
						<button
							class="btn btn-light rounded-pill px-3 btn-category ${param.eventCode.contains('O') ? 'selected active' : ''}"
							type="button" id="btn-search" value="O">기타</button>

						<input type="hidden" name="eventCode" id="eventCode"
							value="${param.eventCode}" />

						<!-- 권한 부여 후 북마크 설정 추가해야 함 ============================================================ -->

						<%-- 
							<form:checkbox path="bookmark" name="bookmark-check" class="bookmark-check"/>
							 --%>

						<input type="checkbox" name="bookmark-check"
							class="bookmark-check" />
						<div class="search-option bookmark">북마크한 행사</div>
					</div>

				</div>
			</div>
		</form:form>



		<div class="flex-area result-inform">
			<div class="flex-area view-format flex-center">
				<a href="${pageContext.request.contextPath}/myEventApp"
					class="btn lavender-btn">행사 신청 현황</a>
				<!-- 경로 수정 필요, 권한 부여 시 a 태그만 hide -->
			</div>

			<div class="flex-area view-format">
				<a class="view-button list"
					href="${pageContext.request.contextPath}/eventBoard/list/#;">리스트형</a>
				<div class="v-line"></div>
				<a class="view-button calendar"
					href="${pageContext.request.contextPath}/eventBoard/calendar">캘린더형</a>
			</div>
		</div>


		<div id="calendar"></div>

		<div class="event-hover-thumbcard" id="event-hover-thumbcard">
			<a href="${pageContext.request.contextPath}/eventBoard/detail?appId=${event.appId}"
				class="text-decoration-none text-dark">
				<div class="event-info-c" id="event-info">
					<div class="rel">
						<div class="tag" id="tag">${event.eventName}카테고리</div>
						<img class="thumbcard-img" id="thumbcard-img"
							onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
					</div>
					<div class="event-name-thumb" id="event-name-thumb">행사이름</div>
					<div class="event-org" id="event-org">[주최]</div>
					<div class="date" id="date"></div>
				</div>
			</a>
		</div>
	</div>




	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');
			var today=new Date();
			
			const eventList = [
			   <c:forEach var="event" items="${eventList}" varStatus="status">
			     {
			       title: '${event.appTitle}', // 제목
			       start: '<fmt:formatDate value="${event.startDate}" pattern="yyyy-MM-dd" />',
			       end: '<fmt:formatDate value="${event.endDate}" pattern="yyyy-MM-dd 00:01:00" />',
			       url: '${pageContext.request.contextPath}/eventBoard/detail?appId=${event.appId}',
			       extendedProps: {
			       	appId: '${event.appId}',
			           eventName: '${event.eventName}',
			           appOrg: '${event.appOrg}',
			           thumb: '${not empty event.posterImage.changeName ? pageContext.request.contextPath.concat(event.posterImage.changeName) : ""}',
			           startDateText: '<fmt:formatDate value="${event.startDate}" pattern="yyyy.MM.dd" />',
			           endDateText: '<fmt:formatDate value="${event.endDate}" pattern="yyyy.MM.dd" />'
			         }
			     }<c:if test="${!status.last}">,</c:if>
			   </c:forEach>
			 ];

			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prevYear,prev',
					center : 'title',
					right : 'next,nextYear'
				},
				initialDate : today,
				navLinks : true, // can click day/week names to navigate views
				editable : true,
				dayMaxEvents : true, // allow "more" link when too many events
				events : eventList,
				eventDidMount: function (info) {
					
					const eventEl = info.el;
					
					eventEl.addEventListener('mouseenter', function () { // mousemove도 소용 없음...
						const eventName = info.event.extendedProps.eventName;
						const title = info.event.title;
						const appOrg = info.event.extendedProps.appOrg;
						const startDateText = info.event.extendedProps.startDateText;
						const endDateText = info.event.extendedProps.endDateText;
						const thumb = info.event.extendedProps.thumb;
						
						console.log("이벤트 정보:", title, startDateText, eventName); // 각 값이 비어 있는지 확인
						console.log("typeof title:", typeof title, "| title 값:", title); // string 맞음
						
						
						document.getElementById("tag").textContent = `\${eventName}`;
						document.getElementById("event-name-thumb").textContent = `\${title}`;
						document.getElementById("event-org").textContent = `\${appOrg}`;
						document.getElementById("date").textContent = `\${startDateText} - \${endDateText}`;
						document.getElementById("thumbcard-img").src = `\${thumb}`;
					});
				}
			});
			calendar.render();
		});
	</script>


	<script
		src="<%=request.getContextPath()%>/resources/js/event/search.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/event/event.js"></script>


</body>

</html>