	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
    a{
        text-decoration: none;
        color: white;
    }
    body{
        background-color: #041d03;
        height: 1800;
    }
    legend{
    	color: white;
    	font-weight: bold;
    }
    .navbar{
        z-index: 99;
        position: absolute;
        left: 360px;
        justify-items: center;
        width: 1200px;
        height: 120px;
        background-color: #041d03;
        color: rgb(255, 140, 9);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: 455px;
        color: rgb(255, 140, 9);
        font-size: 70px;
        font-weight: bolder;
    }
	.container .wrapper {
		width: 803px;
        height: auto;
        margin: 0 auto;
		background-color: #e98d1c;
		border-radius: 8px;
        text-align: center;
	}
    .wrapper{
        position: relative;
        top: 160px;
    }
	h2, h3{
		color: white;
	}
    input[type="text"], input[type="password"]{
        text-align: left;
        width: 400px;
        height: 30px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 1%;
    }
    input[name="storeid"], input[name="storenum"]{
        margin-left: 10.5%;
    }
    button{
        color: #707070;
    }
    h6{
        margin-top: 0px;
        color: white;
    }
    input[name="storetime"]{
        height: 50px;
    }
    textarea{
        width: 50%;
        height: 250px;
        border-radius: 8px;
        resize: none;
    }
    button[type="submit"]{
        width: 40%;
        height: 60px;
        position: relative;
        top: 220;
        left: 570;
        background-color: #e98d1c;
        border-radius: 8px;
        color: white;
        font-weight: 700;
        font-size: 30;
    }
    .radio-group {
        display: inline-block;
        margin-right: 10px;
    }
    fieldset {
    border: 2px solid #e98d1c; /* 테두리 색을 파란색으로 설정 */
    padding: 10px; /* 내부 여백 */
    border-radius: 5px; /* 둥근 모서리 */
	}

	legend {
	    font-weight: bold; /* legend 텍스트를 굵게 */
	    color: white; /* legend 색상 */
	}
	#idc{
    	margin-left: 10%;
    }
    #numb{
    	margin-left: 10%;
    }
    #idCheckMessage{
    	font-size: 11px;
    	margin-left: -33%;
    }
    #emailCheckMessage{
    	font-size: 11px;
    	margin-left: -33%;
    }
    #pwCheckMessage{
	    position: absolute;
	    top: 186px;
	    right: 71px;
	    font-size: 13;
	}
	.preview{
		width: 100px;
		height: 100px;
		border-radius: 100%;
	}
	.emailerr{
		position: absolute;
		top: 288px;
	    left: 614px;
	    font-size: 13px;
	}
</style>
<body>
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="./mainPage.go">SULBAZI</a>
            </div>
        </nav>
    </header>
    <form action="userJoin.do" method="post" enctype="multipart/form-data">
        <div class="container">
            <div class="wrapper">
                <h2>사용자 회원가입</h2>
                <input id="idc" type="text" name="user_id" value="" placeholder="아이디(필수)"/>&nbsp;<button type="button" id="checkIdBtn">중복확인</button>
	            <br>
	            <span id="idCheckMessage"></span>
	            <br>
                <input type="password" id="user_pw" name="user_pw" value="" placeholder="비밀번호(필수)">
                <input type="password" id="user_pwcheck" name="user_pwcheck" value="" placeholder="비밀번호 확인(필수)"><span id="pwCheckMessage"></span>
                <h6>※ 비밀번호 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</h6>
                <input id="numb" type="text" name="user_email" value="" placeholder="이메일(필수)" />
				<button type="button" id="checkEmailBtn">중복확인</button>
				<div class="emailerr">
				<span id="emailError" style="color: red; display: none;">유효한 이메일을 입력하세요.</span>
				</div>
                <br>
	            <span id="emailCheckMessage"></span>
	            <br>
                <input type="radio" name="user_gender" value="남">남
                <input type="radio" name="user_gender" value="여">여
                <br>
                <input type="text" name="user_nickname" value="" placeholder="닉네임(필수)">
                <input type="text" name="user_name" value="" placeholder="이름(필수)">
                <input type="text" name="user_birth" value="" placeholder="생년월일(필수)">
                <input type="text" name="user_phone" value="" placeholder="핸드폰번호(필수)" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                <h2>프로필 사진</h2>
                <div id="img_list"><img class="preview" src="resources/img/sulbazi.png" style="max-width: 100px; max-height: 100px; margin: 5px;"/></div>
                <input type="file" name="files" multiple="multiple" onchange="readFile(this)">
                <h2>카테고리(각 1개 선택가능(필수))</h2>
        		<fieldset>
				    <legend>주종</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 1}">
				            <input type="radio" id="category_${category.category_idx}" name=category1 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>

				<fieldset>
				    <legend>안주</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 2}">
				            <input type="radio" id="category_${category.category_idx}" name=category2 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>분위기</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 3}">
				            <input type="radio" id="category_${category.category_idx}" name=category3 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>방문목적</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 4}">
				            <input type="radio" id="category_${category.category_idx}" name=category4 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
        	</div>
        </div>
        <button type="submit" >회원가입</button>
    </form>
