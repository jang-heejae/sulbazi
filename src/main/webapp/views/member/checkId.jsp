<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
     @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
        body {
            background-color: #20290E;
            color: white;
        }
        .logo_text a {
            font-family: "Irish Grover", system-ui;
            font-weight: 400;
            color: rgb(255, 140, 9);
            font-size: 96px;
            font-weight: bolder;
        }
        hr {
            margin-left: 8px;
            width: 371px;
        }
        .inp {
            width: 100%;
        }
        a {
            text-decoration: none;
            color: white;
        }
        #loginBox {
            position: absolute;
            top: 200px;
            left: 800px;
        }
        button {
            width: 300px;
            height: 50px;
            background-color: #E98D1C;
            border-radius: 8px;
            color: white;
            font-size: 20px;
            margin-left: 8%;
            margin-top: 1%;
            font-weight: bolder;
        }
        input[class="inp"] {
            width: 300px;
            height: 40px;
            border-radius: 8px;
            margin-left: 3%;
            margin-top: 1%;
        }
        h2, h3 {
            color: white;
            margin-left: 23%;
            font-size: 20px;
            width: 500px;    
        }
        .aa, .bb {
            display: none;
        }
        .check {
            position: relative;
            top: 10;
            left: 40;
        }
		.result{
			margin-left: 28%;
			font-weight: bolder;
			font-size: 18px;
		}
		.error{
			margin-left: 18%;
		}
		.hi{
			margin-left: 17%;
		}
</style>
</head>
<body>
    <div id="loginBox">
        <div class="logo_text">
            <a href="./#">SULBAZI</a>
        </div>
        <hr/>
        
        <h2>아이디 찾기 결과</h2>

        <!-- 일반 사용자 아이디 표시 -->
        <c:if test="${not empty user_id}">
            <div class="result">
                <p>${user_id}</p>
            </div>
        </c:if>

        <!-- 매장 사용자 아이디 표시 -->
        <c:if test="${not empty store_id}">
            <div class="result">
                <p>${store_id}</p>
            </div>
        </c:if>

        <!-- 아이디를 찾을 수 없을 때의 에러 메시지 -->
        <c:if test="${empty user_id and empty store_id}">
            <p class="error">아이디를 찾을 수 없습니다.</p>
        </c:if>

        <br/>
		<button type="submit" onclick="location.href='login.go'" >로그인 페이지로 돌아가기</button>
</body>
</html>
