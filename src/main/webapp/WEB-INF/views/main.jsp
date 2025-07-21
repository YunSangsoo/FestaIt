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
							<svg aria-hidden="true" class="bd-placeholder-img "
								preserveAspectRatio="xMidYMid slice"
								xmlns="http://www.w3.org/2000/svg">
						<rect width="100%" height="100%" fill="black"></rect></svg>
						</div>

						<div class="carousel-item">
							<svg aria-hidden="true" class="bd-placeholder-img "
								preserveAspectRatio="xMidYMid slice"
								xmlns="http://www.w3.org/2000/svg">
						<rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect></svg>
							<!-- 이게 기준 컬러 -->
						</div>

						<div class="carousel-item">
							<svg aria-hidden="true" class="bd-placeholder-img "
								preserveAspectRatio="xMidYMid slice"
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

				<%-- 				<c:choose>
					<c:when test="${empty list}">
						<tr>
							<td colspan="5">게시글이 없습니다</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="${list }">
							<tr onclick="movePage(${board.boardNo})">
								<td>${board.boardNo }</td>
								<td>${board.boardTitle }</td>
								<td>${board.boardWriter}</td>
								<td>${board.count }</td>
								<td>${board.createDate }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose> --%>

				<c:forEach var="banner" items="${list}">
					<tr onclick="movePage(${board.boardNo})">
						<td>${board.boardNo }</td>
						<td>${board.boardTitle }</td>
						<td>${board.boardWriter}</td>
						<td>${board.count }</td>
						<td>${board.createDate }</td>
					</tr>
				</c:forEach>



				<!-- 
				<div class="banner">행사 배너</div>
				 -->

				<!-- 진행중인 행사 -->

				<div class="section-title">진행 중인 행사</div>
				<div class="events-grid">
					<!-- 카드 6개 -->
					<!-- 					<div class="event-card"></div>
					<div class="event-card"></div>
					<div class="event-card"></div>
					<div class="event-card"></div>
					<div class="event-card"></div>
					<div class="event-card"></div> -->

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

				<div class="today-grid">
					<!-- 6개 이상 항목 예시 -->
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처1</div>
							<div class="title">[전시] IT박람회</div>
							<div>07.15 ~ 07.17</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처2</div>
							<div class="title">[공연] 시민 음악회</div>
							<div>07.15</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처3</div>
							<div class="title">[체험] 과학놀이터</div>
							<div>07.15 ~ 07.16</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처4</div>
							<div class="title">[축제] 강릉단오제</div>
							<div>07.10 ~ 07.20</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처5</div>
							<div class="title">[푸드] 야시장 축제</div>
							<div>07.15 ~ 07.15</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처6</div>
							<div class="title">[전시] 스마트시티 체험</div>
							<div>07.15 ~ 07.20</div>
						</div>
					</div>
					<div class="today-event">
						<div class="thumb"></div>
						<div class="info">
							<div class="org">주관처7</div>
							<div class="title">오늘의 행사7</div>
							<div>07.15 ~ 07.20</div>
						</div>
					</div>
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

					<!-- 백엔드 구현 전 임시 데이터 -->

					<tr>
						<td>8</td>
						<td class="text-start" id="notice-title">------백엔드 구현 전 임시
							데이터--ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ----</td>
						<td>2025.04.13</td>
					</tr>
					<tr>
						<td>7</td>
						<td class="text-start" id="notice-title">2025년도 5월 행사 신청 안내</td>
						<td>2025.04.10</td>
					</tr>
					<tr>
						<td>6</td>
						<td class="text-start" id="notice-title">2025년도 4월 행사 신청 안내</td>
						<td>2025.03.10</td>
					</tr>
					<tr>
						<td>5</td>
						<td class="text-start" id="notice-title">(수정)2025년도 3월 행사 신청
							안내</td>
						<td>2025.02.07</td>
					</tr>
					<tr>
						<td>4</td>
						<td class="text-start" id="notice-title">(긴급) 2월 23일 XX페스티벌
							취소 안내</td>
						<td>2025.02.03</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>




	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>

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
