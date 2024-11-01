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
        justify-content: space-evenly;
		margin : 5px;
		width: 230px;
		height: 230px;
		background-color : 73734F;
		border-radius: 45px;
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
	<jsp:include page="../main/main.jsp"/>
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
	                    대화방 이름:<input type="text" name="userchat_subject" placeholder="방 제목을 입력하세요.">
	                </li>
	                <li class="roominp">
	                     제한 인원:<input type="range" name="current_people" min="2" max="20" value="5" oninput="document.getElementById('value2').innerHTML=this.value;">
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
                        <li class="title">
                        	${userchat.userchat_subject}
                        	<input type="hidden" name="userchat_subject" value="${userchat.userchat_subject}" readonly/>	
                        </li>
                        <li class="createduser">
                        	${userchat.user_id}
                        	<input type="hidden" name="user_id" class="boss" value="${userchat.user_id}" readonly/>	
                        </li>
                        <li>
                        	<span class="total_${userchat.userchat_idx}"></span> / ${userchat.current_people}
                        </li>
                    </ul>
                </div>
                <div class="roominfo">
                    <div>
                        <ul>
                            <%-- <li>${userchat.total_users}/${userchat.current_people}</li> --%>
                            <li>${userchat.userchat_date}</li>
                        </ul>
                    </div>
				    <button type="button" class="gobtn" 
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
                    statusElement.closest('form').submit();
                    
                } else {
                    statusElement.text("참가하기");
                }
            },
            error: function() {
                console.log("참가 여부 확인 중 오류가 발생했습니다.");
                statusElement.text("오류 발생");
            }
        });
    });  ///////
/*     $('.gobtn').on('click', function(event) {
    	statusElement.closest('form').submit();
    } */
    // 참가 신청   
	/* $('.gobtn').on('click', function(event) {
    	 
         var form = this.closest('form'); 
         var chatboss = form.querySelector('.boss').value;
         var user_id = loginId;
         var chatroomCategory = 'userchat';
         var chatroom_idx = form.querySelector('input[name="userchat_idx"]').value; 
        
        $.ajax({
            url: 'userchatroom.go', 
            type: 'POST',
            data: {
            	chatroom_idx: chatroom_idx
            	},
            success: function(response) {
            	// 기본 폼 제출 막기
                event.preventDefault();
            	
                    if ($(this).text() === "참가") {
                        $(this).closest('form').submit();
                        $(this).text('참가신청중');
                        
                        // 알림 ajax
                        function chatroommanager() {
                            $.ajax({
                                type: 'POST',
                                url: 'chatroommanager.ajax',
                                data: {'my_id': loginId,
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
                        
                    } else if ($(this).text() === "참가신청중") {
                    	
                    }
                }
                console.log("입장");
            },
            error: function() {
                console.log("참가 여부 확인 중 오류가 발생했습니다.");
            }
        });
    }); */
    
    
    
    
    
    
    
    
    
    
 	
    // 각 방에 참여한 사용자 수
    $('.chatroom').each(function() {
        var chatroom_idx = $(this).find('input[name="userchat_idx"]').val();
        console.log(chatroom_idx);
        
        $.ajax({
            url: '/SULBAZI/usertotal.ajax',
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