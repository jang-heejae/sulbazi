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
   
 	// SSE 연결을 한 번만 열도록 관리하는 변수
    let sseAll = null;
    let eventSourceKick = null;

    // 메세지, 유저리스트, 수정, 공지 관련 SSE
    function setupSseAll() {
        if (sseAll) {
            console.log("메세지, 유저리스트, 수정, 공지 SSE 이미 연결됨");
            return; // 이미 연결되어 있으면 추가 연결을 하지 않음
        }

        sseAll = new EventSource("/sse/all");

        // 새로고침 SSE
        sseAll.addEventListener('reload', function(event) {
            location.reload();  
    	});
        
        // 메세지 SSE
        sseAll.addEventListener("newMessage", function(event) {
            loadMessages();
        });

        // 사용자 리스트 SSE
        sseAll.addEventListener("newuser", function(event) {
            loadUserList();
        });

        // 수정 SSE
        sseAll.addEventListener("updateRoom", function(event){
            var updateRoom = event.data;
            location.reload();
            alert('방 정보가 업데이트되었습니다.');
        });

        // 공지 SSE
        sseAll.addEventListener('noticeUpdate', function(event) {
            var updatedNotice = event.data;
        	
         	// DOM이 준비된 후 업데이트 작업 실행
            $(document).ready(function() {
                if (updatedNotice.trim() !== '') {
                    $('#noticeArea').text(updatedNotice);
                    $('.noti').show();
                } else {
                    $('#noticeArea').text('');
                    $('.noti').hide();
                }
                
                alert('공지사항이 업데이트되었습니다.');
            });
        });

        sseAll.onopen = function() {
            console.log('메세지, 유저리스트, 수정, 공지 SSE 연결 열림');
        };

        sseAll.onerror = function(event) {
            reconnectEventSource("/sse/all"); // 오류 발생 시 /sse/all로 재연결 시도
        };
    }

    // 강퇴 관련 SSE
    function setupSseKick() {
        if (eventSourceKick) {
            console.log("강퇴 SSE 이미 연결됨");
            return; // 이미 연결되어 있으면 추가 연결을 하지 않음
        }
        
        eventSourceKick = new EventSource('/subscribe');

        // 강퇴 SSE
        eventSourceKick.addEventListener('kick', function(event) {
            if (event && event.data) {
                alert(event.data);
                alert("강퇴 당해찌~");
                window.location.href = 'userchatlist.go';
                
                
                location.reload();
            } else {
                alert("??");
            }
         
        });

        eventSourceKick.onopen = function() {
            console.log('강퇴 SSE 연결 열림');
        };

        eventSourceKick.onerror = function(event) {
            reconnectEventSource('/subscribe'); // 오류 발생 시 /subscribe로 재연결 시도
        };
	   
    }
    


    
    // SSE 재연결 함수
    function reconnectEventSource(url) {
        console.error('EventSource failed, reconnecting...');
        setTimeout(function() {
            if (url === "/sse/all") {
                setupSseAll(); // /sse/all 연결 재설정
            } else if (url === '/subscribe') {
                setupSseKick(); // /subscribe 연결 재설정
            } else if( url === '/reload'){
            	eventAlluser();
            }
        }, 1000); // 재연결 시도
    }

    // 페이지가 닫힐 때 SSE 연결 종료
    window.onbeforeunload = function() {
        if (sseAll) sseAll.close();
        if (eventSourceKick) eventSourceKick.close();
        if (eventAlluser) eventAlluser.close();
    };

    // 페이지 로딩 시 필요한 SSE 설정을 호출
    setupSseAll(); // 메세지, 유저리스트, 수정, 공지 관련 SSE 설정
    setupSseKick(); // 강퇴 관련 SSE 설정

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
		             url: 'reportuser.ajax',
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
	        url: 'notifications/send', // 알림을 전송할 서버 엔드포인트
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
    	        url: 'notifications/chatroomout.ajax',
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
    	        },
    	        error: function(e) {
    	            console.log("AJAX 요청 실패:", e); // 에러 메시지 출력
    	        }
    	    });
    	}
       
       if (confirm(reported_nick+"를 내보낼거야?")) {
          $.ajax({
              url: 'kickuser.ajax',
              type: 'POST',
              data: {
                 user_id: user_id,
                 chatroom_idx: chatroom_idx
              },
				success: function(response) {
                  
                alert(reported_nick +' 아웃');
                $('.popup').remove();
                $('.popup2').remove();
                roomout();
                loadMessages();
                
            	 // 서버에 새로고침 알림을 요청
                $.ajax({
                    url: '/reload',  // 새로고침 알림을 처리하는 서버 엔드포인트
                    type: 'GET',
                    success: function(response) {
                        // 10초 후에 페이지 새로 고침
                        setTimeout(function() {
                            location.reload();
                        }, 5000);  // 10초 후 새로 고침
                    },
                    error: function() {
                        alert("새로고침 알림 전송 실패");
                    }
                });
              },
              error: function() {
                  alert(reported_nick +'강퇴 실패');
              }
          });
          
       }
   });
   
   
	// 참여자 리스트
   
   var chatroom_idx = ${idx};
   var ownerId = '${userid}';
   
   function loadUserList() {
	    $.ajax({
	        url: 'userlist.ajax',
	        type: 'GET',
	        data: { chatroom_idx: chatroom_idx },
	        dataType: 'json',
	        success: function(data) {
	            // 사용자 목록을 갱신하기 전에, 기존 사용자 목록을 캐시
	            var currentUserList = $('.ajax');
	            var existingUsers = currentUserList.children().map(function() {
	                return $(this).find('.useridf').text();
	            }).get();

	            $.each(data, function(index, user) {
	                var userlist = '<div class="room2">';
	                var userPhotoUrl = "/photo/" + user.user_photo;
	                var userImage = '<img width="20" alt="프로필" src="' + userPhotoUrl + '" onerror="this.src=\'/default-photo.jpg\'">';

	                userlist += userImage;

	                if (user.user_id === loginId && user.user_id === ownerId) {
	                    userlist += '<div class="usernickf" style="font-weight: bold; color: blue;"><i class="fas fa-crown"></i>' + user.user_nickname + ' ㉯</div>';
	                } else if (user.user_id === loginId) {
	                    userlist += '<div class="usernickf" style="font-weight: bold;">' + user.user_nickname + '㉯</div>';
	                } else if (user.user_id === ownerId) {
	                    userlist += '<div class="usernickf" style="font-weight: bold; color: blue;"><i class="fas fa-crown"></i>' + user.user_nickname + '</div>';
	                } else {
	                    userlist += '<div class="usernickf">' + user.user_nickname + '</div>';
	                }

	                userlist += '<div class="useridf" style="display:none;">' + user.user_id + '</div>';
	                userlist += '</div>';

	                // 기존에 있는 사용자가 아니라면 새로 추가
	                if ($.inArray(user.user_id, existingUsers) === -1) {
	                    currentUserList.append(userlist);
	                }
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
           url: 'sendMessage.ajax',
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
            url: 'loadMessages.ajax',
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

/* // 종원 유저 프로필 작성중
var opt = '${sessionScope.opt}';
$(document).on('click', '.usernickf', function() {
    var userId = $(this).text().trim();
    letItgo(userId);
    
});

//종원 유저 프로필 만들기

		
		
$(document).ready(function() {
    // 유저 프로필 닫기 버튼 이벤트
    $(document).on('click', '#userprofileexit', function() {
        $('#userprofile').hide();
    });

    // 프로필 불러오기 함수 (letItgo)
    $(document).on('click', '.user-profile', function() {
        var userId = $(this).data('user-id');
        if (userId) {
            letItgo(userId);
        }
    });

    // "좋아요" 클릭 시 동작
    $(document).on('click', '#userLike', function() {
        var userId = $(this).data('user-id');
        if (userId) {
            clickLike(userId);
        }
    });


});

function letItgo(userId) {
$.ajax({
    type: 'POST',
    url: 'letItgo.ajax',
    data: {
        "userId": userId,
        "loginId": loginId
    },
    dataType: 'json',
    success: function(data) {
        if (data && data.user) {
            drawProfile(data.user, data.userLike);
            $('#userprofile').show();
        } else {
            alert('유저 정보를 불러올 수 없습니다.');
        }
    },
    error: function(xhr, status, error) {
        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
    }
});
}


function drawProfile(userdto, userLikedto) {
var optNameString = userdto.opt_name;
var optNameArray = optNameString ? optNameString.split(",") : [];


var content = '';
content += '<div class="user-details">';
content += '<div class="whitebox">';
content += '<table class="profile-table">';
content += '<tbody>';
content += '<tr>';
content += '<td><button class="nickname btn-button">' + userdto.user_nickname + '</button></td></tr>';
content += '<tr><td>';
if (userdto.user_gender == '남') {
    content += '<button class="genderboy btn-button"><span class="boy">♂</span>&nbsp;' + userdto.user_gender + '</button>';
} else if (userdto.user_gender == '여') {
    content += '<button class="gendergirl btn-button"><span class="girl">♀</span>&nbsp;' + userdto.user_gender + '</button>';
}

if (opt == 'user_log') {
    content += '<button class="like btn-button" id="userLike" data-user-id="' + userdto.user_id + '">';
} else {
    content += '<button class="like btn-button" id="userLike">';
}
if (userLikedto != 0) {
    content += '<img class="jongwonIcon" src="resources/img/이종원 좋아요후.png">좋아요' + userdto.user_likecount + '</button>';
} else {
    content += '<img class="jongwonIcon" src="resources/img/이종원 좋아요전.png">좋아요' + userdto.user_likecount + '</button>';
}
content += '</td></tr>';
content += '<tr><td>';
if (optNameArray && optNameArray.length > 0) {
    optNameArray.forEach(function(name) {
        content += '<button class="category btn-button">' + name + '</button>';
    });
}
content += '</td></tr>';
content += '</tbody></table>';

content += '<img src="photo/' + userdto.user_photo + '" alt="User Photo" class="user-ph">';
$('#modalbodyprofile').html(content);
}



function clickLike(userId){
if(loginId != userId){
   console.log("유저좋아요: " + userId);
   console.log("로그인 유저: " + loginId);
$.ajax({
   type:'post', 
   url: 'profile2.ajax',
   data:{
       'userId':userId,
       'loginId':loginId
   },
   dataType:'JSON',
   success:function(data){
       if (data.success >=1) {
           letItgo(userId);
           alert("좋아요를 취소하였습니다");
       }else{
           letItgo(userId);
           
       }
   },
   error:function(e){
       console.log(e);
       if (opt == 'admin_log') {
          alert("관리자는 좋아요를 할수없습니다 다시 확인해 주세요");
      }else if (opt == 'store_log') {
          alert("매장회원은 좋아요를 할수 없습니다 다시 확인해 주세요");
      }else{
           alert("좋아요를 실패하셨습니다. 다시 확인해 주세요.");
      }
   }
});
}else{
   alert('자신에게 좋아요 다메요');
}
}

 */
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
        cursor: pointer;
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
    .room:hover{
    	cursor: pointer;
    	background-color: rgb(255, 140, 9);
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
    .noti{
    	display: none;
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


/*   종원   */
/* 유저프로필 상세보기 종원 */
/* 유저 프로필 드로우 */
/* 유저 프로필 모달 */
/* .hide{
	display: none;
}
.user_profile {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 380px;
    height: auto;
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 10px;
    box-shadow: 0px 4px 8px #2ac323;
    color: #041d03;
    text-align: center;
    font-family: "Yeon Sung", system-ui;
}
.close_madal {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    margin: -38px -28px 1px 1px;
}
.close_madal:hover,
.close_madal:focus {
    color: black;
}
.btn_madal {
    background-color: rgb(255, 140, 9);
    color: #041d03;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin: 10px;
    font-family: "Yeon Sung", system-ui;
}
.btn_madal:hover {
    background-color: #20290E;
    color: white;
}
.user-details {
    position: relative;
    border: 1px solid #ccc;
    padding: 15px;
    background-color: rgb(255, 140, 9);
    color: white;
    border-radius: 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    width: 300px; /* 원하는 너비로 조정 */
    height: auto; /* 높이는 자동으로 조정 */
    
}
.close-button {
    cursor: pointer;
    color: black;
    float: right;
    z-index:100;
}

.user-ph {
    position:absolute;
    top: -83px;
    left: 105px;
    display: block; /* 블록 요소로 만들어 수평 중앙 정렬 */
    margin: 0 auto; /* 수평 중앙 정렬 */
    width: 130px; /* 사진 너비 */
    height: 130px; /* 사진 높이 */
    border-radius: 50%; /* 원형으로 만들기 */
    object-fit: cover; /* 이미지 비율 유지 */
}
.whitebox {
    text-align: center;
    background-color: white;
    margin: 15% 5%;
    border-radius: 15px;      	
}
.btn-button{
    background-color: #041d03;
    color: white;
    width: 10 auto;
    margin: 1%;
    height: 40px;
    border-radius: 15px;
    border: none;
    font-weight: bolder;
    padding-left: 20px;
    padding-right: 20px;
}
.nickname{
    font-size: 25px;
}
.genderboy, .gendergirl, .like{
    font-size: 20px;
}
.category{
    font-size: 16px;
}
.girl{
    font-weight: bolder;
    font-size: 22px;
}

.jongwonIcon{
    width: 25px;
    height: 25px;
    margin: 0 0 0 0;
    position: relative;
    top:3px;
    left: -10px;
}
#userLike{
cursor: pointer;
}
.profile-table{
	width: 100%; 
}
.profile-table td {
            vertical-align: top; /* 세로 정렬을 위쪽으로 설정 */
            padding: 5px 10px; /* 여백 추가 */
            text-align: center;
}    
    
    */
    
    
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
	                    <c:forEach items="${roominfo}" var="roominfo">
						    <c:if test="${not empty roominfo.notice}">
						        <div class="noti">
						            <i class="fas fa-bullhorn"></i>
						            <p id="noticeArea">${roominfo.notice}</p>
						        </div>
						    </c:if>
						</c:forEach>	
	                    <div class="chatlist">
	                    </div>
	                    <div class="textarea">
	                        <input type="text" name="user_id" value="${sessionScope.loginId}" readonly/>
	                        <textarea name="usermsgcontent" placeholder="메세지 입력(100자 이내)" maxlength="100"></textarea>
	                        <button type="button" class="sendmsg">전송</button>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- 종원 -->
    <!-- 사용자 프로필 모달창 
    <div id="userprofile" class="user_profile" style="display: none;">
        <div class="modal-content_madal">
            <span class="close_madal close-button" onclick="$('#userprofile').hide();">&times;</span>
                <div id="modalbodyprofile">
                    
                </div>
            <button class="btn_madal" id="userprofileexit">닫기</button>
        </div>
    </div>
-->


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
            url: 'userroomout.ajax',
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
              url:'updatenotice.ajax',
              type:'POST',
              data:{
                  notice:notice,
                  userchat_idx: userchat_idx
              },
              success: function(response){
            		// 공지사항을 수정한 후 박스 갱신
                  	if (notice.trim() !== '') {
	                      // 공지사항이 존재하면 박스를 보이게 하고 내용을 업데이트
	                      $('#noticeArea').text(notice);
	                      $('.noti').show();
                  	} else {
	                      // 공지사항이 비어있으면 박스를 숨김
	                      $('#noticeArea').text('');
	                      $('.noti').hide();
                  	}
	                 $('.notice').hide();
	                 alert('공지사항이 수정되었습니다.');
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
           
           if(parseInt(current) <= parseInt(max_people)){
	           $.ajax({
	              url:'updatechatroom.ajax',
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
	        	url:'deletechatroom.ajax',
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