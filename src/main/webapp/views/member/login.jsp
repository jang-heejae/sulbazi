<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
 	@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
	body{
		background-color: #20290E;
		color : white;
	}
	.logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: -31px;
        color: rgb(255, 140, 9);
        font-size: 96px;
        font-weight: bolder;
    }
    hr{
    	margin-left: -24px;
    	width: 371px;
    }
    .inp{
    	width: 100%;
    }
    a{
        text-decoration: none;
        color: white;
    }
	#loginBox{
		position: absolute;
		top: 200px;
		left: 800px;
	}
	button{
		width: 300px;
		height: 50px;
		background-color: #E98D1C;
		border-radius: 20px;
		color: white;
		font-size: 20px;
	}

</style>
</head>
<body>
	<form action="login.do" method="post">
	<div id="loginBox">
		<div class="logo_text">
             <a href="./#">SULBAZI</a>
        </div>
        <hr/>
	<table>
		<tr>
			<th><input class="inp" type="text" name="id" placeholder="아이디를 입력하세요" value=""/></th>
		</tr>
		<tr>
			<th><input class="inp" type="password" name="pw" placeholder="비밀번호를 입력하세요" value=""/></th>
		</tr>
		<tr>
			<td>
				<input type="radio" name="option" value="user_log"/>일반 회원
				<input type="radio" name="option" value="store_log"/>매장 회원
				<input type="radio" name="option" value="admin_log"/>관리자
			</td>
		</tr>
		<tr>
			<td><button type="submit">로그인</button></td>
		</tr>
		<tr>
			<td><a href="#">아이디 찾기</a></td>
			<td><a href="#">비밀번호 찾기</a></td>
		</tr>
		<tr>
			<td><a href="#">일반 회원가입</a></td>
			<td><a href="storeJoin.go">사업자 회원가입</a></td>
		</tr>
	</table>
	</div>
	</form>
	
</body>
<script>
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
</script>
</html>