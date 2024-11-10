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
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
		margin-top: 150px;
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	flex-wrap: wrap;
    	justify-content: space-between;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
    	border: 2px solid rgb(255, 140, 9);
    	    flex-direction: column;
	}
    .boardlist{
        border-radius: 10px;
        padding: 3% 10% 3% 10%;
        box-sizing: border-box;
        font-family: "Yeon Sung", system-ui;
            display: flex;
    flex-direction: column;
    align-items: center;
    }
	#boardForm{
    height: 100%;
    width:  100%;
	}
   .category{
      font-size: 20px;
      font-family: "Yeon Sung", system-ui;
   }
   .subject{
      width: 550px;
      height: 20px;
      text-align: left;
      vertical-align: top;
      font-family: "Yeon Sung", system-ui;
   }

  textarea{
        width: 100%;
        height: 250px;
        border-radius: 8px;
        resize: none;
        font-family: "Yeon Sung", system-ui;
        padding: 5px;
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
    	width: 100%; /* 너비 100%로 설정 */
    	height: 100%; /* 높이 100%로 설정 */
    	transform: translate(-50%, -50%); /* 중앙으로 이동 */
	}
	.bdBtn {
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
		width: 46px;
	}
	#bsub ul{
	    display: flex;
    	flex-direction: row;
	}
	.bsub {
		width: 100%;
	    margin-top: 25px;
	}
	#board_category{
		width: 95px;
		text-align: center;
	}
	#board_category, input{
		padding: 3px;
		border-radius: 10px;
	}
	#file{
	    width: 618px;
	}
	.btnUl{
		display: flex;
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
<section class="chatBox2">
	<div class="chatitems2">
    	<form id="boardForm" method="post" enctype="multipart/form-data">
       	<input type="hidden" id="store_id" value="'${sessionScope.loginId}'">
    		<div class="boardlist">
				<div id="bsub">
					<ul>
						<li>
               				<select name="board_category" id="board_category">
	                    		<option value="이벤트">이벤트</option>
	                    		<option value="홍보">홍보</option>
	                    		<option value="신메뉴">신메뉴</option>
	                    		<option value="신규오픈">신규오픈</option>
                  			</select>
                  		</li>
                  		<li>
							<span>제목</span>
               				<input class="subject" type="text" name="board_subject" value="">
              			</li>
               		</ul>
               </div>
               <div class="bsub">
               		<ul>
						<li>
							<div class="contentphoto">
								<img id="previewImage" src="/photo/기본이미지.png" alt="기본 이미지">
							</div>
						</li>
						<li><textarea name="board_content"></textarea></li>
					</ul>
				</div>
				<div>
					<ul class="btnUl">				
         				<li><input type="file" id="file" name="file" multiple="multiple" onchange="previewFile()"></li>
				  		<li><button type="button" class="bdBtn" onclick="cancelPost()">취소</button></li>
				  		<li><button type="button" class="bdBtn" onclick="confirmPost(event)"> 등록</button></li>
    				</ul>
    			</div>
    		</div>
     	</form>
    </div>
</section>
</body>
<script>
$(document).ready(function() {
    var textarea = $('#textarea');

    // textarea 내용의 줄 수를 세어 rows 속성 설정
    var lines = (textarea.val().split("\n").length) + 1; // \n의 개수를 세어 줄 수 계산
    textarea.attr('rows', lines);
});
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