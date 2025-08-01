<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/Idpw.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
    <div class="IDPW">
        <div class="main">
            <div class="tabs">
                <div class="tab active" data-tab-target="#tab1">
                    <p>아이디</p>
                </div>
                <div class="tab" data-tab-target="#tab2">
                    <p>비밀번호</p>
                </div>
            </div>
        </div>

        <div class="content">
            <!-- 아이디 찾기 -->
            <div id="tab1" data-tab-content class="items active">
                <div class="container">
                    <h2 style="font-size: 40px; color: #6A1B9A;" >아이디 찾기</h2>
                    <form method="post" id="login-form1">
                        <div class="login_input">
                            <h3>이메일을 입력해주세요</h3>
                            <input type="text" name="email" id="email_id" placeholder=" 이메일 입력" required />
                            <!-- 여기에 입력받은 이메일을 가지고 디비에서 해당 이메일을 사용하는 아이디를 출력하게 할거임 -->
                            <input type="button" onclick="sendCode(this)" class="mailbut" value="인증번호전송" data-target="id">
                            <h3>이메일 인증번호를 입력해주세요</h3>
                            <input type="text" name="checkCode" name="emailcode" id="code_id" required placeholder=" 인증번호 입력" maxlength="15" />
                            <input type="button" onclick="verifyCode(this)" class="mailbut" value="인증번호확인" data-target="id">
                        </div>
                        <div id="timer" style="display: none; margin-top: 10px; color: gray;"></div> 
                        <button id="submitbtn_id" class="bt1" type="button" onclick="findUserId()" disabled><span class="tx1">아이디찾기</span></button>
                        <!-- 근데 인증도 하게할거라 disabled 걸어서 인증해야만 버튼 누르게 할거고 버튼은 아이디를 찾아주는 기능만 할거임 인증이랑은 관계가 없지만 인증을 해야만 눌림
                        	 인증을 넣어서 뭔가 볼륨도 챙기고 간지도 챙기고 오우쉣 -->
                        <button onclick="history.back()" id="nextbtn" style="display: none;">로그인 페이지로 이동</button>	
                        <!-- history.back으로 뒤로가기 넣어놓음 --> 
                    </form>
                </div>
            </div>

            <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 비밀번호찾기 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
            
            <div id="tab2" data-tab-content class="items">
                <div class="container">
                    <h2 style="font-size: 40px; color: #6A1B9A;" >비밀번호 찾기</h2>
                    <form method="post" id="login-form2" action="${pageContext.request.contextPath}/user/resetPassword">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div class="login_input">
                            <h3>이메일을 입력해주세요</h3>
                            <input type="text" name="email" id="email_pw" placeholder=" 이메일 입력" required />
                            
                            <input type="button" onclick="sendCode(this)" class="mailbut" value="인증번호전송" data-target="pw">
                            <h3>이메일 인증번호를 입력해주세요</h3>
                            <input type="text" name="checkCode" name="emailcode" id="code_pw" required placeholder=" 인증번호 입력" maxlength="15" />
                            <input type="button" onclick="verifyCode(this)" class="mailbut" value="인증번호확인" data-target="pw">
                        </div>
                        <div id="timer" style="display: none; margin-top: 10px; color: gray;"></div> 
                         <button id="submitbtn_pw" class="bt1" type="button" onclick="showChangePw()" disabled><span class="tx1">비밀번호찾기</span></button>
							
							
                        <div id="chPw">
                            <h3>변경할 비밀번호를 입력해주세요</h3>
                            <input id="password" name="newPassword" type="password" class="pwtext" maxlength="15" required>
                            <small class="errMsg" id="pwMsg"></small>
                            <h3>비밀번호를 다시 입력해주세요</h3>
                            <input id="passwordConfirm" name="confirmPassword" type="password" class="pwtext" maxlength="15" required>
                            <small class="errMsg" id="confirmMsg"></small>
                            
                            <button class="bt2" type="submit">비밀번호 변경</button>
                        </div>
                    </form>    
                </div>
            </div>
        </div>
    </div>

	<!--비밀번호 변경 보이게하는 스크립트-->
    <script>
        function showChangePw() {
            document.getElementById("chPw").style.display = "block";
            
            const emailVal = document.getElementById("email_pw").value;
            document.getElementById("Email").value = emailVal;
        }

    </script>
	
    <!--아래부터 이메일 인증관련 코드-->
    <script>
    
		const contextPath = '${pageContext.request.contextPath}';	
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		
        let timerInterVal;

        function startTimer(duration) {
            let timeRemaining = duration;
            const timerDisplay = document.getElementById('timer'); // 타이머

            if (timerInterVal) clearInterval(timerInterVal);

            timerDisplay.style.display = 'inline-block'; // 스타일 인라인 블럭으로 표기
            updateTimerDisplay(timeRemaining, timerDisplay); 

            timerInterVal = setInterval(() => {
                timeRemaining--;
                updateTimerDisplay(timeRemaining, timerDisplay); //시간출력

                if (timeRemaining <= 0) {
                    clearInterval(timerInterVal);
                    timerDisplay.textContent = "인증시간 만료"; //카운트가 0이되면 여기 텍스트호출
                }
            }, 1000);
        }

        function updateTimerDisplay(time, element) {
        	console.log("timer start"); // 콘솔창에서 타이머가 시작했는지 확인 가능 // 여기까지는 스크립트 작동
        	if (!element) {
        		return;
        	}
        	const min = Math.floor(time / 60);
            const sec = time % 60;
            element.textContent = `남은 시간: \${min}:\${sec < 10 ? '0' + sec : sec}`; // 시간표현식
        }

		function sendCode(btn) {		
			
			const target = btn.getAttribute("data-target"); // id 또는 pw
			const emailInputId = target === "id" ? "email_id" : "email_pw";
			const email = document.getElementById(emailInputId).value.trim();
			
			if(!email) { // 텍스트창이 공백일때
				alert("이메일을 입력해주세요");
				return;
			}
			
			
			fetch(contextPath + "/email/sendCode", {
				method: "POST",
				headers: { "Content-Type": "application/json",
					[csrfHeader]: csrfToken},
				body: JSON.stringify({ email: email }),
			})
				.then((res) => res.text())
				.then((result) => {
					if (result === "ok") {
						alert("인증번호 전송완료"); // 문제없을때
                        startTimer(180); // 타이머 3분
					}else {
						alert("인증번호 전송실패"); // 실패예시는 서버상태오류나 코드 오타 확인해야함
					}
				})
				.catch((err) => {
					
					alert("서버오류발생!"); // 에러
				});
		}
		//아래서부터 인증코드 확인 함수
		
		function verifyCode(btn) {
			console.log("경과2"); // 테스트2
			
			const target = btn.getAttribute("data-target"); //여기랑 인풋에 data-target을 넣어서 이걸 쓸거다라고 잡아줘야함
			const codeInputId = target === "id" ? "code_id" : "code_pw";
			const codeInbtnId = target === "id" ? "submitbtn_id" : "submitbtn_pw";
			
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			
			const code = document.getElementById(codeInputId).value.trim();
			
			if (!code) { // 코드 텍스트창이 공백일때
				alert("인증번호를 입력해주세요");
				return;
			}
			
			fetch(contextPath + "/email/verifyCode", {
				method: "POST", // GET or Post
				headers: {"Content-Type": "application/json",
					[csrfHeader]: csrfToken},
				body: JSON.stringify({ code: code}),
			})
			.then(res => res.text())
			.then(result => {
				if (result === "success") {
					alert("인증 성공"); //굿 
					// 다른탭에서 같은 함수를 쓰기위해 수정사항
					const submitBtn = document.getElementById(codeInbtnId);
					if (submitBtn) {
						submitBtn.disabled = false;
					}else {
						console.warn("버튼을 찾을 수 없습니다: " + codeInbtnId);
					}
					// 여기까지
				} else if (result === "timeout") {
					alert("시간 초과"); // 시간초과
				} else {
					alert("인증실패"); //틀림
				}
			})
			.catch(() => alert("서버 오류발생!"));
		}
		
		</script>
		
		
		<script>
		// 이건 아이디 찾기 스크립트 db에 저장된 해당 이메일로 가입된 아이디 보여줌
			function findUserId() {
				
				console.log("경과3"); // 체크용
				const email = document.getElementById("email_id").value.trim();	// 이 함수는 id찾기에서만 사용하니까 pw은 안넣어도됨	
				$.ajax({
					url: "${pageContext.request.contextPath}/user/findIdEmail",
					method: "GET",
					contentType : "application/json; charset=UTF-8", //
					data:{ email: email},
					success: function(userId) {
						if(userId) {
							alert(`해당 이메일로 가입된 아이디: \${userId}`); // \이스케이프 사용해야 제대로 보임
							document.getElementById("nextbtn").style.display = "inline-block"; // 알럿창에서 확인 누르면 html에서 가려진 버튼 출력
						}else {
							alert("해당 이메일로 가입된 아이디가 없습니다");
						}
					},
					error: function() {
						alert("서버 오류 발생")
					}
				});
			}
		</script>
		
		<script>
		//이건 비밀번호 체크해주는 스크립트 비번이랑 비번확인 비교해서 맞는지 체크해줌
        document.addEventListener("DOMContentLoaded", () => {
            const password = document.getElementById("password");
            const passwordConfirm = document.getElementById("passwordConfirm");
            const pwMsg = document.getElementById("pwMsg");
            const confirmMsg = document.getElementById("confirmMsg");

            const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,15}$/;

        function validatePassword() {
        const pwVal = password.value;

            if (pwRegex.test(pwVal)) {
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
        });

    </script>
		
		
		<!-- 탭전환 스크립트임 -->
     	<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
</body>

</html>



