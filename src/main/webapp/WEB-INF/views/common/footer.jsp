<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
    <style>
        /* div{border:1px solid red;} */
        #footer {
            background-color: #6A1B9A;
            width:100%;
            height:200px;
            margin:auto;
            margin-top:50px;
            /*border: 1px solid black;*/
        }
        #footer-1 {
            height:20%;
            border-top:2px solid plum;
            border-bottom:2px solid white;
            
        }
        #footer-2 {width:100%; height:80%; 
            /*border: 1px solid black;*/
        }
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color: white;
            /*border: 1px solid black;*/
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
            color: white;
            /*border: 1px solid black;*/
        }
        #p2 {text-align:center;}
    </style>
<body>
	<div id="footer">
        <div id="footer-1">
            <a href="#">뭐를 </a> | 
            <a href="#">넣어야</a> | 
            <a href="#">예쁘려나</a> | 
            <a href="#">모르겠네</a>
        </div>

        <div id="footer-2">
            <p id="p1">
                강남지원 1관 : 서울특별시 강남구 테헤란로14길 6 남도빌딩 3F<br>
                (디지털컨버전스) React & Spring 활용 자바(Java) 개발자 양성과정 30(9)<br>
                Team : Testa-it<br>
                Team Member : 윤상수 강동현 김현주 고훈 조아현 장성민
            </p>
            <p id="p2">Copyright &copy; 2025 Festa-it. All rights reserved.</p>
        </div>
    </div>
	

</body>
</html>