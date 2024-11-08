<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
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
        gap:60px;
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
		border-radius: 10px;
	    margin: auto;
	    height:633;
	    background-color: #73734f;
	    top: 20;
	} 
	.stateselect{
		width:300;
		font-size:20;
		padding:5;
	}
	fieldset{
		display:flex;
		border-color:#73734F;
	}
	#submitbutton{
		width: 60px;
    	height: 40px;
    	border-radius:10px;
    	border:1px solid #73734F;
    	background-color: rgb(255, 160, 19);
    	font-size: 20;
    	margin-bottom:5;
	}
div.notification2 {
    width:458px;
    height: 550px;
    overflow-y: scroll;
    scrollbar-width: none;
    color: white;
    background-color: rgb(255, 160, 19);
    border-radius: 10px;
}
div.selectarea{
	width:330px;
	
}
.stateselect {
    display: flex;
    justify-content: space-between; /* 선택 항목들이 가로로 배치되도록 설정 */
    width: 100%; /* 전체 가로 너비를 차지하도록 설정 */
    font-size: 20px;
}

.stateselect fieldset {
    margin: 0; /* fieldset의 기본 margin 제거 */
    padding: 0; /* fieldset의 기본 padding 제거 */
    border: none; /* 기본 테두리 제거 */
}

.sub22 {
	color: black;
	font-size:27;
	border: 1px solid rgb(255, 160, 19);
	padding:8;
	background-color: white;
	margin:16;
	border-radius:10px;
	
	
}
input[type="radio"] {
    width: 30px;
    height: 23px;
}
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
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
    	border: 2px solid rgb(255, 140, 9);
	}
    .userNickname{
   		font-size: 96px;
   		margin-left: 31px;
   	 	margin-bottom: 12px;
   	 	color: rgb(255, 140, 9);
   	 	-webkit-text-stroke: 2px #20290E;
    }
    #userLike{
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    }
	.likeIcon{
    	width: 50px;
    	height: 50px;
    	object-fit: cover;
    	margin-right: 17px;
	}
	.profile-image {
    	width: 250px;
    	height: 250px;
    	border-radius: 50%; /* 동그란 모양으로 만들기 */
    	object-fit: cover; /* 이미지의 비율을 유지하면서 크기를 맞춤 */
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.userProfile2{
		display: flex;
    width: 100%;
    height: 100%;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
	}
	.userProfile1{
		display: flex;
    width: 45%;
    height: 45%;
    flex-direction: column;
    align-items: center;
	}
	.storeDetail{
		display: inline;
		width: 120px;
    	height: 100px;
		margin-top:  -9px;
		border-radius: 30px;
	}
	.bookmark3{
	    background-color: #20290E;
		border: 2px solid rgb(255, 140, 9);
		color: white;
    	border-radius: 30px;
    	width: 100%;
    	height: 128px;
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    	justify-content: space-evenly;
	}
	.bookmark3 div{
	    height: 82%;
    	width: 58%;
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
.somethingarea{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    align-content: flex-end;
    justify-content: space-between;
    align-items: flex-end;
}

</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
    <c:import url="../user/sendAlarm.jsp"/> 
    	<section class="chatBox2">
       	<div class="chatitems2">
 	        <div class="userProfile2" style="width:100%; height:100%;">
 	        <div class="userProfile1" style="width:45%; height:45%;">
				<div id="userProfile">
					<div class="userNickname">${info.user_nickname}</div>
					<div>
						<c:forEach items="${files}" var="file">
							<img class="profile-image" alt="${file.user_photo}" src="/photo/${file.user_photo}"/>
						</c:forEach>
					</div>
				</div>
				<div class="userLike">
					<div id="userLike" style="margin: 18px;">
						<img class="likeIcon" src="resources/img/userLike.png"/>
						<ul> 
							<li>${info.user_likecount}</li>
						</ul>
					</div>
				</div>
				</div>
				<div class="alarmarea">
					<div class="somethingarea">
						<div class="selectarea">
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
						</div>
						<button id="submitButton">확인</button>
					</div>
					<div class="notification2"></div>
				</div>
			</div>
       	</div>
    </section>

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
            clearNotifications2();
            notifications.forEach(notification => {
                addAlarm2(notification);
            });
            displayNotifications2();
        },
        error: function(error) {
            console.error("초기 알림 가져오기 실패:", error);
        }
    });
}

	



</script>
</html>