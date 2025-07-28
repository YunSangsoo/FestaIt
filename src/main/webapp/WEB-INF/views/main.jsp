<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<html>
<head>
<title>Festa-It</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:set var="contextPath" value="${pageContext.request.contextPath}"
	scope="application" />
<link href="${contextPath }/resources/css/mainpage.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- 메인 페이지 바디 시작 -->

	<div class="container" id="container">
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

				<div class="section-title">진행 중인 행사</div>
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

				<div class="today-title">오늘의 행사</div>

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
										<div class="org">${todayEvent.appOrg}</div>
										<div class="title event-name">[${todayEvent.eventName}]
											${todayEvent.appTitle}</div>
										<div class="date stretch">
											<fmt:formatDate value="${todayEvent.startDate}"
												pattern="yyyy.MM.dd" />
											-
											<fmt:formatDate value="${todayEvent.endDate}" pattern="yyyy.MM.dd" />
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
			<div class="notice-title">공지사항</div>
			<table class="notice-table">

			</table>

			<table class="table table-hover text-center align-middle">
				<thead class="lavender-header">
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
								<tr>
									<td>${notice.noticeId}</td>
									<td class="text-start"><a
										href="${pageContext.request.contextPath}/noticeBoard/detail?noticeId=${notice.noticeId}"
										class="text-decoration-none text-dark">
											${notice.noticeTitle} </a></td>
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

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>

	<script>
	$(".event-card")
		.on("mouseenter", function() {
			$(this).find(".EventItemHover-img").fadeOut(100);
			$(this).find(".event-info").fadeIn(300);
		})
		.on("mouseleave", function() {
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


	<script>
	function movePage(bno) {
		location.href = "${contextPath}/board/detail/${boardCode}/"+bno
		
		/* 
		A : Application( 행사 신청서 )
		P : Promotion ( 홍보 )
		R : Review ( 리뷰 )
		Q : QnA ( 문의 )
		N : Notice ( 공지 )
		U : User profile ( 프로필 이미지 )
		
		bname에 따라 
		*/
		}
     </script>


	<!-- 	<script>
		document.getElementById("banner").addEventListener("click",
				function() {
					const in1 = document.getElementById('in1');
					const result1 = document.getElementById('result1');

					$.ajax({
						url : 'member/selectOne',
						data : {
							userId : in1.value
						},
						type : 'POST',
						success : function(result) {
							result1.innerHTML = "";

							// jackson-databind를 사용하지 않았을 경우
							// 자바 객체의 toString() 메소드의 호출 결과가 넘어왔을 것
							console.log(result);

							if (result["USER_ID"]) {
								//1) ul요소 생성
								const ul = document.createElement("ul"); // <ul></ul>

								//2) li요소 생성 *2개
								const li1 = document.createElement("li");
								li1.innerText = "아이디 : " + result.USER_ID;
								const li2 = document.createElement("li");
								li2.innerText = "이름  :" + result.USER_NAME;

								//3) ul에 li추가
								ul.append(li1, li2);

								//4) ul을 div에 추가
								result1.append(ul);
							}
						}
					})
				})
	</script> -->
</body>
</html>
