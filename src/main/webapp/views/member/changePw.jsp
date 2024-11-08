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
	.error{
			margin-left: 10%;
		}
	#pwCheckMessage{
	    position: absolute;
	    top: 261px;
	    right: 157px;
	    font-size: 13;
	}
</style>
</head>
<body>
    <body>
    	<div id="loginBox">
		<div class="logo_text">
             <a href="./mainPage.go">SULBAZI</a>
        </div>
        	<hr/>
	 		<br>
	 		<h2>비밀번호 변경</h2>
			<form action="changepw.do" method="post" onsubmit="return validateForm()">
				<input type="hidden" name="findtype" value="${findtype}"/>
		        <input type="hidden" name="identifier" value="${identifier}"/>
				<c:if test="${not empty identifier}">
					<input type="password" id="newPassword" name="newPassword" class="inp" placeholder="비밀번호" required/>
					<br>
					<input type="password" id="confirmPassword" name="confirmPassword" class="inp" placeholder="비밀번호 확인" required/><span id="pwCheckMessage"></span>
			        <button type="submit" >비밀번호 변경</button>
		        </c:if>
			        <c:if test="${empty identifier}">
			            <p class="error">아이디를 찾을 수 없습니다.</p>
			            <button type="button" onclick="location.href='login.go'">로그인 페이지로 돌아가기</button>
			        </c:if>
			</form>
        </div>

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
$(document).ready(function(){
	$('#newPassword, #confirmPassword').on('keyup blur', function(){
		var password = $('#newPassword').val();
		var passwordCheck = $('#confirmPassword').val();
		var message = $('#pwCheckMessage');
		if (passwordCheck.length > 0) {
			if (password === passwordCheck) {
				message.text('비밀번호가 맞습니다.').css('color', '#39FF14');
			}else {
				message.text('비밀번호가 다릅니다.').css('color', '#FF073A');
			}
		}else {
			message.text('');
		}
	});
});
function validateForm() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    if (newPassword !== confirmPassword) {
        alert("비밀번호가 틀렸습니다.");
        return false;
    }
    alert("비밀번호가 변경되었습니다.");
    return true;
}
</script>
</html>