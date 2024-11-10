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
width: 80px;
border-radius: 8px;
}
.fuck{
	border-radius: 8px;
	width: 50px;
}
#file{
	font-family: "Yeon Sung", system-ui;
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
    <div class="boardlist">
       <div class="bboard">
       <form id="boardForm" method="post" enctype="multipart/form-data">
         <table class="table">
            <tr class="what">
               <th>
               		<select name="board_category" id="board_category">
	                    <option value="'${info.board_category}'">${info.board_category}</option>
	                    <option value="이벤트">이벤트</option>
	                    <option value="홍보">홍보</option>
	                    <option value="신메뉴">신메뉴</option>
	                    <option value="신규오픈">신규오픈</option>
                  	</select>
               </th>
               <th>제목</th>
               <th><input class="subject" type="text" name="board_subject" value="${info.board_subject}"></th>
            </tr>
            <tr>
            	<th class="contentphoto" colspan="3"><img src="/photo/${files}" alt="Photo"/></th>
            </tr>
         </table>
         <hr class="alxwnf">
         <table>
         	<tr>
         		<th colspan="3" class="content">
         			<textarea name="board_content">${info.board_content}</textarea>
         		</th>
         	</tr>
         	<tr>
         		<th><input type="file" id="file" multiple="multiple"></th>
         		<th></th>
         		<th>
	         		<button class="fuck" type="button" onclick="cancelEdit()">취소</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="fuck2" type="button" value="수정하기" onclick="confirmEdit(event)"/>

         	</tr>
         </table>
         <input type="hidden" id="store_id" value="'${sessionScope.loginId}'">
         <input type="hidden" name="board_idx" value="${info.board_idx}">
       </form>
       </div>
    </div>
</body>
<script>
var loginId = '${sessionScope.loginId}';
var board_idx = '${info.board_idx}';
console.log(board_idx);
console.log(loginId);
document.getElementById("store_id").value = loginId;
//main_menu 클릭 이벤트

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

function cancelEdit() {
    // '취소' 버튼 클릭 시 확인 창 표시
    if (confirm("게시글 수정을 취소하시겠습니까?")) {
      // 확인을 누르면 boardList.go로 이동 (취소)
      location.href = 'boardList.go';
    }
    // 취소를 누르면 아무 것도 하지 않음
  }

  // 수정하기 버튼 클릭 시 처리 함수
  function confirmEdit(event) {
    // '수정하기' 버튼 클릭 시 확인 창 표시
    if (confirm("게시글을 수정하시겠습니까?")) {
      // 확인을 누르면 save(event) 함수 호출 (수정)
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

    for (var i = 0; i < files.length; i++) {
        form.append('file', files[i]);
    }

    $.ajax({
        type: 'POST',
        url: 'update.ajax',
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        data: form,
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if (data.success) {
				location.href=data.link
			}
        },
        error: function(e) {
            console.log(e);
        }
    });
}
</script>
</html>