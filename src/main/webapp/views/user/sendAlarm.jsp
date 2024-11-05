<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<body>
</body>


<script>

//로그인한 사용자의 ID (세션에서 가져옴)
const loggedInUserId = '${sessionScope.loginId}'; 

//알림을 저장할 배열
let notificationsList = [];

//SSE 연결 시작
function startSseConnection() {
 	const eventSource = new EventSource(`/SULBAZI/notifications/connect/${sessionScope.loginId}`);

 // 알림 수신
 	eventSource.onmessage = function(event) {
     	console.log("SSE 데이터 수신:", event.data);
     	const newAlarm = JSON.parse(event.data);

     // 로그인한 사용자에게 맞는 알림만 추가
     if (newAlarm.receiverId === loggedInUserId) {
         addAlarm(newAlarm);
         displayNotifications();
     	}
 	};

 	eventSource.onerror = function(event) {
     	console.error("SSE 오류:", event);
 	};
}

//알림 추가 함수
function addAlarm(notification) {
 	notificationsList.push(notification);
 	console.log("새 알림 추가:", notification);
}

//알림 표시 함수
function displayNotifications() {
 const notificationsElement = document.getElementById('notification');
 notificationsElement.innerHTML = ''; // 기존 알림 초기화

 notificationsList.forEach(notification => {
     const notificationItem = document.createElement('div');
     notificationItem.innerHTML = notification.chatroomname+'의'+ notification.alarm;
     notificationItem.setAttribute('data-alarm-idx', notification.alarm_idx);

     // 특정 알림일 경우 수락/거절 버튼 추가
     if (notification.alarm === "개설하신 대화방에 참여 신청이 왔습니다.") {
         const acceptButton = document.createElement('button');
         acceptButton.textContent = '수락';
         acceptButton.onclick = () => handleAccept(notification);  //수락클릭시 호출함수(notification은 map 형태)

         const denyButton = document.createElement('button');
         denyButton.textContent = '거절';
         denyButton.onclick = () => handleDeny(notification); //거절 클릭시 호출함수(notification은 map 형태)

         notificationItem.appendChild(acceptButton);
         notificationItem.appendChild(denyButton);
     }

     // 알림 클릭 시 읽음 처리 및 알림 삭제
     notificationItem.addEventListener('click', function() {
         markAsRead(notification); // 읽음 처리
         notificationsElement.removeChild(notificationItem); // 화면에서 제거
     });

     notificationsElement.appendChild(notificationItem); // 화면에 추가
 });
}

//읽음 처리 함수
function markAsRead(notification) {
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/readAlarm.ajax',
        data: JSON.stringify({ 'alarm_idx': notification.alarm_idx,
				'receiverId': notification.receiverId }),
        contentType: 'application/json',
        success: function(response) {
            console.log("알림 읽음 처리 성공:", response);
            notificationsList = notificationsList.filter(alarm => alarm.alarm_idx !== notification.alarm_idx);
            displayNotifications(); // 업데이트된 목록 표시
        },
        error: function(error) {
            console.error("알림 읽음 처리 실패:", error);
        }
    });
    
}

//페이지 로드 시 초기 알림 가져오기
function fetchInitialNotifications() {
    $.ajax({
        type: 'GET',
        url: '/SULBAZI/notifications/getInitialNotifications.ajax',
        data: { 'receiverId': loggedInUserId },
        dataType: 'json',
        success: function(notifications) {
            notifications.forEach(notification => {
                addAlarm(notification);
            });
            displayNotifications();
        },
        error: function(error) {
            console.error("초기 알림 가져오기 실패:", error);
        }
    });
}

// 페이지 로드 시 SSE 연결 시작
window.onload = () => {
    fetchInitialNotifications(); // 초기 알림 가져오기
    startSseConnection(); // SSE 연결 시작
};


function sendNotification(newAlarm) {
    const receiverId = newAlarm.receiverId;

    // AJAX POST 요청을 통해 서버에 알림 전송
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/send', // 알림을 전송할 서버 엔드포인트
        data: JSON.stringify(newAlarm),
        contentType: 'application/json',
        success: function(response) {
            console.log("알림이 성공적으로 전송되었습니다:", response);
        },
        error: function(e) {
            console.error("알림 전송 실패:", e);
        }
    });
}

// 수락
function handleAccept(notification){
	 $.ajax({
	        type: 'POST',
	        url: '/SULBAZI/notifications/chatroomin.ajax',
	        data: {'user_id':notification.sendId,  //수신자ID
	        		'chatroomboss':notification.receiverId // 방장
	        }, //채팅방 방장
	        dataType: 'JSON',
	        success: function(alarmresponse) {
	            // 알림 데이터 객체 생성
	            const newAlarm = {
	                receiverId: user_id, //수신자 id
	                chatroomname: alarmresponse.chatroomname,  //문의 제목
	                alarm: alarmresponse.alarm, //알림 내용
	                alarm_idx: alarmresponse.alarm_idx //알림 idx
	            };
	            sendNotification(newAlarm); // 알림 전송 함수 호출
	            saveNotification(newAlarm); // 알림 저장 함수 호출
	        },
	        error: function(e) {
	            console.log("AJAX 요청 실패:", e);
	        }
	    });
	
}

// 거절
function handleDeny(notification){
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/chatroomdeny.ajax',
        data: {'user_id':notification.sendId, //수신자 ID
        		'chatroomboss':notification.receiverId}, //대화방 방장ID 
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: user_id, //수신자 id
                chatroomname: alarmresponse.chatroomname,  //문의 제목
                alarm: alarmresponse.alarm, //알림 내용
                alarm_idx: alarmresponse.alarm_idx //알림 idx
            };
            sendNotification(newAlarm); // 알림 전송 함수 호출
            saveNotification(newAlarm); // 알림 저장 함수 호출
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
        }
    });
}


</script>


</html>