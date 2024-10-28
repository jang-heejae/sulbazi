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
</style>
<body>
    <header>
        <nav class="navbar">
            <div class="main_menu"><i class="fa-solid fa-bars"></i></div>
            <div class="logo_text">
                <a href="./#">SULBAZI</a>
            </div>
            <div>
                <ul class="icon">
                    <li><a href="login.go">로그인</a></li>
                    <li>
                        <i class="fa-regular fa-message"></i>
                        <div class="sub_1">
                            <div class="sub_txt1">대화중인 대화방</div>
                            <div class="sub1">알림1</div>
                            <div class="sub1">알림2</div>
                        </div>
                    </li>
                    <li>
                        <i class="fa-regular fa-bell"></i>
                        <div class="sub_">
                            <div class="sub_txt">3개 알림</div>
                            <div class="sub">알림1</div>
                            <div class="sub">알림2</div>
                            <div class="sub">알림3</div>
                        </div>
                    </li>
                    <li class="mypage"><i class="fa-regular fa-user"></i></li>
                </ul>
            </div>
        </nav>
        <div class="fullbox">
            <div class="full">
                <ul class="list1">
                    <li><a href="localChatRoom.go">지역 대화방</a></li>
                    <li><a href="userchatlist.go">개인 대화방</a></li>
                    <li><a href="storeList.go">매장 리스트</a></li>
                    <li><a href="boardList.go">게시판</a></li>
                </ul>
                <a href="userinquery.go">고객센터</a>
            </div>
            <div class="full2">
                <ul class="list2">
                    <li><a href="storeMyPage.go">나의 정보</a></li>
                    <li><a href="storeMyReview.go">나의 매장 리뷰</a></li>
                    <li><a href="storeMyBoard.go">나의 게시글</a></li>
                    <li><a href="storeMyMenu.go">매장 메뉴 등록</a></li>
                </ul>
                <div class="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <a href="logout.go">로그아웃</a>
                </div>
            </div>
        </div>  
    </header>
    <div class="boardlist">
        <table>
            <tbody id="list">

            </tbody>
        </table>
    </div>
    
</body>
<script>
//main_menu 클릭 이벤트
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
	url : 'boardList.ajax',
	data:{},
	dataType:'JSON',
	success:function(data){
		console.log(data);
		if(data.login){
			drawList(data.list);
		}else{
			alert('로그인이 필요한 서비스입니다.');
			location.href='./login.go';
		}
	},error:function(e){
		console.log(e);
	}
});
	function drawList(list){
		var content = '';
		list.forEach(function(item,board_idx){
			content += '<tr>';
			content += '<td>'+item.board_category+'</td>';
			content += '<td class="subject"><a href="boardDetail.go?board_idx=' + item.board_idx + '" style="color: blue;">' + item.board_subject + '</a></td>';
			content += '<td class="like">' +
            '<i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>' + 
            item.like_count + 
            '</td>';
			content += '<td class="view">' +
            '<i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>' + // 연한 회색
            item.board_bHit + 
            '</td>';
            content += '<td>'+'게시글 닉네임'+'</td>';
			content += '<td>'+item.board_date+'</td>';
			content += '<td style="display: ' + (item.board_state === 1 ? 'table-cell' : 'none') + ';">' + item.board_state + '</td>';
			content += '</tr>';
		});
		$('#list').html(content);
	}	
</script>
</html>