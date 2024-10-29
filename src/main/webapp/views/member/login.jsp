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
    	padding: 5px;
    	border-radius: 10px;
    }
    a{
        text-decoration: none;
        color: white;
        padding: 20px
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
	ul, li{
		list-style: none;
	}
	.loginBox{
		position: absolute;
   		left: -28px;
	}
	.findid{
		display: flex;
    	flex-direction: column;
    	justify-content: space-around;
    	align-items: center;
    	height: 59px;
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
		<div class="loginBox">
			<ul>
				<li><input class="inp" type="text" name="id" placeholder="아이디를 입력하세요" value=""/></li>
				<li><input class="inp" type="password" name="pw" placeholder="비밀번호를 입력하세요" value=""/></li>
			</ul>
			<ul>
				<li>
					<input type="radio" name="option" value="user_log"/>일반 회원&nbsp;
					<input type="radio" name="option" value="store_log"/>매장 회원&nbsp;
					<input type="radio" name="option" value="admin_log"/>관리자
				</li><br/>
				<li><button type="submit">로그인</button></li>
			</ul>
			<ul class="findid">
				<li>
					<a href="findid.go">아이디 찾기</a>
					<a href="findpw.go">비밀번호 찾기</a>
				</li>
				<li>
					<a href="userjoin.go">일반 회원가입</a>
					<a href="storeJoin.go">사업자 회원가입</a>
				</li>
			</ul>
		</div>
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