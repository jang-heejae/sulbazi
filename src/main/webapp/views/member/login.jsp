<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
 	@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
 	@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	body{
		background-color: #20290E;
		color : white;
		font-family: "Yeon Sung", system-ui;
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
	#logBtn{
		width: 300px;
		height: 50px;
		background-color: #E98D1C;
		border-radius: 20px;
		color: white;
		font-size: 20px;
		font-family: "Yeon Sung", system-ui;
	}
	ul, li{
		list-style: none;
		font-size: 24px;
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
	.modal {
     display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 231px;
    height: auto;
    background-color: #fefefe;
    padding: 8px;
    border: 1px solid #888;
    border-radius: 10px;
    box-shadow: 0px 4px 8px #041d03;
    color: #041d03;
    text-align: center;
    font-family: "Yeon Sung", system-ui;
}

.modal-content {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

#closeModalBtn {
     background-color: rgb(255, 140, 9);
    color: #041d03;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin: 10px;
    font-family: "Yeon Sung", system-ui;
}

#closeModalBtn:hover {
    background-color: #20290E;
    color: white;
}
</style>
</head>
<body>
	<form action="login.do" method="post">
	<div id="loginBox">
		<div class="logo_text">
             <a href="./mainPage.go">SULBAZI</a>
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
				<li><button id="logBtn" type="submit">로그인</button></li>
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
<div id="errorModal" class="modal">
    <div class="modal-content">
        <p id="modalMessage"></p>
        <button id="closeModalBtn">확인</button>
    </div>
</div>

<script>
$(document).ready(function() {
	const msg = '${sessionScope.msg}';
	
	if(msg){
    	$('#modalMessage').text(msg); // 서버에서 전달된 msg를 모달에 설정
        $('#errorModal').show();
    }
    // 옵션 선택 여부 확인 및 폼 제출
    $('form').on('submit', function(event) {
        const optionSelected = $('input[name="option"]:checked').val();
        const id = $('input[name="id"]').val();
        const pw = $('input[name="pw"]').val();

        if (!optionSelected) {
            event.preventDefault();
            $('#modalMessage').text("옵션을 선택하세요.");
            $('#errorModal').show();
        } else if (!id || !pw) {
            event.preventDefault();
            $('#modalMessage').text("아이디와 비밀번호를 입력하세요.");
            $('#errorModal').show();
        } 
    });

    $('#closeModalBtn').click(function() {
        $('#errorModal').hide();
    });
});
</script>
<% session.removeAttribute("msg"); %>
</html>