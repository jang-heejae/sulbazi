<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
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
            margin-left: 3%;
            margin-top: 1%;
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
            margin-left: -2%;
            font-size: 15px;
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
    </style>
</head>
<body>
    <div id="loginBox">
        <div class="logo_text">
            <a href="./mainPage.go">SULBAZI</a>
        </div>
        <hr class="hr"/>
        <div class="check">
            <input type="radio" name="a" id="일반 사용자" checked> 일반 사용자
            <input type="radio" name="a" id="매장 사용자"> 매장 사용자
        </div>
        <br>
        <form action="userfindid.do" method="post" id="userForm">
            <div class="aa">
                <h2>회원정보에 등록된 이메일을 입력해주세요.</h2>
                <input class="inp" type="text" name="email" placeholder="이메일" required/>
                <button type="submit">아이디 찾기</button>
            </div>
        </form>
         
        <form action="storefindid.do" method="post" id="storeForm">
            <div class="bb">
                <h2>회원정보에 등록된 사업자 번호를 입력해주세요.</h2>
                <input class="inp" type="text" name="number" placeholder="사업자번호" required/>
                <button type="submit">아이디 찾기</button>
            </div>
        </form>
    </div>
</body>
<script>
    $("input:radio[name='a']").on("change", function() {
        switch (this.id) {
            case "일반 사용자":
                $(".bb").hide();
                $(".aa").show();
                break;
            case "매장 사용자":
                $(".aa").hide();
                $(".bb").show();
                break;
            default:
                break;
        }
    });
    
    $(document).ready(function() {
        $(".aa").show();
    });
    
    $(document).ready(function() {
        var message = '${msg}';
        if (message) {
            alert(message);
            window.location.href = "login.do"; //
        }
    });
</script>
</html>
