<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    ol, ul, li{
        list-style: none;
    }
    a{
        text-decoration: none;
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
    .newroombtn{        
        z-index: 999;
        position: absolute;
        top: 140px;
        left: 1200px;
        width: 100px;
        height: 25px;
        background-color: 73734F;
        text-align: center;
        border-radius: 10px;
    }
    .createroom{
        display: none;
        position: absolute;
        left: 1100px;
        top: 250px;
        z-index: 999;
        background-color: rgb(106, 106, 219);
        width: 300px;
        height: 120px;
    }
    .newroombtn:hover{
        cursor: pointer;
        font-weight: bold;
    }
    .roominp{
        display: flex;
    }
    .roombtn{
        display: flex;
        justify-content: flex-end;
    }
    .roombtn div{
        background-color: aliceblue;
        text-align: center;
        width: 50px;
        height: 25px;
        margin: 0 10px;
    }
    .roombtn div:hover{
        cursor: pointer;
        font-weight: bold;
    }
    .commitbtn{
    	width: 50px;
        height: 25px;
        background-color: aliceblue;
	    border: none;
	    cursor: pointer;
	    text-align: left;
    }
    .roomname{
        background-color: aquamarine;
    }
    .roomname li{
        margin-bottom: 10px;
    }
    .roominfo{
        background-color: burlywood;
        display: flex;
        justify-content: space-between;
        width: 200px;
        align-items: center;
    }
    .gobtn{
        width: 50px;
        height: 30px;
    }
    .searchbox{
	    position: absolute;
	    top: 80px;
   	    left: 803px;
    }
    .search{
        position: relative;
        width: 300px; /* 원하는 너비 설정 */
        margin: 50px auto; /* 가운데 정렬 */
    }
    .search input{
    	outline: none;
        padding-left: 40px; /* 아이콘의 너비 만큼 여백 추가 */
        width: 100%; /* 부모 요소의 너비에 맞추기 */
        height: 40px; /* 원하는 높이 설정 */
        border: 1px solid #ccc; /* 테두리 스타일 */
        border-radius: 5px; /* 모서리 둥글게 */
    }
    .search i{
        position: absolute;
        left: 10px; /* 아이콘의 위치 설정 */
        top: 50%; /* 수직 중앙 정렬 */
        transform: translateY(-50%); /* 수직 중앙 정렬 */
        color: #aaa; /* 아이콘 색상 */
    }
   
</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
	<section class="searchbox">
        <div class="search">
        	<i class="fas fa-search"></i>
            <input type="text" name="search" placeholder="채팅방 검색">
        </div>
    </section>
	<section class="chatBox">
		<form action="userchatroom.do" method="post">
	        <div class="newroombtn">방 만들기</div>
	        <div class="createroom">
	            <ul>
	                <li>
	                    대화방 이름:<input type="text" name="userchat_subject" placeholder="방 제목을 입력하세요.">
	                </li>
	                <li class="roominp">
	                     제한 인원:<input type="range" name="current_people" min="1" max="20" value="5" oninput="document.getElementById('value2').innerHTML=this.value;">
	                     <p id="value2">5</p>
	                </li>
	                <li>
	                	<input type="hidden" name="user_id" value="${loginId}" readonly/>
	                </li>
	            </ul>
	            <div class="roombtn">
	            	<button type="submit">개설</button>
	                <button class="cancel" type="button">취소</button>
	            </div>
	        </div>
	    </form>  
        <div class="chatitems">
          <c:forEach items="${list}" var="userchat">
          <form action="userchatroom.go?idx=${userchat.userchat_idx}" method="post">
            <div class="chatroom">
                <div class="roomname">
                    <ul>
                    	<li><input type="hidden" name="userchat_idx" value="${userchat.userchat_idx}" readonly/></li>
                    	<li><input type="hidden" name="userchat_date" value="${userchat.userchat_date}" readonly/></li>
                        <li>
                        	${userchat.userchat_subject}
                        	<input type="hidden" name="userchat_subject" value="${userchat.userchat_subject}" readonly/>	
                        </li>
                        <li>
                        	${userchat.user_id}
                        	<input type="hidden" name="user_id" value="${userchat.user_id}" readonly/>	
                        </li>
                    </ul>
                </div>
                <div class="roominfo">
                    <div>
                        <ul>
                            <li>${userchat.current_people}/${userchat.max_people}</li>
                            <li>${userchat.userchat_date}</li>
                        </ul>
                    </div>
                    <button type="submit" class="gobtn">참가</button>
                </div>
            </div>
          </form>
       	</c:forEach>
      </div>
	</section>
</body>
<script>

		// alert
		var msg = "${msg}";
	
		if(msg!=""){
			alert(msg);
		}
		
		var session = "${sessionScope.session}";
		
		console.log(session);
		if(session!=""){
			alert(session);
			location.replace('./userchatlist.go');
		}
		
		// 채팅방 취소 버튼
	    $('.newroombtn, .cancel').click(function(){      
	        var display = $('.createroom').css('display')
	        if (display == 'none'){
	            $('.createroom').show();
	        }else{
	            $('.createroom').hide();
	        }
	    });

		
		
		
</script>
</html>