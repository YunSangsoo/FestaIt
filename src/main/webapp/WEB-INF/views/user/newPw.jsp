<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/newPw.css" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
    <div class="main">
        <form id="resetPassword" class="newpass" action="${pageContext.request.contextPath}/user/resetPassword" method="post">
            <h2><label>새 비밀번호</label></h2>
            <input id="password" type="password" name="newPassword" class="passtext" required>
            <small class="errMsg" id="pwMsg"></small>

            <h2><label>비밀번호 확인</label></h2>
            <input id="passwordConfirm" type="password" name="confirmPassword" class="passtext" required>
            <small class="errMsg" id="confirmMsg"></small>

            <button class="okbtn" type="submit">비밀번호 변경</button>
        </form>
    </div>


    <script>
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

            password.addEventListener('input', validatePassword);
            passwordConfirm.addEventListener('input', validatePasswordMatch);

            const form = document.getElementById("resetPassword");
            form.addEventListener("submit", (event) => {
                const pwVal = password.value;
                const confirmVal = passwordConfirm.value;

                if (!pwRegex.test(pwVal)) {
                    alert("비밀번호 형식이 올바르지 않습니다.");
                    password.focus();
                    event.preventDefault();
                    return;
                }

                if (pwVal !== confirmVal) {
                    alert("비밀번호가 일치하지 않습니다.");
                    passwordConfirm.focus();
                    event.preventDefault();
                    return;
                }
            });
        });

    </script>
</body>
</html>