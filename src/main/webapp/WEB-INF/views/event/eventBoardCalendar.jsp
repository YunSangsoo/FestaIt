<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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


	<div class="container" id="container">
		<h2 class="fw-bold">행사 일정</h2>

		<!-- 검색 영역 -->

		<div class="search-section">
			<div class="search-grid date">
				<div class="search-option">기간</div>
				<div class="flex-area stretch">
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">일주일</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">1개월</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">3개월</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">6개월</button>
				</div>
				<div class="flex-area stretch">
					<div>기간 선택창(행사 신청서에서 가져오기)</div>
					<%--  <div class="col-3">
            	<form:input type="text" path="startDate" class="form-control" id="startDate" placeholder="행사 시작일" value="" required="required"/>
            </div>
            
            <div class="col-3">
            	<form:input type="text" path="endDate" class="form-control" id="endDate" placeholder="행사 종료일" value="" required="required"/>
            </div>
            <div class="w-100"></div>
          <hr class="my-3 mx-3">
				</div>

			 --%>
				</div>
			</div>

			<div class="v-line"></div>

			<div class="search-grid right">
				<div class="flex-area stretch">
					<div class="search-option">검색어</div>

					<select name="region">
						<option disabled selected>전국</option>
						<option>서울시</option>
						<option>인천시</option>
						<option>경기도</option>
						<option>강원도</option>
						<option>충청도</option>
						<option>전라도</option>
						<option>경상도</option>
						<option>제주도</option>
					</select> <input type="search" class="form-search">
				</div>
				<div class="flex-area stretch">
					<div class="search-option">카테고리</div>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">지역축제</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">박람회</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">전시회</button>
					<button class="btn btn-light rounded-pill px-3" type="button"
						id="btn-search" onclick="putDate()">기타</button>
					<input type="checkbox" name="bookmark-check" class="bookmark-check" />
					<div class="search-option bookmark">북마크한 행사</div>
				</div>


				<%-- 
			
			 <form:select path="eventCode" class="form-select text-center" id="category" required="required">
                <option value="" disabled selected>행사 종류</option>
                <option value="L">지역축제</option>
                <option value="F">박람회</option>
                <option value="E">전시회</option>
                <option value="O">기타</option>
              </form:select>
              
              <form:input path="search-input" class=" form-search" type="search"></form:input>
              
			 --%>
			</div>
		</div>


		<div class="flex-area result-inform">
			<div class="flex-area view-format flex-center">
				<div class="total-num">총 "${totalNo}"건</div>
				<a href="${pageContext.request.contextPath}/myEventApp"
					class="btn lavender-btn">행사 신청 현황</a>
				<!-- 경로 수정 필요 -->
			</div>

			<div class="flex-area view-format">
				<div class="list-view">리스트형</div>
				<div class="v-line"></div>
				<div class="calendar-view">캘린더형</div>
			</div>
		</div>


		<div id="calendar"></div>


	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');
			var today=new Date();

			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prevYear,prev,next,nextYear',
					center : 'title',
					right : 'dayGridMonth,dayGridWeek'
				},
				initialDate : today,
				navLinks : true, // can click day/week names to navigate views
				editable : true,
				dayMaxEvents : true, // allow "more" link when too many events
				events : [ {
					title : 'All Day Event',
					start : today
				}, {
					title : 'Long Event',
					start : '2025-07-07',
					end : '2025-07-09'
				}, {
					title : 'Long Event',
					start : '2025-07-08',
					end : '2025-07-11'
				}, {
					title : 'Long Event',
					start : '2025-07-10',
					end : '2025-07-14'
				}, {
					groupId : 999,
					title : 'Repeating Event',
					start : '2025-07-10'
				}, {
					groupId : 999,
					title : 'Repeating Event',
					start : '2025-07-10'
				}, {
					groupId : 999,
					title : 'Repeating Event',
					start : '2025-07-10'
				}, {
					groupId : 999,
					title : 'Repeating Event',
					start : '2025-07-10'
				}, {
					groupId : 999,
					title : 'Repeating Event',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : today
				} ]
			});

			calendar.render();
		});
	</script>
</body>

</html>