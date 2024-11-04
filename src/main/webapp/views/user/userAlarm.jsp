<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>
    <jsp:include page="../user/sendAlarm.jsp" />
    <h2>알림</h2>
    <div id="notification"></div>
    <button type="button" onclick="chatroommanager()">수락거절 테스트</button>
    

    <script>
            //displayNotifications(); // 화면에 표시

    </script>

</body>
<script>
function chatroommanager() {
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/chatroommanager.ajax',
        data: {'getuser_id':11, //수신자 ID
        		'user_id':'테스트'}, //발신자 ID
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: '11', //수신자 id
                chatroomname: alarmresponse.chatroomname,  //문의 제목
                alarm: alarmresponse.alarm, //알림 내용
                alarm_idx: alarmresponse.alarm_idx //알림 idx
            };
            sendNotification(newAlarm); // 알림 전송 함수 호출
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
        }
    });
}
/* const loggedInUserId = localStorage.getItem('loggedInUserId'); // 현재 로그인한 사용자 ID*/

/* var my_id = '${sessionScope.loginId}'; //내 아이디
var chatroomboss = '1212'; //내가 보낸 채팅방에서의 방장
var user_id='1212'; //나에게 신청 보내는 유저 */

// 강퇴
function roomout() {
    $.ajax({
        type: 'POST',
        url: 'chatroomout.ajax',
        data: {'user_id': user_id,  //수신자ID
        		'chatroomboss': chatroomboss},  //대화방 방장ID
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
            console.log("AJAX 요청 실패:", e); // 에러 메시지 출력
        }
    });
}

//거절
function roomdeny() {
    $.ajax({
        type: 'POST',
        url: 'chatroomdeny.ajax',
        data: {'user_id':user_id, //수신자 ID
        		'chatroomboss':chatroomboss}, //대화방 방장ID 
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

//수락
function chatroomin() {
    $.ajax({
        type: 'POST',
        url: 'chatroomin.ajax',
        data: {'user_id':user_id,  //수신자ID
        		'chatroomboss':chatroomboss}, //채팅방 방장
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


//수락/거절 선택
function chatroommanager() {
    $.ajax({
        type: 'POST',
        url: 'chatroommanager.ajax',
        data: {'getuser_id':getuser_id, //수신자 ID
        		'user_id':user_id}, //발신자 ID
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: getuser_id, //수신자 id
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








//즐찾 새소식
function bookmarknew() {
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/bookmarknew.ajax',
        data: {'user_id':user_id},//수신자 ID  //게시물 idx
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
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
        }
    });
}



//문의 답글 새소식
/*function inquirynewanswer(id_write,inquery_idx) {
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/inquiryanswer.ajax',
        data: { 'id_write': id_write,  //수신자 id
        		'inquery_idx': inquery_idx }, //문의 idx
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: id_write, //수신자 id
                chatroomname: alarmresponse.chatroomname,  //문의 제목
                alarm: alarmresponse.alarm, //알림 내용
                alarm_idx: alarmresponse.alarm_idx //알림 idx
            };
            sendNotification(newAlarm); // 알림 전송 함수 호출
            saveNotification(newAlarm); // 알림 저장 함수 호출
        },
        error: function(e) {
            console.error("AJAX 요청 실패:", e);
            console.log("응답 내용:", e.responseText);
        }
    });
}*/

// 서버에 알림 전송 함수 
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

</script>
</html>