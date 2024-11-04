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
    p{
        font-size: 55px;
    }
    img{
    	width: 100px;
    	height: 100px;
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
		background-color : #032502;
		border-radius: 45px;
	}
	.chatroom div:nth-child(2){
		color: white;
		margin-left: 15px;
	}
    .roomname{
	    display: flex;
	    align-items: center;
	    justify-content: flex-end;
	    color: white;
    }
    .gobtn{
        width: 50px;
        height: 30px;
        border-radius : 50px;
	    background: #80f109;
	    outline: none;      
	    padding: 0;
        margin-left: 15px;
    }
    .gobtn:hover{
    	cursor: pointer;
        font-weight: bold;
    }
</style>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.opt == 'admin_log'}">
        <jsp:include page="../main/adminMain.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'user_log'}">
        <jsp:include page="../main/main.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'store_log'}">
        <jsp:include page="../main/storeMain.jsp" />
    </c:when>
</c:choose>
	<section class="chatBox">
        <div class="chatitems">
          <c:forEach items="${list}" var="localchat" varStatus="status">
          <form action="localchatroom.go?idx=${localchat.localchat_idx}" method="post">
            <div class="chatroom">
                <div class="roomname">
                	<input type="hidden" name="localchat_idx" value="${localchat.localchat_idx}">
                    <p>${localchat.local_category}</p>
                    <%-- <img src="${someImagePath}/${status.index + 1}.jpg" alt="Chat Image" /> --%>
                    <img src="resources/img/${status.index + 1}.png" alt="Chat Image" />
                </div>
                <div>인원 : <span class="total_${localchat.localchat_idx}"></span>명</div>
                <div class="chatgo">
                    <button type="submit" class="gobtn">참여</button>
                </div>
            </div>
            </form>
       	</c:forEach>
      </div>
	</section>
</body>
<script>

	// 각 방에 참여한 사용자 수
	$('.chatroom').each(function() {
	    var chatroom_idx = $(this).find('input[name="localchat_idx"]').val();
	    console.log(chatroom_idx);
	    
	    $.ajax({
	        url: '/SULBAZI/localusertotal.ajax',
	        method: 'GET',
	        data: { chatroom_idx: chatroom_idx },
	        success: function(count) {
	            // 참여자 수를 표시할 DOM 요소에 업데이트
	            console.log(count);
	            $('.total_' + chatroom_idx).text(count);
	
	            // 참가 버튼 표시 조건
	           /*  var currentPeople = parseInt('${userchat.current_people}');
	            if (count < currentPeople) {
	                $('#joinButton_' + chatroomId).show();
	            } */
	        },
	        error: function() {
	        	$('.total_' + chatroom_idx).text('Error');
	        }
	    });
	    
	});
</script>
</html>