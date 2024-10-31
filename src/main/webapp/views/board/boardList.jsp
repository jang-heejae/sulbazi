<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
    img.icon{
		width:25px;
	}
    *{
        margin: 0;
        padding: 0;
    }
    ol, ul, li{
        list-style: none;
    }
    a{
        text-decoration: none;
        color: white;
    }
    body{
        background-color: #041d03;
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
    .icon{
        display: flex;
    }
    .logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: 160px;
        color: rgb(255, 140, 9);
        font-size: 70px;
        font-weight: bolder;
    }
    .icon li{
        padding: 10px;
    }
    .fullbox{
        display: flex;
    }
    .full{
        z-index: 999;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list1 li, .list2 li{
        padding: 20px;
    }
    .full2{
        z-index: 999;
        position: absolute;
        left: 1620px;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: flex-end;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list2{
        position: absolute;
        top: 200px;
    }
    .logout{
        position: absolute;
        left: 25px;
        bottom: 25px;
    }
    i{
        font-size: 25px;
    }

    .sub_, .sub_1{
        position: absolute;
        width: 200px;
        height: 310px;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        display: none;
    }
    .sub_txt, .sub_txt1{
        font-size: 20px;
        color: white;
        display: flex;
        justify-content: center;
        margin-top: 5px;
    }
    .sub, .sub1{
        margin: 10px;
        width: 180px;
        height: 80px;
        background-color: aliceblue;
        display: flex;
        justify-content: space-around;
        border-radius: 10px;
    }
    .boardlist{
        position: absolute;
        width: 1200px;
        height: 600px;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        margin-top: 10%;
        left: 20%;
        padding: 20px;
        box-sizing: border-box;
    }
    td{
        padding: 1%;
        border: 1px solid #aaa;
        width: 150px;
        border-radius: 6px;
        background-color: whitesmoke;
        font-weight: 700;
    }
    .like, .view{
        width: 100px;
    }
    .time{
        width: 200px;
    }
    .subject{
    	width: 500px;
    }
    .writebutton{
    	position: absolute;
    	top: 140px;
    	right: 327px;
    }
</style>
<body>
    <jsp:include page="../main/main.jsp"/>
    <c:if test="${not empty sessionScope.opt && sessionScope.opt == 'store_log'}">
    <div class="writebutton" style="text-align: right; margin: 10px;">
        <a href="boardWrite.go" style="padding: 10px 20px; background-color: rgb(255, 140, 9); color: white; text-decoration: none; border-radius: 5px;">
            글쓰기
        </a>
    </div>
    </c:if>
    <div class="boardlist">
        <table>
            <tbody id="list">

            </tbody>
        </table>
    </div>
    
</body>
<script>
//main_menu 클릭 이벤트
var storeId = '<%= request.getAttribute("store_id") %>';
console.log(storeId);
document.querySelectorAll('.main_menu').forEach(function(menu) {
    menu.addEventListener('click', function() {
        var fullElement = document.querySelector('.full');
        var displayfull = window.getComputedStyle(fullElement).display;

        if (displayfull === 'none') {
            // .full2, .sub_, .sub_1 숨기기
            document.querySelectorAll('.full2, .sub_, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .full 클래스 요소를 flex로 설정
            fullElement.style.display = 'flex';
        } else {
            // .full 클래스 요소 숨기기
            fullElement.style.display = 'none';
        }
    });
});

// mypage 클릭 이벤트
document.querySelectorAll('.mypage').forEach(function(mypage) {
    mypage.addEventListener('click', function() {
        var full2Element = document.querySelector('.full2');
        var displayfull2 = window.getComputedStyle(full2Element).display;

        if (displayfull2 === 'none') {
            // .full, .sub_, .sub_1 숨기기
            document.querySelectorAll('.full, .sub_, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .full2 클래스 요소를 flex로 설정
            full2Element.style.display = 'flex';
        } else {
            // .full2 클래스 요소 숨기기
            full2Element.style.display = 'none';
        }
    });
});

// fa-message 클릭 이벤트
document.querySelectorAll('.fa-message').forEach(function(message) {
    message.addEventListener('click', function() {
        var sub1Element = document.querySelector('.sub_1');
        var displaysub_1 = window.getComputedStyle(sub1Element).display;

        if (displaysub_1 === 'none') {
            // .full, .full2, .sub_ 숨기기
            document.querySelectorAll('.full, .full2, .sub_').forEach(function(element) {
                element.style.display = 'none';
            });
            // .sub_1 클래스 요소 보이기
            sub1Element.style.display = 'block';
        } else {
            // .sub_1 클래스 요소 숨기기
            sub1Element.style.display = 'none';
        }
    });
});

// fa-bell 클릭 이벤트
document.querySelectorAll('.fa-bell').forEach(function(bell) {
    bell.addEventListener('click', function() {
        var subElement = document.querySelector('.sub_');
        var displaysub = window.getComputedStyle(subElement).display;

        if (displaysub === 'none') {
            // .full, .full2, .sub_1 숨기기
            document.querySelectorAll('.full, .full2, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .sub_ 클래스 요소 보이기
            subElement.style.display = 'block';
        } else {
            // .sub_ 클래스 요소 숨기기
            subElement.style.display = 'none';
        }
    });
});

$.ajax({
    type: 'GET',
    url: 'boardList.ajax',
    data: {},
    dataType: 'JSON',
    success: function(data) {
        console.log(data);
        if (data.login) {
            drawList(data.list); // 수정된 list로 drawList 호출
        } else {
            alert('로그인이 필요한 서비스입니다.');
            location.href = './login.go';
        }
    },
    error: function(e) {
        console.log(e);
    }
});

function drawList(list) {
    var content = '';
    list.forEach(function(item) {
        // board_state가 0이 아닐 때만 테이블 행을 추가합니다.
        if (item.board_state > 0) {
            content += '<tr>';
            content += '<td>' + item.board_category + '</td>';
            content += '<td class="subject"><a href="boardDetail.go?board_idx=' + item.board_idx + '" style="color: blue;">' + item.board_subject + '</a></td>';
            content += '<td class="like">' +
                '<i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>' + 
                item.like_count + 
                '</td>';
            content += '<td class="view">' +
                '<i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>' + 
                item.board_bHit + 
                '</td>';
            content += '<td>' + item.store_id + '</td>'; // store_id가 포함되어 있어야 함
            content += '<td>' + item.board_date + '</td>';
            content += '<td style="display: none;">' + item.board_state + '</td>'; // 숨김 처리
            content += '</tr>';
        }
    });
    $('#list').html(content);
}
</script>
</html>