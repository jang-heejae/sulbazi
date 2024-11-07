<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
    	border: 2px solid rgb(255, 140, 9);
	}
	.userProfile {
        display: flex;
        width: 50%;
        align-items: flex-start; /* 상단 정렬 */
        justify-content: center;
    }

    .userProfile2 {
        width: 45%; /* 왼쪽에 위치 */
        display: flex;
        flex-direction: column;
        gap: 10px;
        align-items: center;
        margin-top:14px;
    	margin-left: -25px;
    }

    .userNickname{
   		font-size: 96px;
   		margin-left: 31px;
   	 	margin-bottom: 12px;
   	 	color: rgb(255, 140, 9);
   	 	-webkit-text-stroke: 1px #20290E;
    }

	.profile-image {
    	width: 250px;
    	height: 250px;
    	border-radius: 50%; /* 동그란 모양으로 만들기 */
    	object-fit: cover; /* 이미지의 비율을 유지하면서 크기를 맞춤 */
	}
	
	.alarmarea{
	    margin-top: 20;
	    width: 450px;
	    height: 613px;
	}
	.stateselect{
		width:300;
		font-size:20;
	}
	fieldset{
		display:flex;
		border-color:#73734F;
	}
	#submitbutton{
		width: 64px;
    	height: 44px;
    	border-radius:10px;
    	border:1px solid white;
    	background-color: #73734F;
    	font-size: 20;
	}
</style>
</head>
<body>
<% 
    // C.jsp에서 B.jsp로 조건 전달
    request.setAttribute("includeSendAlarm", false);  // sendAlarm.jsp 포함 여부를 false로 설정
%>

<%@ include file="../main/main.jsp" %> 
<%-- 	<jsp:include page="../main/main.jsp"/>--%>
			<div class="alarmarea">
    		<c:import url="../user/sendAlarm.jsp"/> 
			    <h1>알림</h1>
				<div class="stateselect">
					<fieldset>
						<input type="radio" name="alarmread" value="0" checked/> 안읽음<br/>
						<input type="radio" name="alarmread" value="1"/>읽음<br/>
					</fieldset>
				</div>
			    <div class="stateselect">
					<fieldset>
						<input type="radio" name="alarm" value="3"checked/> 대화방<br/>
						<input type="radio" name="alarm" value="4"/>즐겨찾기<br/>
						<input type="radio" name="alarm" value="6"/>고객센터<br/>
					</fieldset>
				</div>
				<button id="submitButton">확인</button>
			    <div class="notification"></div>
			</div>

</body>
<script>

document.getElementById('submitButton').addEventListener('click', function() {
    const alarmreadValue = document.querySelector('input[name="alarmread"]:checked')?.value;
    const alarmValue = document.querySelector('input[name="alarm"]:checked')?.value;

    if (alarmreadValue !== undefined && alarmValue !== undefined) {
        // 두 값이 모두 선택된 경우 처리
        console.log("읽음 여부:", alarmreadValue);
        console.log("알림 종류:", alarmValue);

        // 여기에 추가적인 처리를 넣어주세요.
        readornotalarm(alarmreadValue, alarmValue); // 예시 함수 호출
    } else {
        alert("모든 옵션을 선택하세요.");
    }
});

// 두 값이 모두 null이 아닐 경우에만 알림 가져오는 함수 실행
function checkAndFetchNotifications() {
    if (alarmreadValue !== null && alarmValue !== null) { 
        readornotalarm(alarmreadValue,alarmValue); // 두 값이 null이 아닐 경우에만 함수 호출
    }
}

// 알림 가져오기 함수
function readornotalarm(alarmreadValue, alarmValue) {
    console.log("Logged in user ID:", loggedInUserId);
    console.log("읽음 여부:", alarmreadValue);
    console.log("알림 종류:", alarmValue);

    $.ajax({
        type: 'POST',
        url: 'notifications/readornotalarm.ajax',
        data: JSON.stringify({ 
            'receiverId': loggedInUserId, 
            'alarmreadValue': alarmreadValue,
            'alarmValue': alarmValue
        }),
        contentType: 'application/json', // JSON 형식으로 데이터 전송
        success: function(notifications) {
            console.log("알림 목록:", notifications); // 응답 확인
            clearNotifications();
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

	



</script>
</html>