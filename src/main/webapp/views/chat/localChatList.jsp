<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    a{
        text-decoration: none;
        color: black;
    }
	.chatBox{
		display: flex;
   		justify-content: space-around;
   		align-items: center;
		width : 100%;
		height: 100%;
	}
	.chatitems{
		position: absolute;
		top: 20%;
	    width: 940px;
	    height: 650px;
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: center;
	    background-color: rgb(255, 140, 9);
	    border-radius: 20px;
	    overflow-y: auto; /* 수직 스크롤 활성화 */
	}
	.chatroom{
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
		margin : 5px;
		width: 230px;
		height: 230px;
		background-color : 73734F;
		border-radius: 45px;
	}
    .roomname{
        background-color: aquamarine;
    }
    p{
        font-size: 55px;
    }
    .gobtn{
        width: 50px;
        height: 50px;
    }
    .gobtn:hover{
    	cursor: pointer;
        font-weight: bold;
    }
</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
	<section class="chatBox">
        <div class="chatitems">
          <c:forEach items="${list}" var="localchat">
            <div class="chatroom">
                <div class="roomname">
                    <p>${localchat.local_category}</p>
                    <img>
                </div>
                <div class="chatgo">
                    <div class="gobtn" onclick="location.href='localchatroom.do'">참여</div>
                </div>
            </div>
       	</c:forEach>
      </div>
	</section>
</body>
<script>

</script>
</html>