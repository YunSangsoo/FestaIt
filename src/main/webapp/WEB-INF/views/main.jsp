<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page session="false"%>
<html>
<head>
<title>Festa-It</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}"
	scope="application" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${contextPath }/resources/css/mainpage.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayDate" />

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>



<style>
/* 공지 작성 버튼 스타일 */
a.btn.lavender-btn {
	background-color: #b481d9;
	color: white;
	border: 1px solid #a069cb;
	height:fit-content;
	padding: 3px 10px;
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
	
	<!-- 북마크용 데이터 -->
	<c:set var="loginUser" value="${sessionScope.loginUser}" />

	<!-- 메인 페이지 바디 시작 -->

	<div class="container" id="container">
		<div class="top-content">

			<!-- 메인 좌측 -->
			<div class="main-content">
				<!-- 홍보 배너 -->
				<div>=========데이터 연결 해야 합니다=========</div>
				<div id="myCarousel" class="carousel slide mb-6"
					data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#myCarousel"
							data-bs-slide-to="0" class="active" aria-current="true"
							aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#myCarousel"
							data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#myCarousel"
							data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>

					<div class="carousel-inner" id="banner">
						<div class="carousel-item active">
							<img
								src="https://www.coex.co.kr/wp-content/uploads/2025/06/AYP-데모데이-코엑스-전시-신청-웹배너-0619-유스프러너.png"
								class="Banner-img" alt="">
						</div>

						<div class="carousel-item">
							<img
								src="https://www.coex.co.kr/wp-content/uploads/2025/07/토스.jpg"
								class="Banner-img" alt="">
							<!-- 이게 기준 컬러 -->
						</div>

						<div class="carousel-item">
							<img
								src="https://www.coex.co.kr/wp-content/uploads/2025/07/홈페이지-일정게재-이미지.jpg"
								class="Banner-img" alt="">
						</div>
					</div>

					<button class="carousel-control-prev" type="button"
						data-bs-target="#myCarousel" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#myCarousel" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>

				<c:forEach var="banner" items="${list}">
					<tr onclick="movePage(${board.boardNo})">
						<td>${board.boardNo }</td>
						<td>${board.boardTitle }</td>
						<td>${board.boardWriter}</td>
						<td>${board.count }</td>
						<td>${board.createDate }</td>
					</tr>
				</c:forEach>


				<!-- 진행중인 행사 -->

				<div class="title-area">
					<a
						href="${pageContext.request.contextPath}/eventBoard/list?startDate=${todayDate}"
						class="text-decoration-none text-dark section-title">
						<div class="section-title">진행 중인 행사</div>
					</a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="${pageContext.request.contextPath}/myEventApp"
							class="btn lavender-btn">행사 관리</a>
					</sec:authorize>
					
				</div>
				<div class="events-grid">


					<c:choose>
						<c:when test="${not empty eventList}">
							<c:forEach var="event" items="${eventList}">
								<div class="event-card" id="event-card">
									<a
										href="${pageContext.request.contextPath}/eventBoard/detail?appId=${event.appId}"
										class="text-decoration-none text-dark">
										<div class="event-info" id="event-info">
											<div class="tag">${event.eventName}</div>
											<div class="event-name">${event.appTitle}</div>
											<div class="date">
												<fmt:formatDate value="${event.startDate}"
													pattern="yyyy.MM.dd" />
												-
												<fmt:formatDate value="${event.endDate}"
													pattern="yyyy.MM.dd" />
											</div>
											<div>지역: ${event.region}</div>
											<div>주최: ${event.appOrg}</div>
										</div> <img
										<%-- 
										src="${not empty eventApplication.posterImage.changeName ? pageContext.request.contextPath.concat(eventApplication.posterImage.changeName) : ''}"
										 --%>
										src="https://www.coex.co.kr/wp-content/uploads/2025/06/AYP-데모데이-코엑스-전시-신청-웹배너-0619-유스프러너.png"
										class="EventItemHover-img" alt="">
									</a>
									
									
									<div class="bookmark ${event.bookmarkCheck eq 'on' ? 'selected' : ''}"
										data-app-id="${event.appId}" <sec:authorize access="isAuthenticated()">data-user-no = "<sec:authentication property='principal.userNo'/>" </sec:authorize>">
											<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"
												fill="#ea870e" class="bi bi-bookmark" viewBox="0 0 16 16">
											  <path fill-rule="evenodd"/>
											</svg>
									</div>
									

									
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div>등록된 행사 게시물이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 오늘의 행사 -->
			<div class="today-section">

				<a
					href="${pageContext.request.contextPath}/eventBoard/list?startDate=${todayDate}&endDate=${todayDate}"
					class="text-decoration-none text-dark section-title">
					<div class="today-title">오늘의 행사</div>
				</a>

				<div class="today-grid">

					<c:choose>
						<c:when test="${not empty todayEventList}">
							<c:forEach var="todayEvent" items="${todayEventList}">

								<a
									href="${pageContext.request.contextPath}/eventBoard/detail?appId=${todayEvent.appId}"
									class="text-decoration-none text-dark today-event">
									<div class="thumb">
										<img
											src="https://www.coex.co.kr/wp-content/uploads/2025/06/AYP-데모데이-코엑스-전시-신청-웹배너-0619-유스프러너.png"
											class="EventItemHover-img" alt="">
									</div>
									<div class="info">
										<div class="org">[${todayEvent.eventName}] ${todayEvent.appOrg}</div>
										<div class="title event-name">
											${todayEvent.appTitle}</div>
										<div class="date stretch">
											<fmt:formatDate value="${todayEvent.startDate}"
												pattern="yyyy.MM.dd" />
											-
											<fmt:formatDate value="${todayEvent.endDate}"
												pattern="yyyy.MM.dd" />
										</div>
									</div>
								</a>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div>오늘의 행사 게시물이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>


		</div>

		<!-- 리뷰 영역 -->

		<div class="review-section">
			<div class="review-title">실시간 리뷰 =========데이터 연결 해야
				합니다=========</div>
			<div class="review-grid">
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 1-1</strong>
						</div>
						<div class="review-content">ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>
				<!-- 👇 추가 8개 -->
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 1-2</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 1-3</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 2-1</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 2-2</strong>
						</div>
						<div class="review-content">글자수 넘치면 3줄까지만 출력하고 자동 줄임
							ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 2-3</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 3-1</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 3-2</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>


				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명 3-3</strong>
						</div>
						<div class="review-content">리뷰 내용</div>
					</div>
					<div class="review-bottom">
						<div class="rating">⭐⭐☆☆☆</div>
						<div class="create-date">2025-07-18</div>
					</div>
				</div>
			</div>
		</div>



		<!-- 공지사항 영역 -->
		<div class="notice-section">
			<a href="${pageContext.request.contextPath}/noticeBoard"
				class="text-decoration-none text-dark section-title">
				<div class="notice-title">공지사항</div>
			</a>

			<table class="notice-table">

			</table>

			<table class="table table-hover text-center align-middle notice-table">
				<thead>
					<tr>
						<th style="width: 10%;">번호</th>
						<th>제목</th>
						<th style="width: 20%;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty noticeList}">
							<c:forEach var="notice" items="${noticeList}">
								<tr style="cursor: pointer;"
									onclick="location.href='${pageContext.request.contextPath}/noticeBoard/detail?noticeId=${notice.noticeId}'">
									<td>${notice.noticeId}</td>
									<td class="text-start">${notice.noticeTitle}</td>
									<td><fmt:formatDate value="${notice.createDate}"
											pattern="yyyy.MM.dd HH:mm" /></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">등록된 공지사항이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>




	<jsp:include page="/WEB-INF/views/common/footer.jsp" />


	<script>
	$(".event-card")
		.on("mouseenter", function() {
			$(this).css("border-color","#D1C4E9");
			$(this).find(".EventItemHover-img").fadeOut(100);
			$(this).find(".event-info").fadeIn(300);
		})
		.on("mouseleave", function() {
			$(this).css("border-color","#FFFFFF");
			$(this).find(".EventItemHover-img").fadeIn(100);
			$(this).find(".event-info").fadeOut(300);
		})
		.on("mousedown", function() {
			$(this).css("background", "#f7f7f7");
		})
		.on("mouseup", function() {
			$(this).css("background", "white");
		});
	</script>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
		
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script src="${contextPath}/resources/js/event/event.js"></script>
</body>
</html>
