<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

	<h2>알림</h2>
	<div id="notification"></div>
	<button id="test" type="button" onclick="displayNotifications()">강퇴 테스트</button>
	<!--<button id="test" type="button" onclick="roomdeny()">거절 테스트</button>
	<button id="test" type="button" onclick="chatroommanager()">수락거절 테스트</button> -->
</body>
<script>
/* const loggedInUserId = localStorage.getItem('loggedInUserId'); // 현재 로그인한 사용자 ID*/


/* var my_id = '${sessionScope.loginId}'; //내 아이디
var chatroomboss = '1212'; //내가 보낸 채팅방에서의 방장
var user_id='1212'; //나에게 신청 보내는 유저 */

// 강퇴
function roomout() {
    $.ajax({
        type: 'POST',
        url: 'chatroomout.ajax',
        data: {'my_id': my_id,  //나의 아이디 //알림 받는사람
        		'chatroomboss': chatroomboss},  //내가 신청한 방 방장의 아이디
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

//거절
function roomdeny() {
    $.ajax({
        type: 'POST',
        url: 'chatroomdeny.ajax',
        data: {'my_id':my_id, //알림 받는 사람
        		'chatroomboss':chatroomboss}, //내가 신청한 방 방장의 아이디 알림 보내는 사람 
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



//수락/거절 선택
function chatroommanager() {
    $.ajax({
        type: 'POST',
        url: 'chatroommanager.ajax',
        data: {'my_id':my_id, //알림 받는 사람
        		'user_id':user_id}, //알림 주는 사람
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





//수락
function chatroomin() {
    $.ajax({
        type: 'POST',
        url: 'chatroomin.ajax',
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





//즐찾 새소식
function bookmarknew() {
    $.ajax({
        type: 'POST',
        url: 'bookmarknew.ajax',
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



<<<<<<< HEAD
function sendNotification(senderId, receiverId, message) {
    // 수신자 ID를 키로 사용해 로컬 스토리지에서 해당 사용자의 알림 목록 가져오기
    const notifications = JSON.parse(localStorage.getItem(receiverId)) || [];
    const newNotification = {
        id: Date.now().toString(), // 고유 ID 생성
        message: message,           // 알림 메시지
        timestamp: new Date().toISOString(), // 타임스탬프
        isRead: false               // 읽음 여부
    };

    // 새로운 알림 추가
    notifications.push(newNotification);
    // 수신자 ID를 키로 로컬 스토리지에 업데이트
    localStorage.setItem(receiverId, JSON.stringify(notifications));
=======


//문의 답글 새소식
/* function inquirynewanswer() {
    $.ajax({
        type: 'POST',
        url: 'inquirynewanswer.ajax',
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
} */





































///////////건들지 말아주세요////////

/* function addAlarm(newAlarm) {
    newAlarm.id = Date.now(); // 고유 ID 생성
    
    const alarmresponse = localStorage.getItem('Alarmresponse');
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];
    
    alarms.push(newAlarm); // 새로운 알림 추가
    localStorage.setItem('Alarmresponse', JSON.stringify(alarms)); // localStorage 업데이트
    
    console.log("현재 알림 데이터:", localStorage.getItem('Alarmresponse'));
    
    displayNotifications(); // 즉시 알림을 화면에 반영
>>>>>>> origin/master
}

// 사용 예시: 특정 이벤트 발생 시 알림 전송
const loggedInUserId = localStorage.getItem('loggedInUserId'); // 현재 로그인된 사용자 ID
const receiverUserId = '1212'; // 알림을 받을 수신자 ID

sendNotification(loggedInUserId, receiverUserId, 'Hello from ' + loggedInUserId);











function addAlarm(receiverId, newAlarm) {
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
}

function displayNotifications(receiverId) {
    // 현재 사용자 ID를 기준으로 알림 목록 가져오기
    const alarmresponse = localStorage.getItem(receiverId);
    const notificationsElement = document.getElementById("notification");
    notificationsElement.innerHTML = ''; // 기존 알림 초기화

    if (alarmresponse) {
        const alarms = JSON.parse(alarmresponse);

        // 각 알림을 화면에 표시
        alarms.forEach(alarm => {
            const notificationItem = document.createElement('div');
            notificationItem.className = 'notification-item';
            notificationItem.innerHTML = alarm.chatroomname+의+alarm.alarm;

            // 특정 알림일 경우 수락/거절 버튼 추가
            if (alarm.alarm === "개설하신 대화방에 참여 신청이 왔습니다.") {
                const acceptButton = document.createElement('button');
                acceptButton.textContent = '수락';
                acceptButton.onclick = () => handleAccept(receiverId, alarm);

                const denyButton = document.createElement('button');
                denyButton.textContent = '거절';
                denyButton.onclick = () => handleDeny(receiverId, alarm);

                notificationItem.appendChild(acceptButton);
                notificationItem.appendChild(denyButton);
            }

            // 알림 클릭 시 읽음 처리 AJAX 호출 및 알림 삭제
            notificationItem.addEventListener('click', function() {
            	var alarm_id = alarm.alarm_idx;
            	console.log(alarm_id);
                $.ajax({
                    type: 'POST',
                    url: 'readAlarm.ajax',
                    data: {
<<<<<<< HEAD
                        'alarm_id': alarm.id,
                        'my_id': receiverId // 현재 사용자 ID 전달
=======
                        'alarm_id': alarm_id // 알림 ID를 서버로 전송// 필요한 추가 데이터 전송 (예: 사용자 ID)
>>>>>>> origin/master
                    },
                    dataType: 'JSON',
                    success: function(data) {
                        console.log("서버 응답:", data);
                    },
                    error: function(e) {
                        console.log("AJAX 요청 실패:", e);
                    }
                });

                removeAlarm(receiverId, alarm.id); // 알림 삭제
                notificationsElement.removeChild(notificationItem); // 화면에서 제거
            });

            notificationsElement.appendChild(notificationItem);
        });
    }
}

function removeAlarm(receiverId, alarmId) {
    // 수신자 ID를 기반으로 해당 사용자 알림 목록 가져오기
    const alarmresponse = localStorage.getItem(receiverId);
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];

    // 해당 알림 ID를 가진 알림만 삭제
    alarms = alarms.filter(alarm => alarm.id !== alarmId);

    // 업데이트된 알림 목록 저장
    localStorage.setItem(receiverId, JSON.stringify(alarms));
}

function handleAccept(receiverId, alarm) {
    console.log(`${alarm.chatroomname} 수락`);
    removeAlarm(receiverId, alarm.id);
}

function handleDeny(receiverId, alarm) {
    console.log(`${alarm.chatroomname} 거절`);
    removeAlarm(receiverId, alarm.id);
}

// 페이지 로드 시 로그인한 사용자의 알림 표시
const loggedInUserId = localStorage.getItem('loggedInUserId'); // 현재 로그인된 사용자 ID
window.onload = () => displayNotifications(loggedInUserId);

// storage 변경 감지 이벤트 리스너 (다른 탭이나 창에서 변경된 알림 표시)
window.addEventListener('storage', (event) => {
    if (event.key === loggedInUserId) {
        displayNotifications(loggedInUserId);
    }
}); */
<jsp:include page="../user/sendAlarm.jsp" />

<<<<<<< HEAD

=======
/* const eventSource = new EventSource(`/notifications/connect/${loggedInUserId}`);

eventSource.onmessage = function(event) {
    const newAlarm = JSON.parse(event.data);
    addAlarm(newAlarm); // 알림 추가 함수 호출
    displayNotifications(); // 알림 표시 업데이트
};

eventSource.onerror = function(event) {
    console.error("SSE 오류 발생:", event);
}; */
>>>>>>> origin/master
</script>
</html>