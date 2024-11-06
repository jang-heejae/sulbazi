<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function() {
   
   var loginId = '${sessionScope.loginId}';
   var msg = "${msg}";

    if(msg!=""){
      alert(msg);
      location.replace('./userchatlist.go');
   }
   
   // SSE(EventSource) 객체 생성
    var sse = new EventSource("/sse/all");
    var sssse = new EventSource("/sssse/all");
    var eventSource = new EventSource('/subscribe');
    var eventSou = new EventSource('/ssubscribe');
    
    sse.addEventListener("newMessage", function(event) {
        loadMessages();
    });

    sssse.addEventListener("newuser", function(event) {
    	loadUserList();
    });
    
    // 연결이 성공적으로 열리면 실행되는 핸들러
    eventSource.onopen = function() {
        console.log('Connection opened');
    };

    // 오류가 발생하면 실행되는 핸들러 - 메세지
    sse.onerror = function(event) {
        console.error('EventSource failed:', event);
        setTimeout(function() {
        	sse = new EventSource("/SULBAZI/sse/all");
        }, 1000); // 1초 후 재연결 시도
    };
    // 오류가 발생하면 실행되는 핸들러 - 사용자 리스트
    sssse.onerror = function(event) {
        console.error('EventSource failed:', event);
        setTimeout(function() {
        	sssse = new EventSource("/SULBAZI/sssse/all");
        }, 1000); // 1초 후 재연결 시도
    };
    // 오류가 발생하면 실행되는 핸들러 - 검색
    eventSource.onerror = function(event) {
        console.error('EventSource failed:', event);
        setTimeout(function() {
        	eventSource = new EventSource('/SULBAZI/subscribe');
        }, 1000); // 1초 후 재연결 시도
    };
    // 오류가 발생하면 실행되는 핸들러
    eventSou.onerror = function(event) {
        console.error('EventSource failed:', event);
        setTimeout(function() {
        	eventSou = new EventSource('/SULBAZI/ssubscribe');
        }, 1000); // 1초 후 재연결 시도
    };

    // 'kick' 이벤트가 수신되면 실행되는 핸들러
    eventSource.addEventListener('kick', function(event) {
        alert(event.data);
        window.location.href = '/SULBAZI/userchatlist.go';
    });
    
 	// 기존 SSE 연결 객체를 사용하여 공지사항 업데이트 이벤트 처리
    eventSou.addEventListener('noticeUpdate', function(event) {
    	var updatedNotice = event.data;
        $('#noticeArea').text(updatedNotice); // 공지사항 영역 업데이트
        alert('공지사항이 업데이트되었습니다.');
    });
    window.onbeforeunload = function() {
        eventSource.close();
    };
 	
   // 방장 권한 준다
   var userId = $('h2').data('userid').toString();
   var menu = $('.menu').css('display');
         
   if(loginId === userId){
      $('.roomoutbtn').hide();
      
      // 방장 권한
      $('.fa-cog').show();
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

   var reported_id;
   var reported_idx;
   var report_txt;
   var reported_nick;
   
   // 신고, 강퇴 팝업창 - 메세지
   $(document).off('click', '.usermsg');
   
   $(document).on('contextmenu', '.usermsg', function(event) {
      
	    event.preventDefault();
        // 클릭한 위치 좌표
        var x = event.pageX;
        var y = event.pageY;
        
        // 신고, 강퇴 할 유저정보
        reported_id = $(this).find('.userid').text().trim();
        reported_idx = $(this).find('.msgidx').text().trim();
        report_txt = $(this).find('.msgtxt').text();
        reported_nick = $(this).find('.usernick').text();
        
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

      var user = $('h2').data('userid').toString();
      
      // 방장은 강퇴 옵션 추가해드림
      if (loginId === user) {
          popup.append('<div class="kickuser"><i class="fas fa-crosshairs"></i> 강퇴 </div>');
      }
      
      popup.css({
          position: 'absolute',
          width: '100px',
          height: '50px',
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
   
   
   
   // 방장은 프로필에서도 강퇴시킬거야       
   $(document).off('click', '.room2');
   
   $(document).on('contextmenu', '.room2', function(event) {
	   
	    event.preventDefault();
	    
        // 클릭한 위치 좌표
        var x = event.pageX;
        var y = event.pageY;
        
        // 강퇴 할 유저정보
        var chatroom_idx = ${idx};
        reported_id = $(this).find('.useridf').text();
        reported_nick = $(this).find('.usernickf').text();
        
        console.log("강퇴할 놈: "+reported_id);
        console.log("나: "+loginId);
        console.log("강퇴 방번호 : "+chatroom_idx);
        
        $('.popup2').remove();
       
        if (reported_id.toString() !== loginId.toString()) {
         var user = $('h2').data('userid').toString();
         if (loginId === user) {
            var popup2 = $(`
            <div class="popup2">
                <div class="kickuser"><i class="fas fa-crosshairs"></i> 강퇴</div>
            </div>
            `);
      }
         
         popup2.css({
             position: 'absolute',
             width: '100px',
             height: '30px',
             left: x + 'px',
             top: y + 'px',
             backgroundColor: '#f9f9f9',
             border: '1px solid #ccc',
             padding: '5px'
         });
         
         
         $('body').append(popup2);
      }
   
    });
   
   
   // 팝업 제거
   $(document).on('click', function(event) {
       if (!$(event.target).closest('.popup2, .room2').length) {
           $('.popup2').remove();
       }
   });
   
   // 신고 할거야
   $(document).on('click', '.reportuser', function() {
	   event.preventDefault();

	   var reporting_id = '${sessionScope.loginId}';
       var report_category = '개인 메시지';
       
       console.log("아작스 신고 당할 사람 "+reported_id);
       console.log("아작스 신고 할 사람 "+reporting_id);
       console.log("아작스 신고할 메세지 번호 "+reported_idx);
       console.log("아작스 신고할사용자 닉 :"+reported_nick);
       
		if (confirm("신고 할거야?")) {
			$('.popup').remove();
			var display = $('.reportuserform').css('display');
	        if (display == 'none'){
	              $('.reportuserform').show();
	              $('.reportuserform').css({'display':'flex'});
	        }else{
	        	alert("신고창이 열려있습니다.");
	        	location.reload();
	        }
	      
	      	$('.reportcancel').on('click', function(){
				$('.reportuserform').hide();
			});
	      
	      	$('.reportedit').click(function(){
				var report_content = $('textarea[name="report_content"]').val();
				console.log("신고 내용" + report_content);
		    	  
				if (!report_content.trim()) {
		            alert("20자 이내로 신고 내용을 입력하세요.");
		            return;
		        }
				
	         $.ajax({
	             url: '/SULBAZI/reportuser.ajax',
	             type: 'POST',
	             data: {
	                reported_id: reported_id,  // 신고받은사람
	                reporting_id: reporting_id, // 신고한사람
	                report_category: report_category,
	                reported_idx: reported_idx,
	                report_content: report_content                 
	             },
	             success: function(response) {
	            	 console.log("신고한사람 : "+reporting_id);			
	     			 console.log("신고받은사람 : "+reported_id);
	                 alert(reported_nick +' 신고 완료');
	                 $('textarea[name="report_content"]').val('');
	                 $('.reportuserform').hide();
	                 loadMessages();
	             },
	             error: function() {
	                 alert(reported_nick +'신고 실패');
	             }
	         });
	         
	      });
	      
	    }else{
			alert("취소되었습니다.");
			$('.popup').remove();
		}
	  
   });

   // 알림 아작스
   function sendNotification(newAlarm) {
	    const receiverId = newAlarm.receiverId;

	    // AJAX POST 요청을 통해 서버에 알림 전송
	    $.ajax({
	        type: 'POST',
	        url: '/SULBAZI/notifications/send', // 알림을 전송할 서버 엔드포인트
	        data: JSON.stringify(newAlarm),
	        contentType: 'application/json',
	        success: function(response) {
	            console.log("알림이 성공적으로 전송되었습니다:", response);
	        },
	        error: function(e) {
	            console.error("알림 전송 실패:", e);
	        }
	    });
	}
   
   // 강퇴시킬거야~
   $(document).on('click', '.kickuser', function() {
              
      var user_id = reported_id;
      var chatroom_idx = ${idx};
      var kickmsg = '<div class="kick">' +reported_nick+ '님 강퇴</div>';
      
       console.log("강퇴당할 "+user_id);
       console.log("강퇴당할방 "+chatroom_idx);
       
       function roomout() {
    	   $.ajax({
    	        type: 'POST',
    	        url: '/SULBAZI/notifications/chatroomout.ajax',
    	        data: {'user_id': user_id,  //수신자ID
    	        		'chatroomboss': loginId},  //대화방 방장ID
    	        dataType: 'JSON',
    	        success: function(alarmresponse) {
    	            // 알림 데이터 객체 생성
    	            const newAlarm = {
    	                receiverId: user_id, //수신자 id
    	                chatroomname: alarmresponse.chatroomname,  //문의 제목
    	                alarm: alarmresponse.alarm, //알림 내용
    	                alarm_idx: alarmresponse.alarm_idx //알림 idx
    	            };
    	            sendNotification(newAlarm); // 알림 전송 함수 호출
    	            saveNotification(newAlarm); // 알림 저장 함수 호출
    	        },
    	        error: function(e) {
    	            console.log("AJAX 요청 실패:", e); // 에러 메시지 출력
    	        }
    	    });
    	}
       
       if (confirm(reported_nick+"를 내보낼거야?")) {
          $.ajax({
              url: '/SULBAZI/kickuser.ajax',
              type: 'POST',
              data: {
                 user_id: user_id,
                 chatroom_idx: chatroom_idx
              },
              success: function(response) {
                  
                  alert(reported_nick +' 아웃');
                  $('.chatlist').append(kickmsg);
                  $('.popup').remove();
                  $('.popup2').remove();
                  loadMessages();
                  roomout();
              },
              error: function() {
                  alert(reported_nick +'강퇴 실패');
              }
          });
          
       }
   });
   
   var eventsource = new EventSource('/SULBAZI/subscribe');

   eventsource.addEventListener('kick', function(event) {
       if (event && event.data) {
           alert(event.data);
       } else {
           alert("강퇴 당했다~");
       }
       window.location.href = '/SULBAZI/userchatlist.go';
   });
   
   
	// 참여자 리스트
   
   var chatroom_idx = ${idx};
   var ownerId = '${userid}';
   
   function loadUserList() {
       $.ajax({
           url: '/SULBAZI/userlist.ajax',
           type: 'GET',
           data: { chatroom_idx: chatroom_idx },
           dataType: 'json',
           success: function(data) {
               $('.ajax').empty(); // 기존 사용자 목록 비우기

               $.each(data, function (index, user) {
                   var userlist = '<div class="room2">';
                   userlist += '<img width="20" alt="프로필" src="/photo/' + user.user_photo + '">';

                   if (user.user_id === loginId && user.user_id === ownerId) {
                       userlist += '<div class="usernickf" style="font-weight: bold; color: blue;"><i class="fas fa-crown"></i>' + user.user_nickname + ' ㉯</div>';
                       userlist += '<div class="useridf" style="display:none;">' + user.user_id + '</div>';
                   } else if (user.user_id === loginId) {
                       userlist += '<div class="usernickf" style="font-weight: bold;">' + user.user_nickname + '㉯</div>';
                       userlist += '<div class="useridf" style="display:none;">' + user.user_id + '</div>';
                   } else if (user.user_id === ownerId) {
                       userlist += '<div class="usernickf" style="font-weight: bold; color: blue;"><i class="fas fa-crown"></i>' + user.user_nickname + '</div>';
                       userlist += '<div class="useridf" style="display:none;">' + user.user_id + '</div>';
                   } else {
                       userlist += '<div class="usernickf">' + user.user_nickname + '</div>';
                       userlist += '<div class="useridf" style="display:none;">' + user.user_id + '</div>';
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
   // 초기 로드
   loadUserList();

    
   
   // 메세지 전송
   function sendMessage(){
       var usermsg_content = $('textarea[name="usermsgcontent"]').val();
       var user_id = $('.textarea').find('input[name="user_id"]').val();
       var userchat_idx = ${idx};

       console.log("메세지내용"+usermsg_content);
       console.log("로그인한 아이디"+loginId);
       console.log("현재방 번호 "+userchat_idx);
       console.log("user_id "+user_id);
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
   }
   
	// 버튼 클릭 메세지 ㄱ
    $('.sendmsg').click(function () {
        sendMessage();
    });

    // 엔터 메세지 ㄱ
    $('textarea[name="usermsgcontent"]').keydown(function (event) {
        if (event.key === "Enter" && !event.shiftKey) {
            event.preventDefault(); // 줄바꿈 방지
            sendMessage();
        }
    });
    
    
    // 메세지를 불러오기
    var userchat_idx = ${idx};
    var ownerId = '${userid}';
    
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
                   
                   if (msg.user_id === loginId && msg.user_id === ownerId) {
                      messageHtml += '<div class="usernick" style="font-weight: bold;"><i class="fas fa-crown"></i>' + msg.user_nickname + ' ㉯</div>';
                    } else if (msg.user_id === loginId) {
                       messageHtml += '<div class="usernick" style="font-weight: bold;">' + msg.user_nickname + ' ㉯</div>';
                    } else if (msg.user_id === ownerId) {
                       messageHtml += '<div class="usernick"><i class="fas fa-crown"></i>' + msg.user_nickname + '</div>';
                    } else {
                       messageHtml += '<div class="usernick">' + msg.user_nickname + '</div>';
                    }
                   
                   messageHtml += '</div>';
                   messageHtml += '<div class="txtbox">';
                   messageHtml += '<div class="msgtxt">' + msg.usermsg_content + '</div>';
                   messageHtml += '<div class="msgidx" style="display:none;">' + msg.usermsg_idx+ '</div>';
                   messageHtml += '<div class="userid" style="display:none;">' + msg.user_id + '</div>';
                   
                   // 시간 출력 바꾸기
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
        height: 650px;
        background-color : #041d03;
      	border-radius: 45px;
    }
    .cont{
        width: 215px;
        height: 650px;
        overflow-y: auto;
    }
    .txt{
        color: white;
        display: flex;
        justify-content: center;
        width: 200px;
        height: 46px;
        font-size: 32px;
    }
    .room{
        left: 10px;
        display: flex;
        justify-content: space-around;
        flex-direction: column;
        margin: 10px;
        width: 180px;
        height: 100px;
        background-color: rgb(255, 140, 9);
        border-radius: 40px;
    }
    .room div:first-child{
    	width: 160px;
        margin-left: 15px;
        display: -webkit-box;
    	-webkit-box-orient: vertical;
    	-webkit-line-clamp: 2;
   		overflow: hidden;
    	text-overflow: ellipsis;  
        
    }
    .room div:last-child{
        font-size: small;
        display: flex;
        justify-content: flex-end;
        margin-right: 15px;
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
       background-color: lightgray;
       align-items: center;
       justify-content: center;
    }
    .title{
        font-size: x-large;
    }
    .people{
   	    position: absolute;
    	right: 10px;
    	font-size: large;
    }
    .cont2{
        display: flex;
        width: 780px;
        background-color: darkkhaki;
    }
    .kick{
        color: darkgrey;
    }
    .userlist{
       display: flex;
       justify-content: space-between;
       width: 200px;
       background-color: white;
       flex-direction: column;
       overflow-y: auto;
    }
    .room2{
        left: 10px;
        display: flex;
        justify-content: space-evenly;
        align-items: center;
        margin: 10px;
        width: 180px;
        height: 50px;
        background-color: lightgray;
        border-radius: 50px;
        border: 1px solid black;
    }
    .room2 img{
       width: 40px;
       height: 40px;
       border-radius: 25px;
       border: 1px solid;
    }
    .roomout{
       display: flex;
       align-items: center;
      justify-content: space-between;
      background-color: lightgray;
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
       background-color: rgb(255, 140, 9);
       width: 300px;
       height: 170px;
       border-radius: 30px;
    }
    .noticearea{
         width: 250px;
         height: 110px;
         border-radius: 15px;
         padding: 5px;
    }
    .noticearea textarea{
       width: 85%;
        height: 100%;
        font-size: x-large;
    }
    .roomedit{
        display: none;
	    position: absolute;
	    top: 460px;
	    background-color: rgb(255, 140, 9);
	    width: 300px;
	    height: 140px;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;	
	    border-radius: 25px;
    }    
    .roomedit li{
    	margin-bottom: 5px;
    }
    .roomeditFli input{
    	border: none;
    	border-radius: 10px;
    	padding: 3px 0px 4px 6px;
    }
    .roominp{
    	display: flex;
    	justify-content: space-around;
    }
    .reportuserform{
       display: none;
       width: 250px;
       height: 200px;
       position: absolute;
       top: 400px;
       right: 0;
       background-color: rgb(255, 140, 9);
       flex-direction: column;
       align-items: center;
       justify-content: center;
       border-radius: 30px;
    }
    .reportuserform textarea{
		width: 80%;
        height: 70%;
        border-radius: 15px;
        padding: 5px;
    }
    .reportedit, .reportcancel, .notiedit, .noticancel, .edit, .cancel{
    	background: white;
	    border-radius: 15px;
	    border: none;
	    cursor: pointer;
	    width: 60px;
    }
    .reportedit:hover, .reportcancel:hover, .notiedit:hover, .noticancel:hover, .edit:hover, .cancel:hover{
    	cursor: pointer;
    	font-weight: bold;
    }
    .msgform{
		width: 580px;
        background-color: lightblue;
    }
    .chatlist{
        width: 100%;
        height: 550px;
        overflow-y: auto;
    }
    .usermsg img{
       border: 1px solid;
    }
    .msgtxt:hover{
       cursor: pointer;
    }
    .fa-crown{
       color: EFE041;
       margin-right: 5px;
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
    .textarea textarea{
          width: 100%;
       font-size: x-large;
          align-content: center;
    }
    textarea{
        border: none;
        resize: none;
        outline: none;
    }
    .sendmsg{
        width: 15%;
    }
</style>
</head>
<body>
<jsp:include page="../main/main.jsp"/>
   <h2 data-userid="${userid}">${userid}님의 ${idx}번 채팅방</h2>
    <div class="main">
        <div class="section">
            <div class="content">
                <div class="roombox">
                    <div class="roomlist">
                    	<div class="txt">나의 대화방</div>
                        <div class="cont">
                            <c:forEach items="${list}" var="userchat">
                            	<form action="userchatroom.go?userchat_idx=${userchat.userchat_idx}" method="post">
	                               <div class="room">
	                                   <div class="roominfo">${userchat.userchat_subject}</div>
	                                   <input type="hidden" name="userchat_idx" value="${userchat.userchat_idx}">
	                                   <input type="hidden" name="user_id" value="${userchat.user_id}">
	                                   <div class="roominfo">${userchat.current_people} / ${userchat.max_people}</div>   
	                               </div>
                               </form>
                            </c:forEach>
                        </div>
                        <div class="back">
                           <a href="userchatlist.go">대화방 리스트로 돌아가기</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chatroom">
                <div class="roomtitle">
                <c:forEach items="${roominfo}" var="roominfo">
                   <div class="title">${roominfo.userchat_subject}</div>
                   <div class="people">${roominfo.current_people} / ${roominfo.max_people}</div>
                   <div class="current" style="display:none;">${roominfo.current_people}</div>
                </c:forEach>
                </div> 
                <div class="cont2">
                    <div class="userlist">
                       <div class="ajax">
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
                                   <c:forEach items="${roominfo}" var="roominfo">
                               <ul>
                                  <li class="roomeditFli">
                                      대화방 이름 : <input type="text" name="userchat_subject" maxlength="20" value="${roominfo.userchat_subject}">
                                  </li>
                                  <li class="roominp">
                                       제한 인원 : <input type="range" name="max_people" min="2" max="20" value="${roominfo.max_people}" oninput="document.getElementById('value2').innerHTML=this.value;">
                                       <p id="value2">${roominfo.max_people}</p>
                                  </li>
                                  <li>
                                     <input type="hidden" name="userchat_idx" value="${roominfo.userchat_idx}" readonly/>
                                  </li>
                                  <li>공개여부 : 
                                     <input type="radio" name="userchat_state" value="1"
                                     <c:if test="${roominfo.userchat_state eq '1'}">checked</c:if>   
                                     />공개   
                                     &nbsp;&nbsp;&nbsp;&nbsp;
                                     <input type="radio" name="userchat_state" value="0"
                                     <c:if test="${roominfo.userchat_state eq '0'}">checked</c:if>   
                                     />비공개
                                  </li>
                                </ul>
                                </c:forEach>
                              <div class="roombtn">
                                 <button class="edit">수정</button>
                                  <button class="cancel">취소</button>
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
                        </div>
                    </div>
                    <div class="msgform">
                    <c:if test="${not empty roominfo}">
                       <c:forEach items="${roominfo}" var="roominfo">
                           <c:if test="${not empty roominfo.notice}">
                               <div class="noti">
                                   <i class="fas fa-bullhorn"></i>
                                   <p id="noticeArea">${roominfo.notice}</p>
                               </div>
                           </c:if>
                       </c:forEach>
                   </c:if>
                        <div class="chatlist">
                        </div>
                        <div class="textarea">
                            <input type="text" name="user_id" value="${sessionScope.loginId}" readonly/>
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

	// 방 이동
	$('.room').click(function(){
		if (confirm("방 이동할거야?")) {
			$(this).closest('form').submit();
		}else{
         	alert("취소되었습니다.");
      	}
	});
	
   // 방 나가기
   $('.roomoutbtn').click(function() {
      if (confirm("방을 나가시겠?")) {
         var chatroom_idx = '${idx}';
         
         $.ajax({
            url: '/SULBAZI/userroomout.ajax',
            type: 'POST',
            data: {chatroom_idx: chatroom_idx},
            success: function(response) {
               alert("잘가고~");
               window.location.href = "userchatlist.go";  // 로컬 채팅방 리스트로 이동
            },
            error: function(error) {
               console.error("에러 발생:", error);
               alert("방 나가기에 실패했습니다.");
            }
         });
      }else{
         alert("취소되었습니다.");
      }
   });
 
   
   // 공지사항 쓸래
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
      var userchat_idx = ${idx};
      
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
                 $('.notice').hide();
                 $('textarea[name="notice"]').val('');
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
       var display = $('.roomedit').css('display');
       if (display == 'none'){
           $('.roomedit').show();
           $('.roomedit').css({'display':'flex'});
       }else{
           $('.roomedit').hide();
       }
    });
    
       
    $('.edit').click(function() {
       
       if (confirm("방 정보를 수정하시겠습니까?")) {
           var userchat_subject = $('input[name="userchat_subject"]').val();
           var max_people = $('input[type="range"]').val();
           var userchat_state = $('input[name="userchat_state"]:checked').val();
           var userchat_idx = ${idx};
           var current = $('.current').text();
           
           console.log(userchat_subject);
           console.log("바꿀 최대인원 "+max_people);
           console.log(userchat_state);
           console.log("지금 방 번호"+userchat_idx);
           console.log("현재 인원"+current);
           
           if(current <= max_people){
	           $.ajax({
	              url:'./updatechatroom.ajax',
	              type:'POST',
	              data:{
	                 userchat_subject: userchat_subject,
	                 max_people: max_people,
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
        	   alert("현재 인원수가 제한 인원수를 초과합니다.")
        	   location.reload();
           }
       }else{
          alert("취소되었습니다.");
       }
    });
    
 	// 방 삭제할거임
	$('.roomdelete').click(function() {
	    if (confirm("방을 삭제하시겠습니까?")) {
	    	var userchat_idx = ${idx};
	    	var current_people = $('.current').text();
	    	var user_id = $('.textarea').find('input[name="user_id"]').val();
	    	var del = "${del}";
	    	console.log("방번호"+userchat_idx);
	    	console.log("사람수"+current_people);
	    	console.log("방장"+user_id);
	        $.ajax({
	        	url:'./deletechatroom.ajax',
	        	type:'POST',
	        	data:{
	                userchat_idx: userchat_idx,
	                current_people: current_people,
	                user_id: user_id
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
   
   // 텍스트 없으면 placeholder 복구
    $('.txtarea').on('blur', function() {
      if ($(this).val() === '') {
        $(this).attr('placeholder', '메세지 입력');  
      }
    });
       
   
   
</script>
</html>