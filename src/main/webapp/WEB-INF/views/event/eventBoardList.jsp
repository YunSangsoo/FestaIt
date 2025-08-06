<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

<head>
<title>행사 - List</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">
<c:set var="contextPath" value="${pageContext.request.contextPath}"
	scope="application" />
<link href="${contextPath}/resources/css/eventboard.css" rel="stylesheet">
<link href="${contextPath}/resources/css/common.css" rel="stylesheet">
	
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<c:if test="${not empty param}">
		<c:set var="searchParam"
			value="&eventCode=${param.eventCode}&region=${param.region}&keyword=${param.keyword}&startDate=${param.startDate}&endDate=${param.endDate}&bookmark=${param.bookmark}" />
	</c:if>

	<!-- 북마크용 데이터 -->
	<c:set var="loginUser" value="${sessionScope.loginUser}" />
	
	<div class="container" id="container">
		<h2 class="fw-bold">행사 일정</h2>

		<!-- 검색 영역 -->
		<form:form modelAttribute="eventSearch"
			action="${pageContext.request.contextPath}/eventBoard/list"
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
							class="form-search" placeholder="search"/>
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
						
						<div class="d-flex flex-center">
						<input type="checkbox" name="bookmark" class="bookmark-check" ${param.bookmark eq 'on' ? 'checked' : ''} />
						<div class="search-option bookmark-option">북마크한 행사</div>
						</div>
						
					</div>

				</div>
			</div>

		</form:form>


		<div class="flex-area result-inform">
			<div class="flex-area view-format flex-center">
				<div class="total-num">총 ${pi.totalCount}건</div>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<a href="${pageContext.request.contextPath}/myEventApp"
						class="btn lavender-btn">행사 신청 현황</a>
					<!-- 경로 수정 필요 -->
				</sec:authorize>
			</div>

			<div class="flex-area view-format">
				<a class="view-button list"
					href="${pageContext.request.contextPath}/eventBoard/list?page=${pi.currentPage}${searchParam}#;"
					style="color:black; font-weight:bold;">리스트형</a>
				<div class="v-line"></div>
				<a class="view-button calendar"
					href="${pageContext.request.contextPath}/eventBoard/calendar?${searchParam}">캘린더형</a>
			</div>
		</div>




		<div class="event-section">
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
											<fmt:formatDate value="${event.endDate}" pattern="yyyy.MM.dd" />
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


		<!-- 페이징 영역 -->

		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">

				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${pi.currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/eventBoard/list?page=${pi.currentPage - 1}${searchParam}">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">이전</span>
						</li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
					<c:choose>
						<c:when test="${i == pi.currentPage}">
							<li class="page-item active"><span class="page-link">${i}</span>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/eventBoard/list?page=${i}${searchParam}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${pi.currentPage < pi.totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/eventBoard/list?page=${pi.currentPage + 1}${searchParam}">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">다음</span>
						</li>
					</c:otherwise>
				</c:choose>

			</ul>
		</nav>
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
		
	<script src="<%=request.getContextPath()%>/resources/js/event/search.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/event/event.js"></script>
	
	<script type="text/javascript">
	
	// 행사 카드 호버 이벤트
	$(".event-card").on("mouseenter", function() {
		$(this).css("border-color","#FFFFFF");
		$(this).find(".EventItemHover-img").fadeIn(100);
		$(this).find(".event-info").fadeOut(300);
	}).on("mouseleave", function() {
		$(this).css("border-color","#D1C4E9");
		$(this).find(".EventItemHover-img").fadeOut(100);
		$(this).find(".event-info").fadeIn(300);
	});
	
	</script>
	

</body>

</html>