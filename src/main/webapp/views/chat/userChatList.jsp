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
    .searchbox{
   		display: flex;
	    position: absolute;
	    top: 80px;
   	    left: 803px;
    }
    .search{
        display: flex;
    	align-items: center;
        position: relative;
        width: 300px; /* 원하는 너비 설정 */
        margin: 50px auto; /* 가운데 정렬 */
    }
    .search i{
        position: absolute;
        left: 10px; /* 아이콘의 위치 설정 */
        top: 50%; /* 수직 중앙 정렬 */
        transform: translateY(-50%); /* 수직 중앙 정렬 */
        color: #aaa; /* 아이콘 색상 */
    }
    .search input{
    	outline: none;
        padding-left: 40px; /* 아이콘의 너비 만큼 여백 추가 */
        width: 100%; /* 부모 요소의 너비에 맞추기 */
        height: 40px; /* 원하는 높이 설정 */
        border: 1px solid #ccc; /* 테두리 스타일 */
        border-radius: 5px; /* 모서리 둥글게 */
    }
    .search p{
    	width: 50px;
    	color: white;
    	font-size: small;
    }
    .return{
		width: 50px;
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
	    margin: 5px;
	    width: 230px;
	    height: 230px;
	    background-color: 73734F;
	    border-radius: 45px;
	    justify-content: center;
	}
	.title{
		font-size: large;
		font-weight: bold;
	}
	.createduser{
		font-size: medium;
	}
    .newroombtn{        
        z-index: 999;
        position: absolute;
        top: 140px;
        left: 1240px;
        width: 100px;
        height: 25px;
        background-color: 73734F;
        text-align: center;
        border-radius: 10px;
    }
    .createroom{
        padding: 12px;
	    display: none;
	    position: absolute;
	    left: 1100px;
	    top: 198px;
	    z-index: 999;
	    background-color: rgb(255, 140, 9);
	    width: 310px;
	    height: 122px;
	    border: 1px solid black;
	    border-radius: 20px;
    }
    .newroombtn:hover{
        cursor: pointer;
        font-weight: bold;
    }
    .roominp{
        display: flex;
        margin-top: 10px;
    }
    .roombtn{
        display: flex;
        justify-content: flex-end;
    }
    .roombtn button{
    	background: white;
	    border-radius: 15px;
	    border: none;
	    cursor: pointer;
	    width: 70px;	
	    margin-left: 5px;
    }
    .roombtn button:hover{
    	cursor: pointer;
    	font-weight: bold;
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
	    border: none;
	    cursor: pointer;
	    text-align: left;
    }
    .roomname ul{
        margin: 15px 10px 0px 10px;
    }
    .title{
    	font-size: 24px;
    }	
    .createduser{
    	margin-top: 10px;
    }
    .createduser img{
    	width: 35px;
	    height: 35px;
	    border-radius: 50px;
	    margin-right: 5px;
    }
    .createduser{
    	font-size: 20px;
    }
    .roominfo{
        display: flex;
        justify-content: space-between;
        width: 200px;
        align-items: center;
        margin: 0px 10px;
    }
    .userinfo{
    	margin-top: 2px;
    	font-size: large;
    }
    .gobtn{
        border-radius : 50px;
	    background: #80f109;
	    outline: none;      
	    padding: 0;
        margin-left: 15px;
    }
    .return a{
	    position: absolute;
	    top: 66px;
	    left: 308px;
    	width: 70px;
	    border-radius: 4px;
    	font-size: small;
    }
    .return a:hover{
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
	<section class="searchbox">
        <div class="search">
        	<i class="fas fa-search"></i>
            <input type="text" class="searchInput" name="search" placeholder="채팅방 제목 검색">
        </div>
        <div class="return">
            <a href="userchatlist.go" class="returnbtn">결과 초기화</a>
        </div>
    </section>
	<section class="chatBox">
		<form action="userchatroom.do" method="post">
	        <div class="newroombtn">방 만들기</div>
	        <div class="createroom">
	            <ul>
	                <li>
	                    대화방 이름 : <input type="text" name="userchat_subject" maxlength="20" placeholder="20자 이내로 입력 하세요">
	                </li>
	                <li class="roominp">
	                     제한 인원 : <input type="range" name="max_people" min="2" max="20" value="5" oninput="document.getElementById('value2').innerHTML=this.value;">
	                     <div id="value2">5</div>
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
          <c:set var="user" value="${userinfo[userchat.user_id]}" />
          <form action="userchatroom.go?idx=${userchat.userchat_idx}" method="post">
            <div class="chatroom">
                <div class="roomname">
                    <ul>
                    	<li><input type="hidden" name="userchat_idx" value="${userchat.userchat_idx}" readonly/></li>
                    	<li><input type="hidden" name="userchat_date" value="${userchat.userchat_date}" readonly/></li>
                        <li class="title">
                        	${userchat.userchat_subject}
                        	<input type="hidden" name="userchat_subject" value="${userchat.userchat_subject}" readonly/>	
                        </li>
                        <li class="createduser">
                        	<img src="/photo/${user.user_photo}" alt="프로필 사진" />${user.user_nickname}
                        	<input type="hidden" name="user_id" class="boss" value="${userchat.user_id}" readonly/>	
                        </li>
                        
                    </ul>
                </div>
                <div class="roominfo">
                    <div>
                        <ul>
	                        <li class="userinfo">
	                        	${userchat.current_people} / ${userchat.max_people}
	                        	<input type="hidden" name="current_people" value="${userchat.current_people}" readonly/>
	                        	<input type="hidden" name="max_people" value="${userchat.max_people}" readonly/>
	                        </li>
                            <li>${userchat.userchat_date}</li>
                        </ul>
                    </div>
				    <button type="submit" class="gobtn" 
	                        data-user-id="${sessionScope.loginId}" 
	                        data-chatroom-idx="${userchat.userchat_idx}">
		                    참가 상태 확인 중...
	                </button>
                </div>
            </div>
          </form>
       	</c:forEach>
      </div>
	</section>
</body>
<script>

$(document).ready(function() {
	var user_id = '${sessionScope.loginId}';
	console.log(user_id);
	
    // 채팅방 취소 버튼
    $('.newroombtn, .cancel').click(function(){      
        var display = $('.createroom').css('display');
        if (display == 'none'){
            $('.createroom').show();
        }else{
            $('.createroom').hide();
        }
    });
    
    // 서버에서 보내온 model alert
    var msg = "${msg}";

    if(msg!=""){
        alert(msg);
        location.replace('./userchatlist.go');
    }
    
    
    // 서버에서 보내온 session alert
    var session = "${sessionScope.session}";
    
    console.log(session);
    if(session!=""){
        alert(session);
    }
 

    // 참가 상태를 확인    
    $('.gobtn').each(function() {
        var statusElement = $(this);
        var user_id = statusElement.data('user-id');
        var chatroom_idx = statusElement.data('chatroom-idx');
        
        // 참가 상태를 확인
        $.ajax({
            url: '/SULBAZI/userchek.ajax', 
            type: 'POST',
            data: {
                user_id: user_id,
                chatroom_idx: chatroom_idx
            },
            success: function(response) {
              
                if (response.partistate === 0) {
                    statusElement.text("참가신청중");
                } else if (response.partistate === 1) {
                    statusElement.text("참가중");
                } else {
                    statusElement.text("참가하기");
                }
            },
            error: function() {
                console.log("참가 여부 확인 중 오류가 발생했습니다.");
                statusElement.text("오류 발생");
            }
        });
    }); 
    

    // 참가 신청   
	$('.gobtn').on('click', function(event) {
		event.preventDefault();
		 
		var form = $(this).closest('form');
		
		chatboss = $(this).closest('form').find('input[name="user_id"]').val(); 
        console.log(" 방장 "+chatboss);
        var chatroom_idx = form.find('input[name="userchat_idx"]').val(); 
        console.log(" 방 "+chatroom_idx);
        var buttonText = $(this).text();
		
		if(buttonText === "참가중") {
			$(this).closest('form').submit();
		}else if(buttonText === "참가하기"){     
			$(this).closest('form').submit();
			chatroommanager();
		}else if(buttonText === "참가신청중") {
			console.log("내아이디"+user_id);
	    	console.log("취소할 방"+chatroom_idx);
			$.ajax({
				type: 'POST',
	            url: './cancelparti.ajax',
	            data: {
	            	user_id: user_id,
	             	chatroom_idx: chatroom_idx
	             },
	            dataType: 'JSON',
	            success: function(response) {
	            	console.log("서버 응답:", response);
	             	alert("신청 취소");
	             	location.reload();
	             },
	             error: function(e) {
	                console.log("AJAX 요청 실패:", e);
	             }
	         });
		}

    });
    
	// 알림 ajax
	function chatroommanager() {

		$.ajax({
			type: 'POST',
            url: 'chatroommanager.ajax',
            data: {'my_id': user_id,
             		'user_id': chatboss},
            dataType: 'JSON',
            success: function(alarmresponse) {
            	const newAlarm = alarmresponse;
             	addAlarm(newAlarm);
             	console.log("신청 완료");
             },
             error: function(e) {
                console.log("AJAX 요청 실패:", e);
             }
         });
	}
       
 
    // 페이지 로드 시 검색어가 있을 경우
    var storedQuery = localStorage.getItem('searchQuery'); // 로컬 스토리지에서 검색어 가져오기
    if (storedQuery) {
        $('.searchInput').val(storedQuery); // 검색창에 검색어 설정
        search(storedQuery); // 저장된 검색어로 검색 수행
    }

    // input 검색창 엔터치면 동작
    $('.searchInput').keydown(function(event) {
        if (event.keyCode === 13) {
            event.preventDefault(); // 기본 동작 방지
            var query = $('.searchInput').val().trim(); // 입력값 공백 제거
            search(query); // 검색 함수 호출
        }
    });

    // 검색 함수
    function search(query) {
        console.log(query);

        if (query) {
            localStorage.setItem('searchQuery', query); // 검색어를 로컬 스토리지에 저장
            // AJAX 요청으로 검색 결과 가져오기
            $.ajax({
                url: './search.ajax',
                method: 'GET',
                data: { query: query }, // 검색어 서버에 전달
                success: function(response) {
                    if (response.length > 0) {
                        searchlist(response);
                    } else {
                        $('.chatitems').html('<p>검색 결과가 없습니다.</p>');
                    }
                },
                error: function(error, status, xhr) {
                    console.error("검색 실패:", error);
                    $('.chatitems').html('<p>검색 중 오류가 발생했습니다.</p>');
                }
            });
        } else {
            $('.chatitems').html('<p>검색어를 입력하세요.</p>');
        }
    }
    
    function searchlist(response) {
        var result= '';
        
        response.forEach(function(userchat) {
            result += '<form action="userchatroom.go?idx=' + userchat.userchat_idx + '" method="post">';
            result += '<div class="chatroom">';
            result += '<div class="roomname">';
            result += '<ul>';
            result += '<li><input type="hidden" name="userchat_idx" value="' + userchat.userchat_idx + '" readonly/></li>'; 
            result += '<li><input type="hidden" name="userchat_date" value="' + userchat.userchat_date + '" readonly/></li>';
            result += '<li>' + userchat.userchat_subject + '<input type="hidden" name="userchat_subject" value="' + userchat.userchat_subject + '" readonly/></li>';
            result += '<li>' + userchat.user_id + '</li>';
            result += '</ul>';
            result += '</div>';
            result += '<div class="roominfo">';
            result += '<div>';
            result += '<ul>';
            result += '<li>' + userchat.current_people + '/' + userchat.max_people + '</li>';
            result += '<li>' + userchat.userchat_date + '</li>';
            result += '</ul>';
            result += '</div>';
            result += '<button type="submit" class="gobtn">참가</button>';
            result += '</div>';
            result += '</div>';
            result += '</form>';
        });

        $('.chatitems').html(result);
    }
    
    
    $('.returnbtn').click(function() {
        // 다른 페이지로 이동 시 검색어 삭제
        localStorage.removeItem('searchQuery'); // 검색어 삭제
        location.href = "userchatlist.go"; // 리스트 페이지로 이동
    });
    
    
    
});
</script>
</html>