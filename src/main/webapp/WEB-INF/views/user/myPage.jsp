<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/myPage.css" rel="stylesheet" />
<title>마이페이지</title>
</head>

<body>
	<h2 class="hadename">마이페이지</h2>
	<div class="mypagehead" id="mypagehead">
		<h1 class="grade">
		<c:choose>
			<c:when test="${not empty manager}">
			사업자
			</c:when>
			<c:otherwise>
			개인회원
			</c:otherwise>
		</c:choose>
		</h1>
		<div type="file" class="profile" id="profileImageInput"></div>
		<input type="file" class="profile2" id="profileImageInput" accept="image/*">
		<div>
			<p class="secondname">이름 ${userInfo.userName}</p>
			<p class="idName">(아이디) ${userInfo.userId}</p>
			<p class="joinDate">가입일 ${userInfo.enrollDate}</p>

			<hr class="line">
			<p class="phone">전화번호: ${userInfo.phone}</p>
			<p class="email">이메일: ${userInfo.email}</p>
			<p class="adress">주소: ${userInfo.addr}</p>
            
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
				<div class="titlename">
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
				</div>
				<div>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
				</div>
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
				<div class="titlename">
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
					<h2 class="conname">게시물 이름</h2>
				</div>
				<div>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
					<h2 class="conname" style="text-align: right; margin-right: 30px;">작성날짜</h2>
				</div>
			</div>
		</div>
	</div>
	<br>
	<!--비밀번호찾기 모달창-->

	<!--모달 끝-->

	<!--닉변 
    <div id="modalContainer2" class="hidden2">
        <div id="modalContent2">
            <div class="nickchange2">
                <h2>닉네임 변경</h2><button id="modalCloseButton2" class="modalCloseButton2">닫기</button>
                <hr><br><br><br>
                <form id="nicknameForm" class="change-box">
                    <input type="text" id="nickname" class="change-box__input" placeholder="변경할 닉네임 입력" size="30">
                    <button type="button" class="change-box__button" id="checkDuplicateBtn">중복확인</button>
                    <br><br><br><br>
                    <input type="submit" class="commit" value="닉네임 변경">
                </form>
                <br>
                <br><br><br><br><br>
            </div>
        </div>
    </div>
    끝-->


	<button type="button" class="secessionBtn" onclick="secession()">탈퇴하기</button>
	<!--프로필사진 스크립트
	<script>
        const profileDiv = document.getElementById('profilePreview');
        const profileInput = document.getElementById('profileInput');

        profileDiv.addEventListener('click', () => {
            profileInput.click();
        });

        profileInput.addEventListener('change', function () {
            const file = this.files[0];
            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    profileDiv.style.backgroundImage = `url(${e.target.result})`;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
	-->
	<!-- 진짜 프로필 스크립 -->
	<script>
		document.getElementById("profileImageInput").addEventListener("change",function(){
			const file = this.files[0];
			if (!file) return;

			const reader = new FileReader();
			reader.onload = function (e) {
				const preview = document.getElementById("profilePreview");
				preview.style.backgroundImage = `url('${e.target.result}')`;
				preview.style.backgroundSize = 'cover';
				preview.style.backgroundPosition = 'center';
			};
			reader.readAsDataURL(file);

			const formData = new FormData();
			formData.append("profileImage",file);

			$.ajax({
				url: "/user/uploadProfile",
				type: "POST",
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
		});

	</script>
	
	<!--비번변경 모달창 여는 스크립트-->
	<!-- <script>
        const modalOpenButton = document.getElementById('modalOpenButton');
        const modalCloseButton = document.getElementById('modalCloseButton');
        const modal = document.getElementById('modalContainer');

        modalOpenButton.addEventListener('click', () => {
            modal.classList.remove('hidden');
        });

        modalCloseButton.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    </script> -->

	<!--닉네임변경 모달창 여는 스크립트
    <script>
        const modalOpenButton2 = document.getElementById('modalOpenButton2');
        const modalCloseButton2 = document.getElementById('modalCloseButton2');
        const modal2 = document.getElementById('modalContainer2');

        modalOpenButton2.addEventListener('click', () => {
            modal.classList.remove('hidden');
        });

        modalCloseButton2.addEventListener('click', () => {
            modal2.classList.add('hidden');
        });
    </script>
-->
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
</body>
</html>