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

//페이지 로드 시 SSE 연결 시작
window.onload = () => {
 startSseConnection(); // SSE 연결 시작
 displayNotifications(); // 초기 알림 표시
};
</script>


</html>