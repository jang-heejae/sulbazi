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
</style>
<body>
    <header>
        <nav class="navbar">
            <div class="main_menu"><i class="fa-solid fa-bars"></i></div>
            <div class="logo_text">
                <a href="./mainPage.go">SULBAZI</a>
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
                        <div class="sub_" >
                            <div class="sub_txt">개 알림</div>
                            <div id="result"></div>
                        </div>
                    </li>
                    <li class="mypage"><i class="fa-regular fa-user"></i></li>
                </ul>
            </div>
        </nav>
        <div class="fullbox">
            <div class="full">
                <ul class="list1">
                    <li><a href="localchatlist.go">지역 대화방</a></li>
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


</script>
<script type="text/javascript">

window.addEventListener('storage', (event) => {
    if (event.key === 'Alarmresponse') {
        displayAlarms(); // 알림 업데이트
    }
});

window.onload = function() {
    displayAlarms();
}

function displayAlarms() {
    const alarmresponse = localStorage.getItem('Alarmresponse');
    const resultElement = document.getElementById("result");
    resultElement.innerHTML = ''; // 기존 내용 초기화

    if (alarmresponse) {
        const alarms = JSON.parse(alarmresponse);

        alarms.forEach(alarm => {
            const alarmItem = document.createElement('div');
            alarmItem.className = 'sub';
            alarmItem.innerHTML = alarm.chatroomname + "의 " + alarm.alarm;

            // 특정 알림이면 수락/거절 버튼 추가
            if (alarm.alarm === "개설하신 대화방에 참여 신청이 왔습니다.") {
                const acceptButton = document.createElement('button');
                acceptButton.textContent = '수락';
                acceptButton.onclick = () => handleAccept(alarm);

                const denyButton = document.createElement('button');
                denyButton.textContent = '거절';
                denyButton.onclick = () => handleDeny(alarm);

                alarmItem.appendChild(acceptButton);
                alarmItem.appendChild(denyButton);
            }

            // 클릭 이벤트 리스너 추가
            alarmItem.addEventListener('click', function () {
                removeAlarm(alarm.id); // ID를 사용하여 알림 제거
                resultElement.removeChild(alarmItem); // 화면에서 제거
            });

            resultElement.appendChild(alarmItem);
        });
    }
}

function addAlarm(newAlarm) {
    // 고유한 ID 추가 (Date.now()를 사용하여 생성)
    newAlarm.id = Date.now();
    
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];
    
    alarms.push(newAlarm);

    // 업데이트된 배열을 localStorage에 저장
    localStorage.setItem('Alarmresponse', JSON.stringify(alarms));

    // 알림 내용을 화면에 표시
    displayAlarms(); // 여기서 displayNotifications()를 제거하고 displayAlarms() 호출
}

function removeAlarm(alarmId) {
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];

    // 해당 알림 ID에 일치하는 것만 삭제
    alarms = alarms.filter(alarm => alarm.id !== alarmId);

    localStorage.setItem('Alarmresponse', JSON.stringify(alarms));
    displayAlarms(); // 알림 제거 후 다시 표시
}

function handleAccept(alarm) {
    console.log(alarm.chatroomname, '수락');
    removeAlarm(alarm.id); // 수락 후 알림 제거
}

function handleDeny(alarm) {
    console.log(alarm.chatroomname, '거절');
    removeAlarm(alarm.id); // 거절 후 알림 제거
}

</script>
</html>