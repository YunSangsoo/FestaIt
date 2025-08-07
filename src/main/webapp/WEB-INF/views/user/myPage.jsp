<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="profileImageUrl" value="${empty profileImageUrl ? '/resources/img/U/default.jpg' : profileImageUrl}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link href="${pageContext.request.contextPath}/resources/css/myPage.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>마이페이지</title>
</head>

<body>
	<input class="backbtn" onclick="history.back()" type="button" value="뒤로가기">
	<h2 class="hadename">마이페이지</h2>
	<div class="mypagehead" id="mypagehead">
		<h1 class="grade">
		<c:choose>
			<c:when test="${isManager}">
			사업자
			</c:when>
			<c:otherwise>
			개인회원
			</c:otherwise>
		</c:choose>
		</h1>
		<c:if test="${ userInfo.profileImage == null}">
		<div type="file" class="profile" id="profilePreview" data-url="${profileImageUrl}"></div>
		</c:if>
		<c:if test="${ userInfo.profileImage != null}">
			<img id="profilePreview" class="profile object-fit-contain"
	            src="${pageContext.request.contextPath.concat( userInfo.profileImage.changeName )}"
	            alt="업로드된 이미지">
		</c:if>
		<div>
			<p class="secondname">이름 ${userInfo.userName}</p>
			<p class="idName">아이디 ${userInfo.userId}</p>
			<p class="joinDate">가입일 ${userInfo.enrollDate}</p>

			<hr class="line">
			<p class="phone">전화번호: ${userInfo.phone}</p>
			<p class="email">이메일: ${userInfo.email}</p>
			<p class="adress">주소: ${userInfo.addr}</p>
            

		<input type="file" class="profile2" id="profileImageInput" accept="image/*" onchange="fileChange(this)" hidden>
		<label for="profileImageInput" class="custom-file-btn">프로필 사진 선택</label>		
			<a class="changepw" id="changepw" href="${pageContext.request.contextPath}/user/mypage_nickPw">개인정보수정</a>
            
		</div>
	</div>


	<br>
	<div class="mypagebody">
		<div class="a1">
			<h2 class="title">
				<svg xmlns="http://www.w3.org/2000/svg" width="25" height="20"
					fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
                    <path
						d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1z" />
                </svg>
				북마크
			</h2>
			<hr style="width: 600px;">
			<div class="a2">
				<c:choose>
					<c:when test="${not empty bookmarkList}">
						<c:forEach var="bookmark" items="${bookmarkList}">
							<a
								href="${pageContext.request.contextPath}/eventBoard/detail?appId=${bookmark.appId}"
								class="text-decoration-none text-dark titlename">
								<div class="conname">${bookmark.appTitle}</div>
								<div class="conname" style="text-align: right; margin-right: 30px;">
									<fmt:formatDate value="${bookmark.createDate}" pattern="yyyy.MM.dd"/>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>등록한 리뷰가 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<hr>
		<div class="a1">
			<h2 class="title">
				<svg xmlns="http://www.w3.org/2000/svg" width="25" height="20"
					fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
                    <path
						d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
                    <path
						d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9 9 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.4 10.4 0 0 1-.524 2.318l-.003.011a11 11 0 0 1-.244.637c-.079.186.074.394.273.362a22 22 0 0 0 .693-.125m.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6-3.004 6-7 6a8 8 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a11 11 0 0 0 .398-2" />
                </svg>
				내가 작성한 리뷰
			</h2>
			<hr style="width: 600px;">
			<div class="a2">
				<c:choose>
					<c:when test="${not empty reviewList}">
						<c:forEach var="review" items="${reviewList}">
							<a
								href="${pageContext.request.contextPath}/eventBoard/detail?appId=${review.appId}#review-container"
								class="text-decoration-none text-dark titlename">
								<div class="conname">${review.appTitle}</div>
								<div class="conname" style="text-align: right; margin-right: 30px;">
									<fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd"/>
								</div>
							</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>등록한 리뷰가 없습니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<br>
	
	<form id="secessionForm" action="${pageContext.request.contextPath}/user/updateUserSecession" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        <!-- input type="hidden" name="userNo" value="${userInfo.userNo}" />  -->
		<button type="button" class="secessionBtn" onclick="confirmSecession()">탈퇴하기</button>
	</form>
		
	<!-- 진짜 프로필 스크립 -->
	<script>
		const token = $("meta[name='_csrf']").attr("content");
		const header = $("meta[name='_csrf_header']").attr("content"); 
	
		 function fileChange(thisFile){
		<!-- document.getElementById("profileImageInput").addEventListener("change",function(){ -->
			
			const file = thisFile.files[0];
			
			
			if (!file) return;

			const reader = new FileReader();
			reader.onload = function (e) {
				const preview = document.getElementById("profilePreview");
		       
				preview.style.backgroundImage = "url('" + e.target.result + "')";
				preview.style.backgroundSize = 'cover';
				preview.style.backgroundPosition = 'center';
			};
			
			reader.readAsDataURL(file);
			
			const formData = new FormData();
			formData.append("profileImage",thisFile.files[0]);
			
			for (const x of formData) {
				 console.log(x);
			};
				
			$.ajax({
				url: '${pageContext.request.contextPath}/user/updateProfile',
				beforeSend: function(xhr) {
	            				if (header && token) { // 토큰이 존재하는 경우에만 헤더 추가
	                    			xhr.setRequestHeader(header, token);
	                			}
	            },
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function(response) {
					alert("프로필 이미지 업로드 완료");
				},
				error: function(){
					alert("이미지 업로드 실패");
				}
			});
		};

	</script>
	
	<script>
		window.addEventListener('DOMContentLoaded', function() {
			const preview = document.getElementById('profilePreview');
			const imageUrl = priview.dataset.url;
			preview.style.backgroundImage = `url('${imageUrl}')`;
			preview.style.backgroundSize = 'cover';
			preview.style.backgroundPosition = 'center';
		});
	</script>
	
	
	<!-- 비밀번호 검사 스크립트-->
	<script>

        document.addEventListener('DOMContentLoaded', function () {
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const pwMsg = document.getElementById('pwMsg');
            const confirmMsg = document.getElementById('confirmMsg');


            const pwRegex = /^(?=.*[a-z])(?=.*[A-Z])[A-Za-z\d]{1,15}$/;

            function validatePassword() {
                const pwVal = newPassword.value;

                if (pwRegex.test(pwVal)) {
                    pwMsg.textContent = "사용 가능한 비밀번호입니다.";
                    pwMsg.style.color = "green";
                } else {
                    pwMsg.textContent = "영문 대/소문자를 포함한 1~15자리여야 합니다.";
                    pwMsg.style.color = "red";
                }

                validatePasswordMatch(); // 실시간 확인
            }

            function validatePasswordMatch() {
                if (confirmPassword.value === "") {
                    confirmMsg.textContent = "";
                    return;
                }

                if (newPassword.value === confirmPassword.value) {
                    confirmMsg.textContent = "비밀번호가 일치합니다.";
                    confirmMsg.style.color = "green";
                } else {
                    confirmMsg.textContent = "비밀번호가 일치하지 않습니다.";
                    confirmMsg.style.color = "red";
                }
            }

            newPassword.addEventListener('input', validatePassword);
            confirmPassword.addEventListener('input', validatePasswordMatch);
        });

        
        //수정버튼 눌렀을때 활성화 
		function infoDisableUpdate() {
			document.getElementById('profileImg').disabled = false;
			document.getElementById('nickName').disabled = false;
		
			document.getElementById("pwdUpdateForm").style.display = "block"; //비밀번호 변경폼 보이기
		}
	
    </script>
    <script>
    	function confirmSecession() {
    		const token = $("meta[name='_csrf']").attr("content");
    		const header = $("meta[name='_csrf_header']").attr("content"); 
			const confirmResult = confirm("정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다");
			
			if (confirmResult) {
				document.getElementById("secessionForm").submit();
				}
			}
    </script>
    
</body>
</html>