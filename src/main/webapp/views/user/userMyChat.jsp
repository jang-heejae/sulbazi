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
	.roomoutbtn{
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
        cursor: pointer;
	}
	.parti{
	    display: flex;
   		width: 100%;
    	justify-content: flex-end;
    	align-items: center;
    	flex-direction: row;
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
						<form action="userchatroom.go?userchat_idx=${chat.userchat_idx}" method="post">
						<div class="chatList">
						<input type="hidden" class="ucIdx" name="userchat_idx" value="${chat.userchat_idx}"/>
						<input type="hidden" name="userchat_idx" value="${chat.userchat_idx}"/>
						<input type="hidden" name="user_id" value="${chat.user_id}"/>
							<div class="chatList2"><span style="font-size:24px;">${chat.userchat_subject}</span></div>
							<div class="parti">
								<p class="count" style="width: 13%;">${chat.current_people}</p> / <p>${chat.max_people}</p>
								<div class="chatParti" style="width: 12%"><button type="button" class="roomoutbtn">퇴장</button></div>
							</div>
						</div>
						</form>
					</c:forEach>
				</div>
			</div>	
			</div>
       	</div>
    </section>
</body>
<div id="confirmationModal" class="modal_madal">
    <div class="modal-content_madal">
        <span class="close_modal" id="closeModal">&times;</span>
        <p id="confirmationMessage"></p>
        <button type="button" class="btn_madal" id="confirmAction">확인</button>
        <button type="button" class="btn_madal" id="cancelAction">취소</button>
    </div>
</div>
<script>
$(document).ready(function() {
   
	$('.chatList').click(function(){
        var userchat_idx = $(this).find('input[name="userchat_idx"]').val();  // 해당 방의 userchat_idx 가져오기
        var actionUrl = 'userchatroom.go?userchat_idx=' + userchat_idx;  // 동적으로 URL 생성
        
        // 모달을 표시하는 부분
        $('#confirmationMessage').text('이동하시겠습니까?');
        $('#confirmationModal').css('display', 'block'); // 모달을 보이도록 설정

        // 확인 버튼 클릭 시 폼 제출
        $('#confirmAction').off('click').on('click', function() {
            var form = $('form').get(0);  // 첫 번째 폼 선택
            form.action = actionUrl;  // 동적으로 action URL 설정
            form.submit();  // 폼 제출
            $('#confirmationModal').css('display', 'none'); // 모달 숨기기
        });
    });
	
});

$('.roomoutbtn').click(function() {
    if (confirm("방을 나가시겠습니까?")) {
       /* var chatroom_idx = $('.ucIdx').val();
       var user_id = $('input[name="user_id"]').val();
       var current = $('.count').text();

       $.ajax({
          url: 'userroomout.ajax',
          type: 'POST',
          data: {chatroom_idx: chatroom_idx},
          success: function(response) {
        	  location.reload();
          },
          error: function(error) {
             console.error("에러 발생:", error);
             alert("방 나가기에 실패했습니다.");
          }
       });
       cosole.log("chatroom_idx"+chatroom_idx);
       cosole.log("user_id"+user_id);
       cosole.log("current"+);
       // 방장일 경우
       if(user_id === loginId){
    	   
       }else{ */
	       $.ajax({
	          url: '/SULBAZI/userroomout.ajax',
	          type: 'POST',
	          data: {chatroom_idx: chatroom_idx},
	          success: function(response) {
	        	  location.reload();
	          },
	          error: function(error) {
	             console.error("에러 발생:", error);
	             alert("방 나가기에 실패했습니다.");
	          }
	       });
       }
    }else{
       alert("취소되었습니다.");
    }
 });
</script>
</html>