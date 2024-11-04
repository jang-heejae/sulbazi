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
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
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
		background-color: rgb(255, 140, 9);
		color: #20290E;
		padding: 5px;
		border-radius: 5px;
		font-size: 16px;
		font-family: "Yeon Sung", system-ui;
		width: 49px;
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
	.chatList{
		border-radius: 10px;
	 	margin: 10px;
	 	background-color: #20290E;
		border: 2px solid rgb(255, 140, 9);
 	    display: flex;
    	flex-direction: column;
   	    justify-content: space-between;
        padding: 10px;
        height: 88px;
        color: white;
	}
	.parti{
	    display: flex;
   		width: 100%;
    	justify-content: flex-end;
    	align-items: center;
    	flex-direction: row;
}
</style>
</head>
<body>
<c:import url="../main/main.jsp"/>
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
			<div class="userChat" style="width:45%; height:45%;">
				<div class="userChat2" style="width:100%; height:20%;">
					<c:forEach var="chat" items="${chatRoom}">
						<div class="chatList">
						<input type="hidden" class="ucIdx" value="${chat.userchat_idx}"/>
							<div class="chatList2"><span style="font-size:24px;">${chat.userchat_subject}</span></div>
							<div class="parti">
								<div class="count" style="width: 13%;">${chat.current_people} / ${chat.max_people}</div>
								<div class="chatParti" style="width: 12%"><button type="button" class="roomoutbtn">퇴장</button></div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>	
			</div>
       	</div>
    </section>
</body>
<script>
$('.roomoutbtn').click(function() {
    if (confirm("방을 나가시겠?")) {
       var chatroom_idx = $('.ucIdx').val();
       
       $.ajax({
          url: '/SULBAZI/userroomout.ajax',
          type: 'POST',
          data: {chatroom_idx: chatroom_idx},
          success: function(response) {
          },
          error: function(error) {
             console.error("에러 발생:", error);
             alert("방 나가기에 실패했습니다.");
          }
       });
    }else{
       alert("취소되었습니다.");
    }
 });
</script>
</html>