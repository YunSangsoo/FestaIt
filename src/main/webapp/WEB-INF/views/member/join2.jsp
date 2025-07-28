<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/join2.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
	
	<div class="main">
		<button class="back" onclick="history.back()">뒤로가기</button>
        <br>
        <br>
        <h2>회원가입</h2>
        
      <div>
        <h3><label for="">아이디</label></h3>
            <input class="box2" type="text" placeholder="사용하실 아이디를 입력해주세요"">
            <input class="but" type="button" value="중복확인">
        </div>
			
		
    </div>

    <div>
        <h3><label for="">비밀번호</label></h3>   
        <input type="password" id="password" class="box4" required maxlength="15" placeholder="영문 대/소문자 포함 1~15자리">
        <small class="errMsg" id="pwMsg"></small>
    </div>
     <div>
        <h3><label for="passwordConfirm">비밀번호 확인</label></h3>
        <input type="password" id="passwordConfirm" class="box4" required maxlength="15" placeholder="비밀번호 재입력">
        <small class="errMsg" id="confirmMsg"></small>    
    </div>
    <div class="form-row">
        <div class="form-group">
            <label for="name">이름</label>
            <input class="box3" type="text" id="name" name="name" />
        </div>
        <div class="form-group">
            <label for="birth">생년월일</label>
            <input class="box3" type="text" id="birth" name="birth" placeholder="ex. 990101" />
        </div>
    </div>
    <div>
        <h3><label for="">닉네임</label></h3>
            <input class="box2" type="text" placeholder="사용하실 닉네임을 입력해주세요">
            <input class="but" type="button" value="중복확인">  
    </div>
    

        <div>
            <h3><label for="">이메일</label></h3>
            <input class="box2" type="text" placeholder="이메일 입력을 입력해주세요">
            <input class="but" type="button" value="인증번호전송"> 
        </div>         
        <div>
            <h3><label for="">이메일 인증번호</label></h3>
            <input class="box2" type="text" placeholder="이메일 인증번호를 입력해주세요">
            <input class="but" type="button" value="인증번호확인">   
    </div>
    <div>
        <h3><label for="">휴대폰 번호</label></h3>
            <input class="box2" style="width: 500px;" required type="text" placeholder="전화번호 - 없이입력" maxlength="11">
    </div>
    
   
    <div>
        <h3><label for="">주소</label></h3>
            <input class="box2" type="text" placeholder="도로명주소를 입력해주세요">
            <input class="but2" type="button" value="우편번호찾기">  
    </div>
    <div>
        <h3><label for="">상세주소입력</label></h3>   
            <input type="text" id="adress2" class="box4" placeholder="상세주소를 입력해 주세요">
    </div>
    
    <div>
        <h3><label for="">사업자명</label></h3>   
        <input type="text" id="adress2" class="box4" placeholder="사업자명을 입력해주세요">
    </div>
    <div>
        <h3><label for="">사업자등록번호</label></h3>   
        <input type="text" id="adress2" class="box4" placeholder="사업자번호를 입력해주세요">
    </div>
    <br><br>
    <div>
        <input type="button" class="btn_join" value="가입하기">
    </div>
    <br>
    <br>

    <script>
            document.addEventListener('DOMContentLoaded', function () {
                const password = document.getElementById('password');
                const passwordConfirm = document.getElementById('passwordConfirm');
                const pwMsg = document.getElementById('pwMsg');
                const confirmMsg = document.getElementById('confirmMsg');

                const pwRegex = /^(?=.*[a-z])(?=.*[A-Z])[A-Za-z\d]{1,15}$/;

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

                password.addEventListener('input', validatePassword);
                passwordConfirm.addEventListener('input', validatePasswordMatch);
            });
            // 아이디 중복검사 스크립트 (이건 db연결해서 테스트 해봐야됨)
            function checkId() {
                const userId = document.getElementById('userId').value.trim();
                const idMsg = document.getElementById('idMsg');

                const idRegex = /^[a-zA-Z0-9]{4,15}$/; // 영문+숫자, 4~15자리

                if (userId === "") {
                    idMsg.textContent = "아이디를 입력하세요.";
                    idMsg.style.color = "red";
                    return;
                }

                if (!idRegex.test(userId)) {
                    idMsg.textContent = "아이디는 영문 또는 숫자 4~15자리여야 합니다.";
                    idMsg.style.color = "red";
                    return;
                }

                // db연결해서 아래부분 수정후 테스트 해봐야함
                
                if (userId.toLowerCase() === "admin") {
                    idMsg.textContent = "이미 사용 중인 아이디입니다.";
                    idMsg.style.color = "red";
                } else {
                    idMsg.textContent = "사용 가능한 아이디입니다.";
                    idMsg.style.color = "green";
                }
            }
        </script>
	
</body>
</html>