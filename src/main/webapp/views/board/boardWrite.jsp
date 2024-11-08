<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
    .boardlist{
        position: relative;
        width: 1200px;
        height: 700px;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        margin-top: 10%;
        left: 20%;
        padding: 3% 10% 3% 10%;
        box-sizing: border-box;
        font-family: "Yeon Sung", system-ui;
    }
    .bboard{
		background-color: #73734F;
		display: flex;
		justify-content: center; 
		align-items: center;    
		flex-direction: column;   
		border-radius: 8px;
		font-family: "Yeon Sung", system-ui;
    }
    th{
       width: 100px;
       font-family: "Yeon Sung", system-ui;
    }
   .what{
      height: 60px;
      font-family: "Yeon Sung", system-ui;
   }
   .category{
      font-size: 20px;
      font-family: "Yeon Sung", system-ui;
   }
   .date{
      font-size: 16px;
      font-family: "Yeon Sung", system-ui;
   }
   .subject{
      width: 550px;
      height: 20px;
      text-align: left;
      vertical-align: top;
      font-family: "Yeon Sung", system-ui;
   }

   .alxwnf{
     width: 750px;
     margin-left: 1%;
     background-color: gray;
     height: 2px;
     font-family: "Yeon Sung", system-ui;
  }
  textarea{
        width: 100%;
        height: 250px;
        border-radius: 8px;
        resize: none;
        font-family: "Yeon Sung", system-ui;
    }
	.content{
		width: 763px;
		font-family: "Yeon Sung", system-ui;
	}
	.contentphoto img {
    max-height: auto; /* 최대 높이를 100%로 설정 */
    max-width: auto; /* 최대 너비를 100%로 설정 */
}
.contentphoto {
    height: 200px; /* 높이 설정 */
    width: 100%; /* 너비를 100%로 설정 */
    overflow: hidden; /* 넘치는 부분 숨기기 */
    position: relative; /* 자식 요소의 위치 설정을 위해 relative로 설정 */
    background-color: gray;
    border-radius: 8px;
}

.contentphoto img {
    position: absolute; /* 절대 위치 설정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    width: 100%; /* 너비 100%로 설정 */
    height: 100%; /* 높이 100%로 설정 */
    transform: translate(-50%, -50%); /* 중앙으로 이동 */
}
	button {
	width: 50px;
	font-family: "Yeon Sung", system-ui;
}
#board_category{
	font-family: "Yeon Sung", system-ui;
}
input[type="button"]{
width: 50px;
font-family: "Yeon Sung", system-ui;
}
</style>
</head>
<body>
<c:import url="../main/main.jsp"/>
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
    <div class="boardlist">
       <div class="bboard">
       <form id="boardForm" method="post" enctype="multipart/form-data">
         <table class="table">
            <tr class="what">
               <th>
               		<select name="board_category" id="board_category">
	                    <option value="이벤트">이벤트</option>
	                    <option value="홍보">홍보</option>
	                    <option value="신메뉴">신메뉴</option>
	                    <option value="신규오픈">신규오픈</option>
                  	</select>
               </th>
               <th>제목</th>
               <th><input class="subject" type="text" name="board_subject" value=""></th>
            </tr>
            <tr>
            	<th class="contentphoto" colspan="3"><img id="previewImage" src="/photo/기본이미지.png" alt="기본 이미지"></th>
            </tr>
         </table>
         <hr class="alxwnf">
         <table>
         	<tr>
         		<th colspan="3" class="content">
         			<textarea name="board_content"></textarea>
         		</th>
         	</tr>
         	<tr>
         	
         		<th>
         		<input type="file" id="file" name="file" multiple="multiple" onchange="previewFile()">
         		</th>
         		<th></th>
         		<th>
				  <button type="button" onclick="cancelPost()">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="button" value="등록" onclick="confirmPost(event)"/>
				</th>
         	</tr>
         </table>
         <input type="hidden" id="store_id" value="'${sessionScope.loginId}'">
       </form>
       </div>
    </div>
