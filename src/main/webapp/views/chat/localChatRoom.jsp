<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	var loginId = '${sessionScope.loginId}';
	
	var session = "${sessionScope.session}";
	var msg = "${msg}";
	
	
	if(msg!=""){
		alert(msg);
		location.replace('./userchatlist.go');
	}
	
	$(document).ready(function() {

		// 메세지 전송
	    $('.sendmsg').click(function () {
	        var localmsg_content = $('textarea[name="usermsgcontent"]').val();
	        var user_id = $('input[name="user_id"]').val();
	        var localchat_idx = ${roomidx};
	
	        console.log("메세지내용"+localmsg_content);
	        console.log("로그인한 아이디"+loginId);
	        console.log("현재방 번호 "+localchat_idx);
	        if (localmsg_content.trim() === "") {
	            alert("메세지를 입력해주세요.");
	            return;
	        }

	        $.ajax({
	            url: '/SULBAZI/localsendMessage.ajax',
	            type: 'POST',
	            data: {
	            	user_id: user_id,
	                localmsg_content: localmsg_content,
	                localchat_idx: localchat_idx
	            },
	            success: function () {
	                loadMessages();  // 메세지를 다시 로드
	                $('textarea[name="usermsgcontent"]').val("");  // 입력 필드 비우기
	            },
	            error: function () {
	                alert("메세지 전송에 실패했습니다.");
	            }
	        });
	        
	    });
		
	    // 5초마다 새 메세지를 불러오기
	    var localchat_idx = ${roomidx};
	    setInterval(loadMessages, 3000);

	    function loadMessages() {
	        $.ajax({
	            url: '/SULBAZI/localloadMessages.ajax',
	            type: 'GET',
	            data: { localchat_idx: localchat_idx },
	            
	            success: function (data) {
	                $('.chatlist').empty();
	                $.each(data, function (index, msg) {
	          
	                	var messageHtml = '<div class="usermsg">';
	                	messageHtml += '<div class="user">';
	                	messageHtml += '<img alt="프로필" src="/photo/' + msg.user_photo + '" class="user-photo">';
				    	messageHtml += '<div class="usernick">' + msg.user_nickname + '</div>';
	                	messageHtml += '</div>';
	                	messageHtml += '<div class="txtbox">';
	                	messageHtml += '<div class="msgtxt">' + msg.localmsg_content + '</div>';
	                	// msg.usermsg_time을 원하는 형식으로 변환
	                	var date = new Date(msg.localmsg_time);
	                	var formattedDate = date.getFullYear() + '-' 
	                	    + ('0' + (date.getMonth() + 1)).slice(-2) + '-' 
	                	    + ('0' + date.getDate()).slice(-2) + ' ' 
	                	    + date.getHours() + ':' 
	                	    + ('0' + date.getMinutes()).slice(-2);

	                	messageHtml += '<div class="msgtime">' + formattedDate + '</div>';
	                	messageHtml += '</div>';
	                	messageHtml += '</div>';
	                	
	                	$('.chatlist').append(messageHtml);
	                    
	                });
	                
	                var chatList = $('.chatlist');
	        	    chatList.scrollTop(chatList[0].scrollHeight);
	        	    
	            },
	            error: function () {
	                console.log("메세지를 불러오는 중 오류가 발생했습니다.");
	            }
	        });
	    }

	    // 페이지 로드 시 메세지 불러오기
	    loadMessages();

		
	});
