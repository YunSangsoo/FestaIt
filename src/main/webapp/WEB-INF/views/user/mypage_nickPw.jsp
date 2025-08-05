<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/nickPw.css" rel="stylesheet" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
</head>
<body>
    <div class="IDPW">
        <div class="main">
            <div class="tabs">
                <div class="tab active" data-tab-target="#tab1">
                    <p>닉네임변경</p>
                </div>
                <div class="tab" data-tab-target="#tab2">
                    <p>비밀번호변경</p>
                </div>
            </div>
        </div>

        <div class="content">
            <!-- 닉변 -->
            <div id="tab1" data-tab-content class="items active">
                <div class="container">
                    <h2 style="font-size: 40px; color: #6A1B9A;" >닉네임변경</h2>
                    <form method="post" id="login-form1">
                        <div class="login_input">
                            <h3>변경할 닉네임을 입력해주세요</h3>
                            <input type="text" name="nickInput" id="nickInput" placeholder=" 닉네임 입력" required />
                            <input type="button" onclick="checkNick();" class="mailbut" value="중복확인" data-target="id">     
                        </div>
                        <button id="submitbtn_id" class="bt1" type="button" onclick="updateNick(); showNextBtn();"><span class="tx1">닉네임 변경</span></button>
                        
                        <button onclick="location.href='${pageContext.request.contextPath}/user/myPage'" id="nextbtn" style="display: none;">마이페이지로 이동</button>	
                    </form>
                </div>
            </div>

            <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 비밀번호찾기 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
            
            <div id="tab2" data-tab-content class="items">
                <div class="container">
                    <h2 style="font-size: 40px; color: #6A1B9A;" >비밀번호 변경</h2>
                    <form method="post" id="login-form2" action="${pageContext.request.contextPath}/user/updatePassword">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
                        <div id="chPw">
                            <h3>변경할 비밀번호를 입력해주세요</h3>
                            <input id="password" name="newPassword" type="password" class="pwtext" maxlength="15" required>
                            <small class="errMsg" id="pwMsg"></small>
                            <h3>비밀번호를 다시 입력해주세요</h3>
                            <input id="passwordConfirm" name="confirmPassword" type="password" class="pwtext" maxlength="15" required>
                            <small class="errMsg" id="confirmMsg"></small>  
                            <button class="bt2" id="changePwBtn">비밀번호 변경</button>
                        </div>
                    </form>    
                </div>
            </div>
        </div>
    </div>
		
		<script>
			// 마이페이지로 이동 버튼 보여주는함수
			function showNextBtn() {
				document.getElementById("nextbtn").style.display = "inline-block";
			}
		</script>
		
		<script>
		// 닉 중복확인 스크립트
		let usernick = $('input[name=nickInput]').val();
		const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content"); 
        
        function checkNick() {
        	
        	
        	alert("ㅇㅅㅇ");
			const nickName = $('input[name=nickInput]').val().trim();
			
			const nickRegex = /^[가-힣a-zA-Z0-9]{2,8}$/; // 닉 정규식
			
			if (nickName === "") { // 공백일때 출력할 코드
				alert("닉네임을 입력해주세요");
				nickDupChkVal = false;
				return;
			}
			// 닉네임 조건
			if (!nickRegex.test(nickName)) {
				alert("닉네임은 2~8자의 한글,영문,숫자만 사용할 수 있습니다.");
				nickDupChkVal = false;
				return;
			}
			
			// 중복확인
			$.ajax({
				url: `${pageContext.request.contextPath}/user/nickChecker`,
				type: 'POST',
				data: { nickName: nickName},
	      		beforeSend: function(xhr) {
	                if (header && token) { // 토큰이 존재하는 경우에만 헤더 추가
	                    xhr.setRequestHeader(header, token);
	                }
	            },
				success: function(data) {
					if (data.cnt > 0) { // 0이상일때
						alert("동일한 닉네임이 존재합니다.");
						nickDupChkVal = false;
					} else {
						alert("사용 가능한 닉네임입니다."); //없을때
						nickDupChkVal = true;
					}
				},
				error: function() { // 오우 쉣
					alert("중복확인 중 에러가 발생하였습니다.");
					nickDupChkVal = false;
				}
			});
		}
        
        $(document).ready(function() {
			$('input[name=nickInput]').on('input',function(){
				nickDupChkVal = false;
			});
		});
		</script>
		
		<script>
			let nickDupChkVal = false;
			// 닉 변경
			function updateNick() {
				const newNickname = document.getElementById("nickInput").value.trim();
				
				if (newNickname === "") {
					alert("닉네임을 입력해주세요");
					return;
				}
				
				$.ajax({
					url:"${pageContext.request.contextPath}/user/updateNick",
					method: "POST",
					data: { nickname: newNickname},
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function(response) {
						if (response === "success") {
							alert("닉네임이 변경되었습니다");
							window.location.href = "${pageContext.request.contextPath}/user/myPage";
						} else {
							alert("닉네임 변경에 실패했습니다");
						}
					},
					error: function() {
						alert("서버 오류가 발생했습니다.");
					}
				});
			}
		
		</script>
		
		
		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@여기까지@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		<script>
		//이건 비밀번호 체크해주는 스크립트 비번이랑 비번확인 비교해서 맞는지 체크해줌
        document.addEventListener("DOMContentLoaded", () => {
            const password = document.getElementById("password");
            const passwordConfirm = document.getElementById("passwordConfirm");
            const pwMsg = document.getElementById("pwMsg");
            const confirmMsg = document.getElementById("confirmMsg");
            const rwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,15}$/;
            const token = $("meta[name='_csrf']").attr("content");
            const header = $("meta[name='_csrf_header']").attr("content");

        function validatePassword() {
        const pwVal = password.value;

            if (rwRegex.test(pwVal)) {
                pwMsg.textContent = "사용 가능한 비밀번호입니다.";
                pwMsg.style.color = "green"; 
            } else {
                pwMsg.textContent = "영문 대/소문자를 포함한 1~15자리여야 합니다.";
                pwMsg.style.color = "red";	
            }

            validatePasswordMatch();
        }
			
            function validatePasswordMatch() {
                if (passwordConfirm.value === "") {
                    confirmMsg.textContent = "";
                    return;
                }

                if (password.value === passwordConfirm.value) {
                    confirmMsg.textContent = "비밀번호가 일치합니다.";
                    confirmMsg.style.color = "green";
                } else {
                    confirmMsg.textContent = "비밀번호가 일치하지 않습니다.";
                    confirmMsg.style.color = "red";
                }
            }
			
            password.addEventListener("input", validatePassword);
            passwordConfirm.addEventListener("input", validatePasswordMatch);  
            
            window.updatePassword = function() {
				const newPassword = password.value.trim();
				const confirmPassword = passwordConfirm.value.trim();
				
				if (!rwRegex.test(newPassword)) {
					alert("비밀번호 조건에 맞게 입력해주세요,");
					return;
				}
				
				if (newPassword !== confirmPassword) {
					alert("비밀번호가 일치하지 않습니다.");
					return;
				}
				
				$.ajax({
					url: "${pageContext.request.contextPath}/user/updatePassword",
					method: "POST",
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data: {
						newPassword: newPassword
					},
					success: function(result) {
						if(result === "success") {
							alert("비밀번호가 변경되었습니다");
							window.location.href = "${pageContext.request.contextPath}/user/myPage"
						}else {
							alert("비밀번호 변경 실패");
						}
					},
					error: function() {
						alert("서버 오류");
					}
				});
			}
            document.getElementById("changePwBtn").addEventListener("click",updatePassword);
        });


    </script>
    <script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

</body>
</html>