</body>
<script>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');


font-family: "Yeon Sung", system-ui;
var loginId = '${sessionScope.loginId}'
console.log(loginId);
document.getElementById("store_id").value = loginId;
//main_menu 클릭 이벤트

function previewFile() {
    var fileInput = document.querySelector('#file');
    var file = fileInput.files[0];
    var preview = document.querySelector('#previewImage');
    
    if (file) {
        // 파일이 선택되면 미리보기 이미지 변경
        var reader = new FileReader();
        reader.onloadend = function() {
            preview.src = reader.result;  // 선택된 파일을 미리보기 이미지로 설정
        };
        reader.readAsDataURL(file);
    } else {
        // 파일이 없으면 기본 이미지 표시
        preview.src = '/photo/기본이미지.png';
    }
}

function submitForm() {
    var fileInput = document.querySelector('#file');
    if (!fileInput.files.length) {
        // 파일이 선택되지 않았을 경우 기본 이미지 경로를 첨부하여 전송
        var inputData = new FormData();
        inputData.append("file", "/photo/기본이미지.png");  // 기본 이미지 경로를 서버로 전송
        // Ajax를 통해 전송하거나 폼을 전송하는 방법 등 추가 구현
    } else {
        // 파일이 선택된 경우 FormData에 파일 추가
        var formData = new FormData(document.querySelector('form'));
        // Ajax로 폼을 전송하거나 일반 폼 제출
    }
}

var user_ids_str = '${bookmarkuser}'; // 예: '[ee, 11]'

// 문자열을 올바른 배열로 변환

document.querySelectorAll('.main_menu').forEach(function(menu) {
    menu.addEventListener('click', function() {
        var fullElement = document.querySelector('.full');
        var displayfull = window.getComputedStyle(fullElement).display;

        if (displayfull === 'none') {
            // .full2, .sub_, .sub_1 숨기기
            document.querySelectorAll('.full2, .sub_, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .full 클래스 요소를 flex로 설정
            fullElement.style.display = 'flex';
        } else {
            // .full 클래스 요소 숨기기
            fullElement.style.display = 'none';
        }
    });
});

function cancelPost() {
    // '취소' 버튼 클릭 시 확인 창 표시
    if (confirm("게시글 작성을 취소하시겠습니까?")) {
      // 확인을 누르면 boardList.go로 이동 (취소)
      location.href = 'boardList.go';
    }
    // 취소를 누르면 아무 것도 하지 않음
  }

  // 등록 버튼 클릭 시 처리 함수
  function confirmPost(event) {
    // '등록' 버튼 클릭 시 확인 창 표시
    if (confirm("게시글을 작성하시겠습니까?")) {
      // 확인을 누르면 save(event) 함수 호출 (등록)
      save(event);
    }
    // 취소를 누르면 아무 것도 하지 않음
  }

// mypage 클릭 이벤트
document.querySelectorAll('.mypage').forEach(function(mypage) {
    mypage.addEventListener('click', function() {
        var full2Element = document.querySelector('.full2');
        var displayfull2 = window.getComputedStyle(full2Element).display;

        if (displayfull2 === 'none') {
            // .full, .sub_, .sub_1 숨기기
            document.querySelectorAll('.full, .sub_, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .full2 클래스 요소를 flex로 설정
            full2Element.style.display = 'flex';
        } else {
            // .full2 클래스 요소 숨기기
            full2Element.style.display = 'none';
        }
    });
});

// fa-message 클릭 이벤트
document.querySelectorAll('.fa-message').forEach(function(message) {
    message.addEventListener('click', function() {
        var sub1Element = document.querySelector('.sub_1');
        var displaysub_1 = window.getComputedStyle(sub1Element).display;

        if (displaysub_1 === 'none') {
            // .full, .full2, .sub_ 숨기기
            document.querySelectorAll('.full, .full2, .sub_').forEach(function(element) {
                element.style.display = 'none';
            });
            // .sub_1 클래스 요소 보이기
            sub1Element.style.display = 'block';
        } else {
            // .sub_1 클래스 요소 숨기기
            sub1Element.style.display = 'none';
        }
    });
});

// fa-bell 클릭 이벤트
document.querySelectorAll('.fa-bell').forEach(function(bell) {
    bell.addEventListener('click', function() {
        var subElement = document.querySelector('.sub_');
        var displaysub = window.getComputedStyle(subElement).display;

        if (displaysub === 'none') {
            // .full, .full2, .sub_1 숨기기
            document.querySelectorAll('.full, .full2, .sub_1').forEach(function(element) {
                element.style.display = 'none';
            });
            // .sub_ 클래스 요소 보이기
            subElement.style.display = 'block';
        } else {
            // .sub_ 클래스 요소 숨기기
            subElement.style.display = 'none';
        }
    });
});
document.getElementById('file').addEventListener('change', function(event) {
    const file = event.target.files[0]; // 선택된 파일 가져오기
    const contentPhoto = document.querySelector('.contentphoto'); // 이미지가 나타날 요소 가져오기

    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            // 이미지 생성
            const img = document.createElement('img');
            img.src = e.target.result; // 파일의 데이터 URL
            img.classList.add('photo1'); // 스타일 클래스 추가

            // contentphoto에 이미지 추가
            contentPhoto.innerHTML = ''; // 기존 내용 삭제
            contentPhoto.appendChild(img); // 이미지 추가
        };

        reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기
    }
});

