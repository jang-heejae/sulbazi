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
    .roomout{
        width: 95px;
	    display: flex;
	    align-items: center;
    }
    .roomout:hover{
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
    }
    .usertxt{
   	    width: 320px;
    	border-radius: 10px;
    	background-color: white;
   	    margin: 5px 0;
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
                <div class="roomtitle">${subject}</div>
                <div class="cont2">
                    <div class="userlist">
                        <div class="room2">
                            <div class="user">쵹쵹시진핑</div>
                            <div class="user">방장</div>   
                        </div>
                        <div class="roomout">
                        	<i class="fas fa-sign-out-alt"></i>
                        	<p>방 나가기</p>
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
	 
</script>
</html>