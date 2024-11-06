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
		border-radius: 10px;
		color: white;
		font-size: 20px;
	}
	#revoke{
		position: absolute;
		top: 134px;
    	left: -26px;
		width: 500px;
	}
	#inquery{
		position: absolute;
		top: 215px;
    	left: 24px;
	}
</style>
</head>
<body>
	<div id="loginBox">
		<div class="logo_text">
             <a href="./mainPage.go">SULBAZI</a>
        </div>
        <hr/>
		<div id="revoke"><h2>회원님은 현재 <span style="color: red;">이용제한</span> 상태 입니다.</h2></div>
		<div id="inquery"><button type="submit" onclick="location.href='userinquery.go'">고객센터 문의하기</button></div>
	</div>
</body>
<script>

</script>
</html>