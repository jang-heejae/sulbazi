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
<!-- <script>
function addAlarm(newAlarm) {
    newAlarm.id = Date.now(); // 고유 ID 생성
    
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];
    
    alarms.push(newAlarm); // 새로운 알림 추가
    localStorage.setItem('Alarmresponse', JSON.stringify(alarms)); // localStorage 업데이트
    
    console.log("현재 알림 데이터:", localStorage.getItem('Alarmresponse'));
    
    displayNotifications(); // 즉시 알림을 화면에 반영
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
            	var alarm_id = alarm.alarm_idx;
            	console.log(alarm_id);
                $.ajax({
                    type: 'POST',
                    url: 'readAlarm.ajax', // 서버의 해당 요청 URL로 변경
                    data: {
                        'alarm_id': alarm_id // 알림 ID를 서버로 전송// 필요한 추가 데이터 전송 (예: 사용자 ID)
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
</script> -->
<script>
/* function addAlarm(receiverId, newAlarm) {
    // 알림에 고유 ID 생성
    newAlarm.id = Date.now();

    // 수신자 ID를 기반으로 로컬 스토리지에서 해당 사용자 알림 목록 가져오기
    const alarmresponse = localStorage.getItem(receiverId);
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];

    // 새로운 알림 추가
    alarms.push(newAlarm);
    localStorage.setItem(receiverId, JSON.stringify(alarms));

    // 로그인한 사용자에게만 알림 표시 (현재 사용자가 수신자인 경우만)
    if (receiverId === loggedInUserId) {
        displayNotifications(receiverId);
    }
} */






// 알림을 저장할 배열
const notificationsList = [];

const loggedInUserId = '${sessionScope.loginId}'; // 현재 로그인된 사용자 ID
const eventSource = new EventSource(`/notifications/connect/${loggedInUserId}`);


//SSE 연결 시작
 function startSseConnection() {
 	const eventSource = new EventSource(`/notifications/connect/${loggedInUserId}`); // userId 포함

 	eventSource.onmessage = function(event) {
     	const newAlarm = JSON.parse(event.data); // 수신한 알림 데이터 파싱
     	addAlarm(newAlarm); // 알림 추가 함수 호출
     	displayNotifications(); // 알림 표시 업데이트
 	};

 	 eventSource.onerror = function(event) {
     console.error("SSE 오류 발생:", event);
 	};
} 

// 알림 추가 함수
function addAlarm(notification) {
    notificationsList.push(notification); // 새로운 알림을 배열에 추가
    console.log("새로운 알림 저장:", notification); // 디버깅: 저장된 알림 확인
}

// 알림을 화면에 표시하는 함수
function displayNotifications() {
    const notificationsElement = document.getElementById('notification');
    notificationsElement.innerHTML = ''; // 기존 알림 초기화

    notificationsList.forEach(notification => {
        const notificationItem = document.createElement('div');
        notificationItem.innerHTML = notification.chatroomname+'의'+notification.alarm;
        notificationItem.setAttribute('data-alarm-idx', notification.alarm_idx); // 알림 인덱스를 데이터 속성으로 저장

        // 특정 알림일 경우 수락/거절 버튼 추가
        if (notification.alarm === "개설하신 대화방에 참여 신청이 왔습니다.") {
            const acceptButton = document.createElement('button');
            acceptButton.textContent = '수락';
            acceptButton.onclick = () => handleAccept(notification);

            const denyButton = document.createElement('button');
            denyButton.textContent = '거절';
            denyButton.onclick = () => handleDeny(notification);

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

// 페이지 로드 시 SSE 연결 시작
window.onload = () => {
    startSseConnection(); // SSE 연결 시작
    displayNotifications(); // 초기 알림 표시
};



</script>
</html>