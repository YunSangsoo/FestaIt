<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Festa-It</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
<link href="${contextPath }/resources/css/custom-bootstrap.css"
	rel="stylesheet">


</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- 메인 페이지 바디 시작 -->

	<div class="container" id="container">
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

				<div class="carousel-inner">
					<div class="carousel-item active">
						<svg aria-hidden="true" class="bd-placeholder-img " height="40%"
							preserveAspectRatio="xMidYMid slice" width="100%"
							xmlns="http://www.w3.org/2000/svg">
						<rect width="100%" height="100%" fill="black"></rect></svg>
					</div>

					<div class="carousel-item">
						<svg aria-hidden="true" class="bd-placeholder-img " height="40%"
							preserveAspectRatio="xMidYMid slice" width="100%"
							xmlns="http://www.w3.org/2000/svg">
						<rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect></svg>
						<!-- 이게 기준 컬러 -->
					</div>

					<div class="carousel-item">
						<svg aria-hidden="true" class="bd-placeholder-img " height="40%"
							preserveAspectRatio="xMidYMid slice" width="100%"
							xmlns="http://www.w3.org/2000/svg">
						<rect width="100%" height="100%" fill="yellow"></rect></svg>
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



			<!-- 
				<div class="banner">행사 배너</div>
				 -->

			<div class="section-title">진행 중인 행사</div>
			<div class="events-grid">
				<!-- 카드 6개 -->
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">여름 해변축제</div>
					<div>2025.07.01 ~ 07.20</div>
					<div>지역: 부산 해운대</div>
					<div>주최: 부산시</div>
				</div>
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">전통문화 박람회</div>
					<div>2025.07.10 ~ 07.30</div>
					<div>지역: 전주</div>
					<div>주최: 문화재청</div>
				</div>
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">푸드 페스티벌</div>
					<div>2025.07.12 ~ 07.18</div>
					<div>지역: 서울광장</div>
					<div>주최: 서울시</div>
				</div>
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">과학체험전</div>
					<div>2025.07.14 ~ 07.22</div>
					<div>지역: 대전</div>
					<div>주최: 국립과학관</div>
				</div>
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">밤하늘 별빛축제</div>
					<div>2025.07.01 ~ 07.31</div>
					<div>지역: 강원도</div>
					<div>주최: 환경부</div>
				</div>
				<div class="event-card">
					<div class="tag">진행중</div>
					<div class="event-name">K-POP 콘서트</div>
					<div>2025.07.15 ~ 07.17</div>
					<div>지역: 인천</div>
					<div>주최: 방송국</div>
				</div>
			</div>
		</div>

		<!-- 오늘의 행사 -->
		<div class="today-section">

			<div class="today-title">오늘의 행사</div>

			<!-- 6개 이상 항목 예시 -->
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[전시] IT박람회</div>
					<div>07.15 ~ 07.17</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[공연] 시민 음악회</div>
					<div>07.15</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[체험] 과학놀이터</div>
					<div>07.15 ~ 07.16</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[축제] 강릉단오제</div>
					<div>07.10 ~ 07.20</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[푸드] 야시장 축제</div>
					<div>07.15 ~ 07.15</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">[전시] 스마트시티 체험</div>
					<div>07.15 ~ 07.20</div>
				</div>
			</div>
			<div class="today-event">
				<div class="thumb"></div>
				<div class="info">
					<div class="title">asdfsegdfgsdf</div>
					<div>07.15 ~ 07.20</div>
				</div>
			</div>
		</div>
	</div>



	<div class="container">

		<!-- 리뷰 영역 -->

		<section class="review-section">
			<div class="review-title">실시간 리뷰</div>
			<div class="review-grid">
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐☆☆☆</div>
					</div>
				</div>
				<!-- 👇 추가 8개 -->
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐⭐☆☆</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>★★★★★</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐⭐⭐☆</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐⭐☆☆</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐☆☆☆</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>★★★★★</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐⭐⭐☆</div>
					</div>
				</div>
				<div class="review-card">
					<div class="review-profile"></div>
					<div class="review-info">
						<div>
							<strong>행사명</strong>
						</div>
						<div>리뷰 내용</div>
						<div>⭐⭐⭐☆☆</div>
					</div>
				</div>
			</div>
		</section>
		<!-- 공지사항 영역 -->
		<section class="notice-section">
			<div class="notice-title">공지사항</div>
			<table class="notice-table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
				</tr>
				<tr>
					<td>8</td>
					<td>(긴급) 5월 7일 XX페스티벌 취소 안내</td>
					<td>2025.04.13</td>
				</tr>
				<tr>
					<td>7</td>
					<td>2025년도 5월 행사 신청 안내</td>
					<td>2025.04.10</td>
				</tr>
				<tr>
					<td>6</td>
					<td>2025년도 4월 행사 신청 안내</td>
					<td>2025.03.10</td>
				</tr>
				<tr>
					<td>5</td>
					<td>(수정)2025년도 3월 행사 신청 안내</td>
					<td>2025.02.07</td>
				</tr>
				<tr>
					<td>4</td>
					<td>(긴급) 2월 23일 XX페스티벌 취소 안내</td>
					<td>2025.02.03</td>
				</tr>
			</table>
		</section>
	</div>




	<!-- 진행중인 행사 -->

	<!-- 오늘의 행사 -->

	<!-- 실시간 리뷰 -->

	<!-- 공지 사항 -->




	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
</body>
</html>
