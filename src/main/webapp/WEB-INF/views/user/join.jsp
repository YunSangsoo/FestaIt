<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/join.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">

<title>Insert title here</title>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<div class="main">
		<button class="back" onclick="history.back()">뒤로가기</button>
		<br> <br>
		<h2>회원가입</h2>
		
		<form method="post"
			action="${pageContext.request.contextPath}/user/join" id="joinForm"
			onsubmit="return validateForm();">
			<div>
			
				<label for="user">개인</label>
				<input name="userType" type="radio" id="user" value="개인" checked>
				<label for="comp">사업자</label>
				<input name="userType" type="radio" id="comp" value="사업자">
		
				<h3>
					<label for="">아이디</label>
				</h3>
				<input name="userId" class="box2" type="text"
					placeholder="아이디입력(5자리이상 10자리이하)" minlength="5" maxlength="10"
					onchange="dupBtnOnCheck()" required> <input
					name="dupCheckBtn" class="but" type="button" value="중복확인"
					onclick="checkId()"> <!-- 클릭시 함수실행 -->
			</div>

			<div>
				<h3>
					<label for="password">비밀번호</label>
				</h3>
				<input name="userPwd" type="password" id="password" class="box4"
					required maxlength="15" placeholder="영문 대/소문자 포함 1~15자리"> <small
					class="errMsg" id="pwMsg"></small> <!-- 텍스트 밑에 아주 귀엽게 표현가능 맘에듬 -->
			</div>

			<div>
				<h3>
					<label for="passwordConfirm">비밀번호 확인</label>
				</h3>
				<input type="password" id="passwordConfirm" class="box4" required
					maxlength="15" placeholder="비밀번호 재입력"> <small
					class="errMsg" id="confirmMsg"></small>
			</div>
			
			<div class="form-row">
				<div class="form-group">
					<label for="name" id="nameLabel">이름</label> <input name="userName" class="box3" 
						minlength="2" type="text" id="name" name="name" required/>
				</div>
				<div id="birthDiv" class="form-group">
					<label for="birth" id="birthLabel">생년월일</label> 					
					<input class="box3" type="date" id="date" name="birth" required/>
				</div>
			</div>
			
			<div>
				<h3>
					<label for="">닉네임</label>
				</h3>
				<input class="box2" name="nickName" required type="text" placeholder="닉네임입력"> 
				<input class="but" type="button" value="중복확인" onclick="checkNick()"> <!-- 함수on -->
			</div>


			<div>
				<h3>
					<label for="">이메일</label>
				</h3>
				<div style="align-items: center;">
					<input class="box2" id="email" required type="email"
						placeholder="이메일 입력" name="email"> <input class="but"
						onclick="sendCode()" type="button" value="인증번호전송"> 
				</div>
				<div>
					<h3>
						<label for="">이메일 인증번호</label>
					</h3>
					<input class="box2" id="code" required type="text"
						oninput="this.value = this.value.replace(/[^0-9]/g, '')"
						placeholder="이메일 인증번호를 입력해주세요" name="emailcode"> <input
						class="but" onclick="verifyCode()" type="button" value="인증번호확인">
				</div>

        		<div id="timer" style="display: none; margin-top: 10px; color: gray;"></div> <!-- 타이머 스타일 -->
    			</div>
				
				<div>
					<h3>
						<label for="phone" id="phoneLabel">휴대폰 번호</label>
					</h3>
					<input name="phone" class="box2" style="width: 500px;" required
						id="phone" id="phone" oninput="this.value = this.value.replace(/[^0-9]/g, '')" 
						type="text" placeholder="전화번호 - 없이입력" maxlength="11">
																		<!-- 온리 숫자만 입력가능 -->	
				</div>
				<div id="result"></div>
				<div>
					<h3>
						<label for="postCode" id="addressLabel">주소</label>
					</h3>
					<input id="postcode" class="my-add"
					 oninput="this.value = this.value.replace(/[^0-9]/g, '')"
					 required type="text" placeholder="우편번호">
					<input id="address" name="address1" required class="my-add" type="text"
						placeholder="주소"> <input class="but" type="button"
						onclick="execDaumPostcode()" value="우편번호 찾기">
				</div>
				<div>
					<h3>
						<label for="">상세주소입력</label>
					</h3>
					<input name="address2" required type="text" required id="adress2"
						class="box4">
				</div>
				
				<div>
					<h3>
						<label for="bsGrgiNum" id="bsGrgiNumText"  name="bsGrgiNumText">사업자번호</label>
					</h3>
					<input name="bsGrgiNum" required type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '')" 
					 required id="bsGrgiNum"class="box4">
				</div>
				
				<div>
					<h3>
						<label for="bsGrgiName" id="bsGrgiNameText"  name="bsGrgiNameText">사업자 상호명</label>
					</h3>
					<input name="bsGrgiName" required type="text" required id="bsGrgiName"class="box4">
				</div>
				
				<br> <br>
				<div>
					<input type="submit" class="btn_join" value="가입하기">
				</div>
		</form>
		<br>
	</div>



	<!--!!!비밀번호 검사 스크립트!!! 실수하면 고치기 힘듦 !!!!-->
	<script>
        
        let idDupChkVal = false; //아이디 중복 체크 통과 여부 값
        
        document.addEventListener('DOMContentLoaded', function () {
        const password = document.getElementById('password');
        const passwordConfirm = document.getElementById('passwordConfirm');
        const pwMsg = document.getElementById('pwMsg');
        const confirmMsg = document.getElementById('confirmMsg');

        const pwRegex = /^(?=.*[a-z])(?=.*[A-Z])[A-Za-z\d]{1,15}$/; // 조건임

        
        $('input[name="userType"]').change(function(){
        	var value = $(this).val();
        	alert("value: "+value);
        	
        	if(value == "개인") {
        		$("#bsGrgiNumText").hide();
        		$("#bsGrgiNum").hide();
        	}
        	if(value == "사업자") {
        		$("#bsGrgiNumText").show();
        		$("#bsGrgiNum").show();
        		
        	}
        	
        });
        function userTypeChange() {
        	
        }
        
        function validatePassword() {
        const pwVal = password.value;

            if (pwRegex.test(pwVal)) {
                pwMsg.textContent = "사용 가능한 비밀번호입니다.";
                pwMsg.style.color = "green"; //스크립트에서도 스타일 지정 가능함
            } else {
                pwMsg.textContent = "영문 대/소문자를 포함한 1~15자리여야 합니다.";
                pwMsg.style.color = "red";	//스크립트에서도 스타일 지정 가능함
            }

            validatePasswordMatch();
        }
			// 아래는 비번검사 스크립트
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

            password.addEventListener('input', validatePassword);
            passwordConfirm.addEventListener('input', validatePasswordMatch);
        });

		function handleSubmit(event) {
			const pwVal = password.value;
			const confirmVal = passwordConfirm.value;
			
			if (!pwRegex.test(pwVal)) {
				alert("비밀번호 형식이 올바르지 않습니다.");
				password.focus();
				return false;
			}
			
			if (pwVal !== confirmVal) {
				alert("비밀번호가 일치하지 않습니다");
				passwordConfirm.focus();
				return false;
			}
			
			return true;
		}
		password.addEventListener('input', validatePassword);
		passwordConfirm.addEventListener('input', validatePasswordMatch);
            

       //추가기능 1.아이디입력창에 아이디가 변경될때마다 중복확인 체크하는 기능
          
          
       //추가기능 2.중복확인 통과 값만 회원가입 가능하게 체크하는 기능
      
            
      function checkId(){
      	
      	let userId = $('input[name=userId]').val(); //입력한 아이디값
      	
      	$.ajax({
      		url : '${pageContext.request.contextPath}/user/idChecker',
      		<!-- url: '${pageContext.request.contextPath}/user/idChecker',			//컨트롤러 -->
      		type: 'POST',						//GET,POST인지
      		async: true,
      		data: {
      			userId: userId				//DATA필드
      		},
      		success: function(data){			//성공시
      			if(data.cnt > 0){
      				alert("동일한 아이디가 존재합니다.");
      				idDupChkVal = false;
      			// DB상 데이터 카운트가 0이상인지 아닌지 확인해서 중복인지 아닌지 확인함
      			}else{
      				alert("사용가능한 아이디입니다."); // 굿
      				idDupChkVal = true;
      			}
      		},
      		error: function(e){					// 오우 쉣
      			alert("중복확인중 에러가 발생하였습니다.");
      		}
      	});
      	
       }
       
       function validateForm() {
		if(!idDupChkVal){
			alert("아이디 중복확인을 해주세요.");
			return false; // 중복확인 안했을때
		}
		return true;
	}
        $(document).ready(function() {
			$('input[name=userId]').on('input', function() {
				idDupChkVal = false;
			});
		});

        </script>

	<script>
        <!--ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ닉 중복확인 스크립트ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ-->
        let usernick = $('input[name=nickName]').val();
        let nickDupChkVal = false
        
        function checkNick() {
        	
        	alert("ㅇㅅㅇ");
			const nickName = $('input[name=nickName]').val().trim();
			
			if (nickName === "") { // 공백일때
				alert("닉네임을 입력해주세요");
				nickDupChkVal = false;
				return;
			}
			
			$.ajax({
				url: `${pageContext.request.contextPath}/user/nickChecker`,
				type: 'POST',
				data: { nickName: nickName},
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
			$('input[name=nickName]').on('input',function(){
				nickDupChkVal = false;
			});
		});
        
        </script>

	<!--아래부터 주소검색 스크립트-->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
	//카카오 주소검색으로 가져옴
	</script> 
	<script>
	// 버튼클릭시 팝업창으로 주소검색한걸 텍스트창에 입력하는 스크립트
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
            
                    var fullAddr = data.address;
                    
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById('address').value = fullAddr;
                    
                    }
                }).open();
            }
        </script>

	<!-- 여기서부터 이메일인증코드 발송/확인 스크립트 -->
	<script>
		const contextPath = '${pageContext.request.contextPath}';	
		
		
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
        	console.log("timer start"); // 콘솔창에서 타이머가 시작했는지 확인 가능
        	if (!element) {
        		return;
        	}
        	const min = Math.floor(time / 60);
            const sec = time % 60;
            element.textContent = `남은 시간: \${min}:\${sec < 10 ? '0' + sec : sec}`; // 시간표현식
        }

		function sendCode() {		
			
			const email = document.getElementById("email").value.trim();
			
			if(!email) { // 텍스트창이 공백일때
				alert("이메일을 입력해주세요");
				return;
			}
			
			
			fetch(contextPath + "/email/sendCode", {
				method: "POST",
				headers: { "Content-Type": "application/json"},
				body: JSON.stringify({ email: email }),
			})
				.then((res) => res.text())
				.then((result) => {
					
					if (result === "ok") {
						alert("인증번호 전송완료"); // 문제없을때
						
                        startTimer(180); // 타이머 3분
					}else {
						alert("인증번호 전송실패"); //ㅈ됐을때
					}
				})
				.catch((err) => {
					
					alert("서버오류발생!"); // 진짜 ㅈ됨
				});
		}
		//아래서부터 인증코드 확인 함수
		function verifyCode() {
			const code = document.getElementById("code").value.trim();
			
			if (!code) { // 코트 텍스트창이 공백일때
				alert("인증번호를 입력해주세요");
				return;
			}
			
			fetch(contextPath + "/email/verifyCode", {
				method: "POST", // GET or Post
				headers: {"Content-Type": "application/json"},
				body: JSON.stringify({ code: code}),
			})
			.then(res => res.text())
			.then(result => {
				if (result === "success") {
					alert("인증 성공"); //굿 
				} else if (result === "timeout") {
					alert("시간 초과"); // 타임오바
				} else {
					alert("인증실패"); //틀림
				}
			})
			.catch(() => alert("서버 오류발생!")); //이건제발 안나오길
		}
		
		</script>
		<script>
		$(document).ready(function() {
			function applyUserTypeChange() {
				let userType = $('input[name="userType"]:checked').val();
				
				if (userType ==="사업자"){
							
					$('#addressLabel').text('사업장 주소');
					$('#bsGrgiNumText').show(); // 사업자번호 텍스트
					$('#bsGrgiNum').show();		// 사업자번호 인풋박스 
					$('#bsGrgiNameText').show();// 사업자명 텍스트
					$('#bsGrgiName').show(); 	// 사업자명 인풋박스
					
				}else {
					// 개인회원 선택시 원복
					
					$('#addressLabel').text('주소'); // 주소명 이름만 변경됨
					$('#bsGrgiNumText').hide();  // 사업자번호 텍스트
					$('#bsGrgiNum').hide();		 // 사업자번호 인풋박스 
					$('#bsGrgiNameText').hide(); // 사업자명 텍스트
					$('#bsGrgiName').hide();	 // 사업자명 인풋박스
				}
			}
			// 라디오 버튼 변셩시 실행 함수
			$('input[name="userType"]').change(function() {
				applyUserTypeChange();
			});
			
			applyUserTypeChange();
			
		})
		</script>
        
		<!-- 똑같이 받고 여기서 추가로 사업자번호 / 사명 / -->
		
</body>
</html>