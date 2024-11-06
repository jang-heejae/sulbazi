<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
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
        position: fixed;
    	top: 0;
    	left: 0; 
        z-index: 999;
        position:absolute;
        display: flex;
        width: 300px;
        min-height: 100vh;
        height: auto;
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
        position: fixed;
    	top: 0;
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
	.sub_1{
		display: block;
    	overflow-y: auto;
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
        align-items: center;
        flex-direction: column;
        text-align: center;
    }
    .modal_madal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 300px;
    height: auto;
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 10px;
    box-shadow: 0px 4px 8px #041d03;
    color: #041d03;
    text-align: center;
    font-family: "Yeon Sung", system-ui;
}

.modal-content_madal {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

.btn_madal {
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

.btn_madal:hover {
    background-color: #20290E;
    color: white;
}

.close_madal {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close_madal:hover,
.close_madal:focus {
    color: black;
}
    .fa-regular fa-bell {
    	overflow-y: auto;
    	overflow: hidden;
    }
    
</style>
<body>
    <%-- <jsp:include page="../user/sendAlarm.jsp"/> --%>
    <header>
        <nav class="navbar">
            <div class="main_menu"><i class="fa-solid fa-bars"></i></div>
            <div class="logo_text">
                <a href="./mainPage.go">SULBAZI</a>
            </div>
            <div>
                <ul class="icon">
                    <li class="userUser"><a href="login.go">로그인</a></li>
                    <li>
                        <i class="fa-regular fa-message"></i>
                        <div class="sub_1">
                            <div class="sub_txt1">대화중인 대화방</div>
                            <c:if test="loginId == ${userchat.userchat_id}">
                            <c:forEach items="${list}" var="userchat">
                            	<form action="userchatroom.go?userchat_idx=${userchat.userchat_idx}" method="post">
	                               <div class="sub1" onclick="submitForm(${userchat.userchat_idx})" style="cursor: pointer;">
	                                   <div class="roominfof">${userchat.userchat_subject}</div>
	                                   <input type="hidden" name="userchat_idx" value="${userchat.userchat_idx}">
	                                   <div class="roominfof">${userchat.current_people} / ${userchat.max_people}</div>   
	                               </div>
                               </form>
                            </c:forEach>
                            </c:if>
                        </div>
                    </li>
                    <li>
                        <i class="fa-regular fa-bell"></i>
                        <div class="sub_">
                            <div class="sub_txt">알림</div>
                            <div id="notification"></div>
                        </div>
                    </li>
                    <li class="mypage"><i class="fa-regular fa-user"></i></li>
                </ul>
            </div>
        </nav>
        <div class="fullbox">
            <div class="full">
                <ul class="list1">
                    <li><a href="./localchatlist.go">지역 대화방</a></li>
                    <li><a href="userchatlist.go">개인 대화방</a></li>
                    <li><a href="storeList.go">매장 리스트</a></li>
                    <li><a href="boardList.go">게시판</a></li>
                	<li><a href="userinquery.go">고객센터</a></li>
                </ul>
            </div>
            <div class="full2">
                <ul class="list2">
                    <li><a href="userMyPage.go?user_id=${sessionScope.loginId}">나의 정보</a></li>
                    <li><a href="userReview.go">나의 리뷰</a></li>
                    <li><a href="userMyChat.go">나의 대화방</a></li>
                    <li><a href="MyBookmark.go">즐겨찾기 매장</a></li>
                    <li><a href="userAlarm.go">알림 리스트</a></li>
                </ul>
                <div class="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <a href="logout.go">로그아웃</a>
                </div>
            </div>
        </div>  
    </header>
</body>
<div id="loginModal" class="modal_madal" style="display: none;">
    <div class="modal-content_madal">
        <span class="close_madal" onclick="closeLoginModal()">&times;</span>
        <p>로그인이 필요한 페이지 입니다.</p>
        <p>로그인 페이지로 이동하시겠습니까?</p>
        <br/>
        <button class="btn_madal" onclick="redirectToLogin()">로그인</button>
    </div>
</div>
<script>
var loginId ='${sessionscope.loginId}';

const isLoggedIn = "${sessionScope.loginId != null}";
document.addEventListener('DOMContentLoaded', function() {
    // .go 링크 클릭 이벤트에 로그인 확인 추가
    document.querySelectorAll('a[href*=".go"]').forEach(link => {
        link.addEventListener('click', function(event) {
        	if (!this.href.includes('login.go') && isLoggedIn !== "true") {
                event.preventDefault(); // 기본 링크 이동 막기
                document.getElementById('loginModal').style.display = 'block'; // 모달 표시
            }
        });
    });
});

function closeLoginModal() {
    document.getElementById('loginModal').style.display = 'none';
}

function redirectToLogin() {
	closeLoginModal();
    window.location.href = 'login.go'; // 로그인 페이지로 이동
}

// 내 대화방 입장
function submitForm(userchatIdx) {
        // 폼을 찾아서 제출합니다.
        const form = document.getElementById(`chatForm_${userchatIdx}`);
        if (form) {
            form.submit();
        }
    }
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


</script>
</html>