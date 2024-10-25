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
    input[type="text"]{
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
    
</style>
<body>
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="#">SULBAZI</a>
            </div>
        </nav>
    </header>
    <form action="userJoin.do" method="post" enctype="multipart/form-data">
        <div class="container">
            <div class="wrapper">
                <h2>사용자 회원가입</h2>
                <input type="text" name="user_id" value="" placeholder="아이디(필수)"/>&nbsp;<button>중복확인</button><br>
                <input type="text" name="user_pw" value="" placeholder="비밀번호(필수)">
                <input type="text" name="user_pwcheck" value="" placeholder="비밀번호 확인(필수)">
                <h6>※ 비밀번호 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</h6>
                <input type="text" name="user_email" value="" placeholder="이메일(필수)"/>&nbsp;<button>중복확인</button>
                <br>
                <input type="radio" name="user_gender" value="남">남
                <input type="radio" name="user_gender" value="여">여
                <br>
                <input type="text" name="user_nickname" value="" placeholder="닉네임(필수)">
                <input type="text" name="user_name" value="" placeholder="이름(필수)">
                <input type="text" name="user_birth" value="" placeholder="생년월일(필수)">
                <input type="text" name="user_phone" value="" placeholder="핸드폰번호(필수)">
                <h2>프로필 사진</h2>
                <input type="file" name="files" multiple="multiple">
                <h2>카테고리(각 1개 선택가능(필수))</h2>
                <h3>주종</h3>
        		<fieldset>
    <legend>Category 1</legend>
    <c:forEach var="category" items="${category}">
        <c:if test="${category.category_state && category.category_idx == 1}">
            <input type="radio" id="category_${category.category_idx}" name="1" value="${category.opt_idx}" />
            <label for="category_${category.category_idx}">${category.opt_name}</label>
        </c:if>
    </c:forEach>
</fieldset>

<fieldset>
    <legend>Category 2</legend>
    <c:forEach var="category" items="${category}">
        <c:if test="${category.category_state && category.category_idx == 2}">
            <input type="radio" id="category_${category.category_idx}" name="2" value="${category.opt_idx}" />
            <label for="category_${category.category_idx}">${category.opt_name}</label>
        </c:if>
    </c:forEach>
</fieldset>

<fieldset>
    <legend>Category 3</legend>
    <c:forEach var="category" items="${category}">
        <c:if test="${category.category_state && category.category_idx == 3}">
            <input type="radio" id="category_${category.category_idx}" name="3" value="${category.opt_idx}" />
            <label for="category_${category.category_idx}">${category.opt_name}</label>
        </c:if>
    </c:forEach>
</fieldset>

<fieldset>
    <legend>Category 4</legend>
    <c:forEach var="category" items="${category}">
        <c:if test="${category.category_state && category.category_idx == 4}">
            <input type="radio" id="category_${category.category_idx}" name="4" value="${category.opt_idx}" />
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
        function submitForm() {
            var formData = new FormData($('#userJoinForm')[0]);
            $.ajax({
                type: 'POST',
                url: 'userJoin.ajax',  // 서버에서 처리할 URL
                data: formData,
                contentType: false,
                processData: false,
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    if (data.success) {
                        alert("회원가입이 완료되었습니다.");
                        location.href = data.link; // 회원가입 후 이동할 페이지
                    } else {
                        alert(data.message); // 오류 메시지 출력
                    }
                },
                error: function(e) {
                    console.error(e);
                    alert("오류가 발생했습니다.");
                }
            });
        }
    </script>
</html>
