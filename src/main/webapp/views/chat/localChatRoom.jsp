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
.chatroom{
    width: 780px;
    height: 650px;;
    background-color: lightseagreen;
}
</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
	<h2>${loginId}님의 ${roomidx}번 채팅방</h2>
	<a href="userchatlist.go">뒤로가기</a>
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
            </div>
        </div>
    </div>
</body>
<script>

</script>
</html>