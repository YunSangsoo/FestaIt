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
<link href="${contextPath }/resources/css/common.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayDate" />

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<!-- 북마크용 데이터 -->
<c:set var="loginUser" value="${sessionScope.loginUser}" />

</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<!-- 메인 페이지 바디 시작 -->

	<div class="container d-flex justify-content-between flex-wrap" id="container">
		<div class="top-content">

			<!-- 메인 좌측 -->
			<div class="main-content">
				<!-- 홍보 배너 -->
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
						<c:forEach var="promo" items="${promoList}">   
			                <div class="post carousel-item" onclick="location.href='<c:url value='/promoBoard/detail'>
			                	<c:param name='promoId' value='${promo.promoId}'/></c:url>'">
		                        <img src="${contextPath}${promo.posterImage.changeName}" alt="포스터 이미지" class="Banner-img" onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
			                </div>
			            </c:forEach>
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



				<!-- 진행중인 행사 -->

				<div class="title-area">
					<a
						href="${pageContext.request.contextPath}/eventBoard/list?startDate=${todayDate}"
						class="text-decoration-none text-dark section-title">
						<div class="section-title">진행 중인 행사</div>
					</a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a href="${pageContext.request.contextPath}/eventApp"
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
										</div> 
					                    <img src="${not empty event.posterImage.changeName ? pageContext.request.contextPath.concat(event.posterImage.changeName) : ''}" class="EventItemHover-img" onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
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
										<img src="${not empty todayEvent.posterImage.changeName ? pageContext.request.contextPath.concat(todayEvent.posterImage.changeName) : ''}" class="EventItemHover-img-thumb" onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
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
			<div class="review-title">실시간 리뷰</div>
			<div class="review-grid">
				<c:choose>
					<c:when test="${not empty reviewList}">
						<c:forEach var="review" items="${reviewList}">
							<a
								href="${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}"
								class="text-decoration-none text-dark review-card">
								
								<div class="review-profile">
								
									<c:choose>
									  <c:when test="${not empty review.profileImage.changeName}">
									    <img id="profileImage" class="profileImage ${empty review.profileImage.changeName ? 'd-none' : ''}"
						            	src="${not empty review.profileImage.changeName ? pageContext.request.contextPath.concat(review.profileImage.changeName) : ''}"
						            	width="100%" height="100%"
						            	onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
									  </c:when>
									  <c:otherwise>
									    <svg xmlns="http://www.w3.org/2000/svg" fill="gray" class="bi bi-person-square" viewBox="0 0 16 16">
										  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
										  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
										</svg>
									  </c:otherwise>
									</c:choose>
								
								</div>
								<div class="review-info">
									<div>
										<strong>${review.appTitle}</strong>
									</div>
									<div class="review-content">${review.comment}</div>
								</div>
								<div class="review-bottom">
									<div class="rating" value="${review.rating}"></div>
									<div class="create-date">
										<fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd HH:mm" />
									</div>
								</div>
							</a>
							
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>등록된 리뷰가 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>



		<!-- 공지사항 영역 -->
		<div class="notice-section">
			<a href="${pageContext.request.contextPath}/noticeBoard"
				class="text-decoration-none text-dark section-title">
				<div class="notice-title">공지사항</div>
			</a>

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
	
	
	document.addEventListener('DOMContentLoaded', function () {
	    const ratingElements = document.querySelectorAll('.rating');

	    ratingElements.forEach(function (el) {
	        const value = parseInt(el.getAttribute('value'));
	        if (!isNaN(value) && value >= 1 && value <= 5) {
	            const aCount = '⭐'.repeat(value);
	            const zCount = '☆'.repeat(5 - value);
	            el.textContent = aCount + zCount;
	        } else {
	            el.textContent = 'Invalid'; // 예외 처리
	        }
	    });
	    
        const firstItem = document.querySelector('.carousel-inner .carousel-item');
        if (firstItem) {
            firstItem.classList.add('active');
        }
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
