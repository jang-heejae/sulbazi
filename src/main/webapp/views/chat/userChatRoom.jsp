<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	var loginId = '${sessionScope.loginId}';
	var msg = "${msg}";
	
	if(msg!=""){
		alert(msg);
		location.replace('./userchatlist.go');
	}
	
	$(document).ready(function() {

		// 방 개설자만 세팅창 보이기
		var userId = $('h2').data('userid').toString();
		var menu = $('.menu').css('display');
				
		if(loginId === userId){
			$('.fa-cog').show();
			// 방장 권한
			$('.fa-cog, .setting').on({
		        'mouseenter':function(e){
		            $('.setting').css({'display':'block'});
		        },
		        'mouseleave':function(e){
		            $('.setting').css({'display':'none'});
		        }
		    }); 
		}else{
			console.log(loginId);
			$('.fa-cog').hide();
		}
		
	    
		// 메세지 전송
	    $('.sendmsg').click(function () {
	        var usermsg_content = $('textarea[name="usermsgcontent"]').val();
	        var user_id = $('input[name="user_id"]').val();
	        var userchat_idx = ${idx};
	
	        console.log("메세지내용"+usermsg_content);
	        console.log("로그인한 아이디"+loginId);
	        console.log("현재방 번호 "+userchat_idx);
	        if (usermsg_content.trim() === "") {
	            alert("메세지를 입력해주세요.");
	            return;
	        }

	        $.ajax({
	            url: '/SULBAZI/sendMessage.ajax',
	            type: 'POST',
	            data: {
	            	user_id: user_id,
	                usermsg_content: usermsg_content,
	                userchat_idx: userchat_idx
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
	    var userchat_idx = ${idx};
	    setInterval(loadMessages, 1000);

	    function loadMessages() {
	        $.ajax({
	            url: '/SULBAZI/loadMessages.ajax',
	            type: 'GET',
	            data: { userchat_idx: userchat_idx },
	            dataType: 'json',
	            success: function (data) {
	                $('.chatlist').empty();
	                $.each(data, function (index, msg) {
	          
	                	var messageHtml = '<div class="usermsg">';
	                	messageHtml += '<div class="user">';
	                	messageHtml += '<img alt="프로필" src="/photo/' + msg.user_photo + '" class="user-photo">';
				    	messageHtml += '<div class="usernick">' + msg.user_nickname + '</div>';
	                	messageHtml += '</div>';
	                	messageHtml += '<div class="txtbox">';
	                	messageHtml += '<div class="msgtxt">' + msg.usermsg_content + '</div>';
	                	// msg.usermsg_time을 원하는 형식으로 변환
	                	var date = new Date(msg.usermsg_time);
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
    h2{
    	display: none;
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
        top: 18%;
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
    .back{
    	margin: 20px;
    }
    .back:hover{
    	cursor: pointer;
    	font-weight: bold;
   		text-decoration: underline;
   		color: white;
    }
    
    
    /* 채팅방 */
    .chatroom{
        width: 780px;
    }
    .roomtitle{
        display: flex;
	    width: 780px;
	    height: 50px;
	    background-color: bisque;
	    align-items: center;
	    justify-content: center;
    }
    .title{
   	    font-size: x-large;
    }
    .cont2{
        display: flex;
        width: 780px;
        background-color: darkkhaki;
    }
    .userlist{
    	display: flex;
   	    justify-content: space-between;
	    width: 200px;
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
    .setting{
    	display: none;
    	position: absolute;
   	    width: 95px;
   		height: 65px;
   		background-color: aliceblue;
   		bottom: 25px;
   		padding: 5px;
    }
    .setting div:hover{
    	cursor: pointer;
    	font-weight: bold;
    }
    .notice{
    	display: none;
        position: absolute;    
        top: 390px;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    background-color: green;
	    width: 300px;
	    height: 180px;
    }
    .noticearea{
   	    width: 260px;
   		height: 100px;
    }
    
    .roomedit{
    	display: none;
   	    position: absolute;
	    top: 460px;
	    background-color: rgb(106, 106, 219);
	    width: 300px;
        height: 120px;
    }
    
    
    
    
    
    
    .msgform{
        width: 580px;
        background-color: darkolivegreen;
    }
    .chatlist{
        background-color: thistle;
        width: 100%;
        height: 550px;
        overflow-y: auto;
    }
    .noti{
    	display: flex;
   	    align-items: center;
	    position: relative;
    	left: 5%;
	    width: 520px;
	    height: 50px;
    	background-color: FFEA00;
    	border-radius: 15px;
    	margin: 5px 0px;
    }
    .noti i{
   	    margin: 0 5px;
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
	<h2 data-userid="${userid}">${userid}님의 ${idx} ${roomidx}번 채팅방</h2>
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
	                                <div class="roominfo">/${userchat.current_people}</div>   
	                            </div>
                            </c:forEach>
                            <div class="back">
                            	<a href="userchatlist.go">뒤로가기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chatroom">
                <div class="roomtitle">
            	<c:forEach items="${roominfo}" var="roominfo">
                	<div class="title">${roominfo.userchat_subject}</div>
                	<div class="people">${usertotal}/${roominfo.current_people}</div>
                </c:forEach>
                </div>
                <div class="cont2">
                    <div class="userlist">
                    	<div>
                    	<c:forEach items="${userlist}" var="userlist">
                        <div class="room2">
							<img width="20" alt="img" src="/photo/${userPhotos[userlist.user_id]}">
                            <div class="user">${userNicknames[userlist.user_id]}</div>
                        </div>
                        </c:forEach>
                        </div>
                        <div class="roomout">
                        	<div class="roomoutbtn">
	                        	<i class="fas fa-sign-out-alt"></i>
	                        	<p>방 나가기</p>
                        	</div>
                       		<div class="menu" name="menulist">
                       			<i class="fas fa-cog"></i>
                       			<div class="setting">
								    <div class="notification"><p>공지사항</p></div>
								    <div class="roominfoupdate"><p>방 정보 변경</p></div>
								    <div class="roomdelete"><p>방 삭제</p></div>
                       			</div>
                       			<div class="notice">
                       				<h3>
                       					<i class="fas fa-bullhorn"></i>
                       					공지사항
                       				</h3>
                       				<textarea class="noticearea" name="notice" placeholder="50자 이내로 공지사항을 입력하세요." maxlength="50"></textarea>
                       				<div class="noticebtn">
						            	<button class="notiedit">등록</button>
						                <button class="noticancel">취소</button>
						            </div>
                       			</div>
                       			<div class="roomedit">
                       				<c:forEach items="${list}" var="userchat">
				                	<ul>
						                <li>
						                    대화방 이름:<input type="text" name="userchat_subject" value="${userchat.userchat_subject}">
						                </li>
						                <li class="roominp">
						                     제한 인원:<input type="range" name="current_people" min="1" max="20" value="${userchat.current_people}" oninput="document.getElementById('value2').innerHTML=this.value;">
						                     <p id="value2">${userchat.current_people}</p>
						                </li>
						                <li>
						                	<input type="hidden" name="userchat_idx" value="${userchat.userchat_idx}" readonly/>
						                </li>
						                <li>
						                	<input type="radio" name="userchat_state" value="1"
						                	<c:if test="${userchat.userchat_state eq '1'}">checked</c:if>	
						                	/>공개	
						                	&nbsp;&nbsp;&nbsp;&nbsp;
						                	<input type="radio" name="userchat_state" value="0"
						                	<c:if test="${userchat.userchat_state eq '0'}">checked</c:if>	
						                	/>비공개
						                </li>
					           		</ul>
					           		</c:forEach>
						            <div class="roombtn">
						            	<button class="edit">수정</button>
						                <button class="cancel">취소</button>
						            </div>
                       			</div>
							</div>
                        </div>
                    </div>
                    <div class="msgform">
					    <c:if test="${not empty roominfo}">
					        <c:forEach items="${roominfo}" var="roominfo">
					            <c:if test="${not empty roominfo.notice}">
					                <div class="noti">
					                    <i class="fas fa-bullhorn"></i>
					                    <p>${roominfo.notice}</p>
					                </div>
					            </c:if>
					        </c:forEach>
					    </c:if>
                        <div class="chatlist">
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
	// 방 인원수
/* 	var total = ${usertotal};
	$('.people').text(total);
 */
	// 공지사항
	$('.notification, .noticancel').click(function() {
   	   var display = $('.notice').css('display');
          if (display == 'none'){
              $('.notice').show();
              $('.notice').css({'display':'flex'});
          }else{
              $('.notice').hide();
          }
    });
	
	// 공지 등록, 수정
	$('.notiedit').click(function() {
		var notice= $('textarea[name="notice"]').val();
		var userchat_idx = $('input[name="userchat_idx"]').val(); 
		
		if (confirm("공지사항을 등록하시겠습니까?")) {
			console.log(notice);
			console.log(userchat_idx);
			
			$.ajax({
	        	url:'./updatenotice.ajax',
	        	type:'POST',
	        	data:{
	        		notice:notice,
	                userchat_idx: userchat_idx
	        	},
	        	success: function(response){
	        		location.reload();
	        		alert('수정 완료.');
	        	}, error: function(){
	        		alert('수정 실패.');
	        	}
	        });
		}else{
			alert("취소되었습니다.");
		}
	});
	
	
    // 방 정보 변경
    $('.roominfoupdate, .edit, .cancel').click(function(){
    	$('.roomedit').toggle();     	
    });
    
    	
    $('.edit').click(function() {
    	
	    if (confirm("방 정보를 수정하시겠습니까?")) {
	        var userchat_subject = $('input[name="userchat_subject"]').val();
	        var current_people = $('input[name="current_people"]').val();
	        var userchat_state = $('input[name="userchat_state"]:checked').val();
	        var userchat_idx = $('input[name="userchat_idx"]').val();
	        
	        console.log(userchat_subject);
	        console.log(current_people);
	        console.log(userchat_state);
	        console.log(userchat_idx);
	        
	        $.ajax({
	        	url:'./updatechatroom.ajax',
	        	type:'POST',
	        	data:{
	        		userchat_subject: userchat_subject,
	                current_people: current_people,
	                userchat_state: userchat_state,
	                userchat_idx: userchat_idx
	        	},
	        	success: function(response){
	        		location.reload();
	        		alert('수정 완료.');
	        	}, error: function(){
	        		alert('수정 실패.');
	        	}
	        });
	    }else{
	    	alert("취소되었습니다.");
	    }
    });
    
	// 방삭제
	$('.roomdelete').click(function() {
	    if (confirm("방을 삭제하시겠습니까?")) {
	    	var userchat_idx = $('input[name="userchat_idx"]').val();
	    	var current_people = $('input[name="current_people"]').val();
	    	var userId = $('h2').data('userid');
	    	var del = "${del}";
	    	
	        $.ajax({
	        	url:'./deletechatroom.ajax',
	        	type:'POST',
	        	data:{
	                userchat_idx: userchat_idx,
	                current_people: current_people,
	                userId: userId
	        	},
	        	success: function(response){
	        		if(response.status === "success"){
	        			window.location.href = './userchatlist.go';
		        		alert(response.message);
	        		}else{
	        			alert(response.message);
	        		}
	        		
	        	}, error: function(){
	        		alert(del);
	        	}
	        });
	    }else{
	    	alert("취소되었습니다.");
	    }
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
	    
	$('.sendmsg').click(function(){
	    var txt = $('textarea[name=usermsgcontent]').val();
	    console.log(txt);
	});
	
</script>
</html>