</script>
<style>
*{
    margin: 0;
    padding: 0;
}
a{
    text-decoration: none;
    color: black;
}
.main{
    background-color: #041d03;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.section{
    position: absolute;
    top: 20%;
    display: flex;
}
.content{
    margin-right: 10px;
    height: 350px;
}
.roomlist{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
	margin : 5px;
	width: 230px;
	height: 350px;
	background-color : #041d03;
	border-radius: 45px;
}
.cont{
    width: 200px;
    height: 320px;
}
.txt{
    color: white;
    display: flex;
    justify-content: center;
    width: 200px;
    height: 46px;
    font-size: 35px;
}
.room{
    left: 10px;
    display: flex;
    justify-content: center;
	align-items: center;
    margin: 10px;
    width: 180px;
    height: 45px;
    background-color: aliceblue;
    border-radius: 10px;
}
.roominfo{
	font-size: x-large;
}


    
    /* 채팅방 */
    .chatroom{
	    width: 780px;
	    height: 650px;;
	    background-color: lightseagreen;
	}
    .roomtitle{
        width: 780px;
        height: 50px;
        background-color: bisque;
    }
    .cont2{
        display: flex;
        width: 780px;
        height: 600px;
        background-color: darkkhaki;
    }
    .userlist{
        display: flex;
	    justify-content: space-between;
	    width: 200px;
	    height: 600px;
	    background-color: darkcyan;
	    flex-direction: column;
    }
    .room2{
        left: 10px;
        display: flex;
        justify-content: space-evenly;
        align-items: center;
        margin: 10px;
        width: 180px;
        height: 50px;
        background-color: aliceblue;
        border-radius: 10px;
    }
    .room2 img{
    	width: 40px;
	    height: 40px;
	    border-radius: 25px;
    }
    .roomout{
	    display: flex;
	    align-items: center;
		justify-content: space-between;
    }
    .roomoutbtn{
    	display: flex;
    }
    .roomoutbtn:hover{
    	cursor: pointer;
    	font-weight: bold;
    }
    .msgform{
        width: 580px;
        height: 600px;
        background-color: darkolivegreen;
    }
    .chatlist{
        background-color: thistle;
        width: 100%;
        height: 550px;
        overflow-y: auto;
    }
    .user{
    	display: flex;
	    justify-content: flex-start;
	    align-items: center;
    }
    .user img{
   	    border-radius: 20px;
	    width: 35px;
	    height: 35px;
    }
    .txtbox{
		display: flex;
    	align-items: baseline;
	}
    .msgtxt{
    	display: inline;
	    background-color: white;
    	border-radius: 10px;
   	    margin: 5px;
   	    padding: 3px;
    }
    .msgtime{
    	font-size: x-small;
    }
    .textarea{
        display: flex;
        justify-content: space-between;
        background-color: dimgray;
        width: 100%;
        height: 50px;
    }
    textarea{
        border: none;
        resize: none;
        outline: none;
        width: 85%;
        height: 100%;
        font-size: x-large;
    }
    .sendmsg{
        width: 15%;
    }
</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
	<h2>${loginId}님의 ${roomidx}번 채팅방</h2>
	<a href="localchatlist.go">뒤로가기</a>
    <div class="main">
        <div class="section">
            <div class="content">
                <div class="roombox">
                    <div class="roomlist">
                        <div class="cont">
                            <div class="txt">지역 대화방</div>
                            <c:forEach items="${list}" var="localchat">
	                            <div class="room">
	                                <div class="roominfo">${localchat.local_category}</div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chatroom">
            	<div class="chatroom">
                <div class="roomtitle">${subject}${userNicknames}</div>
                <div class="cont2">
                    <div class="userlist">
                    	<div>
                        <c:forEach items="${localuserlist}" var="localuserlist">
                        <div class="room2">
							<img width="20" alt="img" src="/photo/${userPhoto[localuserlist.user_id]}">
                            <div class="user">${userNickname[localuserlist.user_id]}</div>
                        </div>
                        </c:forEach>
                        </div>
                        <div class="roomout">
                        	<div class="roomoutbtn">
	                        	<i class="fas fa-sign-out-alt"></i>
	                        	<p>방 나가기</p>
                        	</div>
                        </div>
                    </div>
                    <div class="msgform">
                        <div class="chatlist">
                            <c:forEach items="${localmsg}" var = "msg">
                            <div class="usermsg">
                            	<div class="user">${userNicknames[msg.user_id]}</div>
                                <div class="usertxt">${msg.localmsg_content}</div>
                            </div>
                            </c:forEach>
                        </div>
                        <div class="textarea">
                        	<input type="text" name="user_id" value="${sessionScope.loginId}" readonly>
                            <textarea name="usermsgcontent" placeholder="메세지 입력"></textarea>
                            <button type="button" class="sendmsg">전송</button>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</body>
<script>

	// 방 나가기 클릭 시 parti_state를 0으로 변경
	
	$('.roomout').click(function() {
		var roomIdx = '${roomidx}';
		
		$.ajax({
			url: 'localroomout.ajax',
			type: 'POST',
			data: {roomIdx: roomIdx},
			success: function(response) {
				alert("방을 나갔습니다.");
				window.location.href = "localchatlist.go";  // 로컬 채팅방 리스트로 이동
			},
			error: function(error) {
				console.error("에러 발생:", error);
				alert("방 나가기에 실패했습니다.");
			}
		});
	});
	
	// 채팅 입력창 포커스되면 placeholder 제거
	$('.txtarea').on('focus', function() {
	      $(this).attr('placeholder', '');  
	});
	
	// 텍스트가 없으면 placeholder 복구
    $('.txtarea').on('blur', function() {
      if ($(this).val() === '') {
        $(this).attr('placeholder', '메세지 입력');  
      }
    });
	 
	 
</script>
</html>