function save(event) {
    var form = new FormData($('#boardForm')[0]);
    form.append('loginId', $('#store_id').val());
    var files = document.querySelector('input[type="file"]').files;
	var user_ids = JSON.parse(user_ids_str.replace(/(\w+)/g, '"$1"')); 
	
	console.log(user_ids);

    for (var i = 0; i < files.length; i++) {
        form.append('file', files[i]);
    }

    $.ajax({
        type: 'POST',
        url: 'boardWrite.ajax',
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        data: form,
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if (data.success) {
                alert(data.message);

                // 모든 bookmarknew 호출을 Promise 배열로 만듭니다.
                const bookmarkPromises = [];

                // user_ids 배열의 각 user_id에 대해 bookmarknew 호출을 추가합니다.
                user_ids.forEach(function(user_id) {
                    bookmarkPromises.push(bookmarknew(user_id));
                });

                // 모든 Promise가 완료될 때까지 기다립니다.
                Promise.all(bookmarkPromises)
                    .then(results => {
                        console.log("모든 알림이 성공적으로 전송되었습니다:", results);
                        // 모든 요청이 성공적으로 완료된 후 링크 이동
                        location.href = data.link; // 링크 이동
                    })
                    .catch(error => {
                        console.error("알림 전송 중 오류 발생:", error);
                        // 오류가 발생할 경우에도 링크 이동이 필요하다면 아래 코드 추가
                        // location.href = data.link; // 필요 시 링크 이동
                    });
            }

        },
        error: function(e) {
            console.log(e);
        }
    });
}


//즐찾 새소식
function bookmarknew(user_id) {
	return new Promise((resolve, reject) => {
	    $.ajax({
	        type: 'POST',
	        url: 'notifications/bookmarknew.ajax',
	        data: JSON.stringify({ user_id: user_id }), // user_id를 JSON 형식으로 변환
	        contentType: 'application/json', // JSON 형식으로 전송
	        dataType: 'json',
	        success: function(alarmResponse) {
	            // 응답받은 데이터로 알림 전송
	            const newAlarm = {
	                receiverId: user_id,
	                chatroomname: alarmResponse.chatroomname,
	                alarm: alarmResponse.alarm,
	                alarm_idx: alarmResponse.alarm_idx
	            };
	            sendNotification(newAlarm);
	            resolve(alarmResponse); // 성공 시 resolve 호출
	        },
	        error: function(e) {
	            console.log("AJAX 요청 실패:", e);
	            reject(e);
	        }
	    });
    });
}



//서버에 알림 전송 함수 
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

</script>
</html>