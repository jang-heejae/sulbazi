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
		border-radius: 8px;
		color: white;
		font-size: 20px;
    	margin-left: 3%;
		margin-top: 1%;
	}
  input[class="inp"]{
    width: 300px;
    height: 40px;
    border-radius: 8px;
    margin-left: 3%;
	margin-top: 1%;
  }
  h2, h3{
		color: white;
    margin-left: 17%;
    margin-top: -5;
    font-size: 19px;
    width: 500px;
	}
	.aa, .bb {
		display: none;
	}
	.check{
		position: relative;
		top : 10;
		left: 40;
	}
</style>
</head>
<body>
    <body>
    	<div id="loginBox">
		<div class="logo_text">
             <a href="/mainPage.go">SULBAZI</a>
        </div>
        	<hr/>
	 		<br>
	 		<h2>비밀번호 변경</h2>
			<form action="changepw.do" method="post" onsubmit="return validateForm()">
				<input type="hidden" name="findtype" value="${findtype}"/>
		        <input type="hidden" name="identifier" value="${identifier}"/>
				<input type="password" id="newPassword" name="newPassword" class="inp" placeholder="비밀번호" required/>
				<br>
				<input type="password" id="confirmPassword" name="confirmPassword" class="inp" placeholder="비밀번호 확인" required/>
		        <div id="errorMessage" style="color: red; display: none;">
		           &nbsp;&nbsp; 비밀번호가 틀렸습니다.
		        </div>
		        <button type="submit" >비밀번호 변경</button>
			</form>
        </div>
    <!-- <h2>비밀번호 변경</h2>
    <form action="changepw.do" method="post" onsubmit="return validateForm()">
        
        <div>
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" required/>
        </div>
        
        <div>
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required/>
        </div>
        
        <div id="errorMessage" style="color: red; display: none;">
            비밀번호가 틀렸습니다.
        </div>
        
        <button type="submit" >비밀번호 변경</button>
    </form> -->
    
    <script>
        function validateForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorMessage = document.getElementById('errorMessage');
            
            if (newPassword !== confirmPassword) {
                errorMessage.style.display = 'block';  // 오류 메시지 보이기
                return false;  // 폼 제출 중단
            }
            alert("비밀번호가 변경되었습니다.");  // 성공 메시지
            return true;  // 폼 제출 허용
        }
    </script>
</body>
</body>
<script>

</script>
</html>