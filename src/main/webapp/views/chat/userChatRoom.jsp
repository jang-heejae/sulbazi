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
        justify-content: space-around;
        flex-direction: column;
        margin: 10px;
        width: 180px;
        height: 100px;
        background-color: aliceblue;
        border-radius: 10px;
    }
    .room div:first-child{
        margin-left: 10px;
    }
    .room div:last-child{
        font-size: small;
        display: flex;
        justify-content: flex-end;
        margin-right: 10px;
    }
    
    /* 채팅방 */
    .chatroom{
        width: 780px;
        height: 650px;
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
        width: 200px;
        height: 600px;
        background-color: darkcyan;
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
	<h2>${userid}님의 ${idx} ${roomidx}번 채팅방</h2>
	<a href="userchatlist.go">뒤로가기</a>
    <div class="main">
        <div class="section">
            <div class="content">
                <div class="roombox">
                    <div class="roomlist">
                        <div class="cont">
                            <div class="txt">나의 대화방</div>
                            <c:forEach items="${list}" var="userchat">
	                            <div class="room">
	                                <div class="roominfo">${userchat.userchat_subject}</div>
	                                <div class="roominfo">${userchat.current_people}/${userchat.max_people}</div>   
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chatroom">
                <div class="roomtitle">${subject}</div>
                <div class="cont2">
                    <div class="userlist">
                        <div class="room2">
                            <div class="user">쵹쵹시진핑</div>
                            <div class="user">방장</div>   
                        </div>
                    </div>
                    <div class="msgform">
                        <div class="chatlist">
                            <c:forEach items="${usermsg}" var = "msg">
                            	<p>${userNicknames[msg.user_id]}</p>
                                <p>${msg.usermsg_content}</p>
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
</body>
<script>
	
	$('.txtarea').on('focus', function() {
	      $(this).attr('placeholder', '');  // 포커스되면 placeholder 제거
	    });

	    $('.txtarea').on('blur', function() {
	      if ($(this).val() === '') {
	        $(this).attr('placeholder', '메세지 입력');  // 텍스트가 없으면 placeholder 복구
	      }
	    });
	    
	$('.sendmsg').click(function(){
	    var txt = $('textarea[name=usermsgcontent]').val();
	    console.log(txt);
	});
</script>
</html>