</body>
    <script>
	    $(document).ready(function() {
	        $('#checkIdBtn').click(function(event) {
	        	event.preventDefault();
	        	console.log("checkIdBtn 클릭됨");
	            const userId = $('input[name="user_id"]').val();
	            $.ajax({
	                type: 'POST',
	                url: 'checkid.ajax',
	                data: { user_id: userId },
	                success: function(response) {
	                    if (response.exists) {
	                        $('#idCheckMessage').text("이미 있는 아이디입니다.").css("color", "red");
	                    } else {
	                        $('#idCheckMessage').text("사용 가능한 아이디입니다.").css("color", "blue"); // 중복 메시지 초기화
	                    }
	                }
	            });
	        });
	     
		        $('#checkEmailBtn').click(function(event) {
		        	event.preventDefault();
		        	console.log("checkEmailBtn 클릭됨");
		            const userEmail = $('input[name="user_email"]').val();
		            $.ajax({
		                type: 'POST',
		                url: 'checkEmail.ajax',
		                data: { user_email: userEmail },
		                success: function(response) {
		                    if (response.exists) {
		                        $('#emailCheckMessage').text("이미 있는 이메일입니다.").css("color", "red");
		                    } else {
		                        $('#emailCheckMessage').text("사용 가능한 이메일입니다.").css("color", "blue"); // 중복 메시지 초기화
		                    }
		                }
		            });
		        });
	    
	
	        $('#profileImageInput').change(function(event) {
	            const file = event.target.files[0];
	            if (file) {
	                const reader = new FileReader();
	                reader.onload = function(e) {
	                    $('#previewImage').attr('src', e.target.result).show();
	                };
	                reader.readAsDataURL(file);
	            }
	        });
	    });
	    
	    var msg = '${msg}';
		if(msg != ''){
			alert(msg);
		}
		$('#user_pw, #user_pwcheck').on('keyup blur', function(){
			var password = $('#user_pw').val();
			var passwordCheck = $('#user_pwcheck').val();
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
		
		function readFile(input){
			console.log(input.files);
			const files = input.files;
		    const maxFileCount = 1;
		    const maxFileSize = 5 * 1024 * 1024;
		    if (files.length > maxFileCount) {
		      alert("프로필 사진은 최대 1개까지만 선택 가능합니다.");
		      input.value = ''; 
		      return;
		    }
			var reader;
			$('#img_list').empty();
			for (var file of input.files) {
				reader = new FileReader(); 
				reader.readAsDataURL(file); 
				reader.onload = function(e){ 
				$('#img_list').append('<img class="preview" src="'+e.target.result+'" style="max-width: 100px; max-height: 100px; margin: 5px;"/>');
				}
			}
		}
		document.getElementById('checkEmailBtn').addEventListener('click', function () {
		    const emailInput = document.getElementById('numb').value;
		    const emailError = document.getElementById('emailError');
		    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

		    if (emailPattern.test(emailInput)) {
		        emailError.style.display = 'none';
		        // 여기에 중복 확인 로직을 추가하세요.
		    } else {
		        emailError.style.display = 'inline';
		    }
		});
    </script>
</html>
