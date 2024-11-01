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

		// 참여자 리스트
		var localchat_idx = ${roomidx};
		
	    function localloadUserList() {
	        $.ajax({
	            url: '/SULBAZI/localuserlist.ajax',
	            type: 'GET',
	            data: { localchat_idx: localchat_idx },
	            dataType: 'json',
	            success: function(data) {
	                $('.ajax').empty(); // 기존 사용자 목록 비우기

	                $.each(data, function (index, user) {
	      	          
	                	var userlist = '<div class="room2">';
	                    userlist += '<img width="20" alt="프로필" src="/photo/' + user.user_photo + '">';
	                    
	                    if (user.user_id === loginId) {
	                        userlist += '<div class="user" style="font-weight: bold;">' + user.user_nickname + '㉯</div>';
	                    } else {
	                        userlist += '<div class="user">' + user.user_nickname + '</div>';
	                    }
	                    
	                    userlist += '</div>';
	                	
	                	$('.ajax').append(userlist);
	                    
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('AJAX 요청 실패:', status, error);
	            }
	        });
	    }
		
	    localloadUserList();
		
	 // 신고 팝업창 - 메세지
		$(document).off('click', '.usermsg');
		
		$(document).on('click', '.usermsg', function(event) {
			
	        // 클릭한 위치 좌표
	        var x = event.pageX;
	        var y = event.pageY;
	        
	        // 신고 할 유저정보
	        reported_id = $(this).find('.userid').text().trim();
			reported_idx = $(this).find('.msgidx').text().trim();
			report_txt = $(this).find('.msgtxt').text();
			reported_nick = $(this).find('.user').text();
	        
		    console.log("메세지 쓴 사람 ID : "+reported_id);
		    console.log("신고한 메세지 idx : "+reported_idx);
		    console.log("신고한 메세지 txt : "+report_txt);
	        console.log("현재 로그인한 사람 ID :"+loginId);
	        console.log("신고할사용자 닉 :"+reported_nick);
	        
	        $('.popup').remove();
	       
		    if (reported_id.toString() !== loginId.toString()) {
				
				var popup = $(`
				    <div class="popup">
				        <div class="reportuser"><i class="fas fa-exclamation-circle"></i>신고</div>
				    </div>
				`);
					
				popup.css({
				    position: 'absolute',
				    width: '100px',
				    height: '30px',
				    left: x + 'px',
				    top: y + 'px',
				    backgroundColor: '#f9f9f9',
				    border: '1px solid #ccc',
				    padding: '5px'
				});
				
				
				$('body').append(popup);
			}
		
	    });
		
		// 팝업 제거
		$(document).on('click', function(event) {
		    if (!$(event.target).closest('.popup, .msgtxt').length) {
		        $('.popup').remove();
		    }
		});
		
		
		// 신고 할거야
		$(document).on('click', '.reportuser', function() {
				
			var display = $('.reportuserform, .reportcancel').css('display');
			if (display == 'none'){
		             $('.reportuserform').show();
		             $('.reportuserform').css({'display':'flex'});
		         }else{
		             $('.reportuserform').hide();
		         }
			
			$('.reportedit').click(function(){
				
				var reporting_id = '${sessionScope.loginId}';
				var report_content = $('textarea[name="report_content"]').val();
				var report_category = '지역 메시지';
				
			    console.log("아작스 신고 당할 사람 "+reported_id);
			    console.log("아작스 신고 할 사람 "+reporting_id);
				console.log("아작스 신고할 메세지 번호 "+reported_idx);
				console.log("신고 내용" + report_content);
				console.log("아작스 신고할사용자 닉 :"+reported_nick);
				
			    $.ajax({
			        url: '/SULBAZI/localreportuser.ajax',
			        type: 'POST',
			        data: {
			        	reported_id: reported_id,
			        	reporting_id: reporting_id,
			        	report_category: report_category,
			        	reported_idx: reported_idx,
			        	report_content: report_content		        	
			        },
			        success: function(response) {
			            
			            alert(reported_nick +' 신고 완료');
			            $('.reportuserform').hide();
			            $('.popup').remove();
			            loadMessages();
			        },
			        error: function() {
			            alert(reported_nick +'신고 실패');
			        }
			    });
				
			});
			
		});

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
	                loadMessages();  
	                $('textarea[name="usermsgcontent"]').val("");  
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
	                	 
	                	if (msg.user_id === loginId) {
	                		messageHtml += '<div class="user" style="font-weight: bold;">' + msg.user_nickname + '㉯</div>';
	                    } else {
	                    	messageHtml += '<div class="user">' + msg.user_nickname + '</div>';
	                    }
       					
	                	messageHtml += '</div>';
	                	messageHtml += '<div class="txtbox">';
	                	messageHtml += '<div class="msgtxt">' + msg.localmsg_content + '</div>';
	                	messageHtml += '<div class="msgidx" style="display:none;">' + msg.localmsg_idx+ '</div>';
	                	messageHtml += '<div class="userid" style="display:none;">' + msg.user_id + '</div>';
	                	
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
.popup div:hover,
.popup2 div:hover {
    font-weight: bold;
    cursor: pointer;
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
    .reportuserform{
    	display: none;
	    width: 250px;
	    height: 200px;
	    position: absolute;
	    top: 400px;
	    right: 0;
	    background-color: brown;
	    flex-direction: column;
	    align-items: center;
	    justify-content: center;
    }
    .reportuserform textarea{
   	    width: 80%;
    	height: 70%;
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
                    	<div class="ajax">
                        </div>
                        <div class="roomout">
                        	<div class="roomoutbtn">
	                        	<i class="fas fa-sign-out-alt"></i>
	                        	<p>방 나가기</p>
                        	</div>                  	
                        </div>
                        <div class="reportuserform">
                       		<h3>
                       			<i class="fas fa-exclamation-circle"></i>
                       			신고
                       		</h3>
                      		<textarea class="reportarea" name="report_content" placeholder="20자 이내로 신고내용을 입력하세요." maxlength="20"></textarea>
                      		<div class="reportbtn">
					            <button class="reportedit">신고</button>
					            <button class="reportcancel">취소</button>
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
		var chatroom_idx = '${roomidx}';
		
		$.ajax({
			url: '/SULBAZI/localroomout.ajax',
			type: 'POST',
			data: {chatroom_idx: chatroom_idx},
			success: function(response) {
				alert("잘가고~");
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