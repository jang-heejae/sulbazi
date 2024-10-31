<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Real-time Notifications</title>
</head>
<body>
	<h2>알림</h2>
	<div id="notification"></div>
	<button id="test" type="button" onclick="roomout()">강퇴 테스트</button>
	<button id="test" type="button" onclick="roomdeny()">거절 테스트</button>
	<button id="test" type="button" onclick="chatroommanager()">수락거절 테스트</button>
</body>
<script>

var my_id = '${sessionScope.loginId}'; //내 아이디
var chatroomboss = '1212'; //내가 보낸 채팅방에서의 방장
var user_id='1212'; //나에게 신청 보내는 유저


function roomout() {
    $.ajax({
        type: 'POST',
        url: 'chatroomout.ajax',
        data: {'my_id': my_id, 
        		'chatroomboss': chatroomboss},
        dataType: 'JSON',
        success: function(alarmresponse) {
            const newAlarm = alarmresponse;
            addAlarm(newAlarm); // 새로운 알림 추가 함수 호출
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e); // 에러 메시지 출력
        }
    });
}


function roomdeny() {
    $.ajax({
        type: 'POST',
        url: 'chatroomdeny.ajax',
        data: {'my_id':my_id,
        		'chatroomboss':chatroomboss},
        dataType: 'JSON',
        success: function(alarmresponse) {
        	
        	const newAlarm = alarmresponse;
        	addAlarm(newAlarm);
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
        }
    });
}

function chatroommanager() {
    $.ajax({
        type: 'POST',
        url: 'chatroommanager.ajax',
        data: {'my_id':my_id,
        		'user_id':user_id},
        dataType: 'JSON',
        success: function(alarmresponse) {

        	const newAlarm = alarmresponse;
        	addAlarm(newAlarm);
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
        }
    });
}

function addAlarm(newAlarm) {
    newAlarm.id = Date.now(); // 고유 ID 생성 (UUID를 사용하는 것이 좋을 수 있음)
    
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : []; // 기존 알림 배열 가져오기
    
    alarms.push(newAlarm); // 새로운 알림 추가
    localStorage.setItem('Alarmresponse', JSON.stringify(alarms)); // localStorage 업데이트
    displayNotifications(); // 알림 표시 함수 호출
}

function displayNotifications() {
    const alarmresponse = localStorage.getItem('Alarmresponse');
    const notificationsElement = document.getElementById("notification");
    notificationsElement.innerHTML = ''; // 기존 내용 초기화

    if (alarmresponse) {
        const alarms = JSON.parse(alarmresponse); // 알림 배열 파싱
        
        alarms.forEach(alarm => {
            const notificationItem = document.createElement('div');
            notificationItem.className = 'notification-item';
            notificationItem.innerHTML = alarm.chatroomname + '의 ' + alarm.alarm;
            
            // 특정 알림이면 수락/거절 버튼 추가
            if (alarm.alarm === "개설하신 대화방에 참여 신청이 왔습니다.") {
                const acceptButton = document.createElement('button');
                acceptButton.textContent = '수락';
                acceptButton.onclick = () => handleAccept(alarm); // 수락 처리

                const denyButton = document.createElement('button');
                denyButton.textContent = '거절';
                denyButton.onclick = () => handleDeny(alarm); // 거절 처리

                notificationItem.appendChild(acceptButton);
                notificationItem.appendChild(denyButton);
            }
            
            // 클릭 이벤트 리스너 추가
            notificationItem.addEventListener('click', function() {
                $.ajax({
                    type: 'POST',
                    url: 'readAlarm.ajax', // 서버의 해당 요청 URL로 변경
                    data: {
                        'alarmId': alarm.id, // 알림 ID를 서버로 전송
                        'my_id': my_id // 필요한 추가 데이터 전송 (예: 사용자 ID)
                    },
                    dataType: 'JSON',
                    success: function(data) {
                        console.log("서버 응답:", data);
                    },
                    error: function(e) {
                        console.log("AJAX 요청 실패:", e); // 에러 메시지 출력
                    }
                });
                removeAlarm(alarm.id); // 고유 ID로 특정 알림 삭제
                notificationsElement.removeChild(notificationItem); // 화면에서 삭제
            });
            
            notificationsElement.appendChild(notificationItem); // 알림 화면에 추가
        });
    }
} 

function removeAlarm(alarmId) {
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];

    // 해당 알림 ID에 일치하는 것만 삭제
    alarms = alarms.filter(alarm => alarm.id !== alarmId); // 필터링하여 삭제

    localStorage.setItem('Alarmresponse', JSON.stringify(alarms)); // 업데이트된 배열 저장
}

function handleAccept(alarm) {
    console.log(alarm.chatroomname, '수락'); // 수락된 대화방 이름 출력
    removeAlarm(alarm.id); // 수락 후 알림 제거
}

function handleDeny(alarm) {
    console.log(alarm.chatroomname, '거절'); // 거절된 대화방 이름 출력
    removeAlarm(alarm.id); // 거절 후 알림 제거
}

// 페이지 로드 시 기존 알림 표시
window.onload = displayNotifications;

// storage 이벤트 리스너
window.addEventListener('storage', (event) => {
    if (event.key === 'Alarmresponse') {
        displayNotifications(); // 알림 업데이트
    }
});

</script>
</html>