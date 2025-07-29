<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/loginst.css" rel="stylesheet" />
<title>Insert title here</title>
</head>

	
<body>
    <div class="loginpage">
        <div class="main">
            <div class="tabs">
                <div class="tab active" data-tab-target="#tab1">
                    <p>개인</p>
                </div>
                <div class="tab" data-tab-target="#tab2">
                    <p>사업자</p>
                </div>
            </div>
        </div>

        <div class="content">
            <!-- 개인 로그인 -->
            <div id="tab1" data-tab-content class="items active">
                <div class="container">
                    <h2 style="font-family: Georgia, 'Times New Roman', Times, serif; font-size: 40px; color: #6A1B9A;" >Login</h2>
                    <form method="post" action="${pageContext.request.contextPath}/user/login/" id="login-form1">
                        <div class="login_input">
                            <input type="text" name="userId" placeholder="아이디를 입력해주세요." required />
                            <input type="password" name="userPwd" required placeholder=" 비밀번호를 입력해주세요." maxlength="15" />
                            
                            <button class="btn-idpw" type="button" onclick="location.href='아이디찾기.html'">ID/PW찾기</button>
                        </div>
                        <button class="bt1" type="submit"><span class="tx1">로그인</span></button>
                    </form>
                    <a href="/festait/join" class="bt2">회원가입</a>
                </div>
            </div>

            <!-- 사업자 로그인 -->
            <div id="tab2" data-tab-content class="items">
                <div class="container">
                    <h2 style="font-family: Georgia, 'Times New Roman', Times, serif; font-size: 40px; color: #6A1B9A;">Official</h2>
                    <h2 style="font-family: Georgia, 'Times New Roman', Times, serif; font-size: 40px; color: #6A1B9A;">Login</h2>
                    <form method="post" action="${pageContext.request.contextPath}/login" id="login-form1">
                        <div class="login_input">
                            <input type="text" name="id" placeholder=" ID" required />
                            <input type="password" name="passwd" required placeholder=" PASSWORD" maxlength="15" />
                            <button class="btn-idpw" type="button" onclick="location.href='아이디찾기.html'">ID/PW찾기</button>
                        </div>
                        <button class="bt1" type="submit"><span class="tx1">로그인</span></button>
                    </form>

                    <form method="get" action="${pageContext.request.contextPath}/user/join2">
                                        <a href="/festait/join" class="bt2">회원가입</a>
                    </form>
                </div>
            </div>
        </div>
    </div>


<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
</body>

</html>