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
   @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
    img.icon{
      width:25px;
   }
    *{
        margin: 0;
        padding: 0;
    }
    ol, ul, li{
        list-style: none;
    }
    a{
        text-decoration: none;
        color: white;
    }
    body{
        background-color: #041d03;
    }
    .navbar{
        z-index: 99;
        position: absolute;
        left: 360px;
        justify-items: center;
        width: 1200px;
        height: 120px;
        background-color: #041d03;
        color: rgb(255, 140, 9);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .icon{
        display: flex;
    }
    .logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: 160px;
        color: rgb(255, 140, 9);
        font-size: 70px;
        font-weight: bolder;
    }
    .icon li{
        padding: 10px;
    }
    .fullbox{
        display: flex;
    }
    .full{
        z-index: 999;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list1 li, .list2 li{
        padding: 20px;
    }
    .full2{
        z-index: 999;
        position: absolute;
        left: 1620px;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: flex-end;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list2{
        position: absolute;
        top: 200px;
    }
    .logout{
        position: absolute;
        left: 25px;
        bottom: 25px;
    }
    i{
        font-size: 25px;
    }

    .sub_, .sub_1{
        position: absolute;
        width: 200px;
        height: 310px;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        display: none;
    }
    .sub_txt, .sub_txt1{
        font-size: 20px;
        color: white;
        display: flex;
        justify-content: center;
        margin-top: 5px;
    }
    .sub, .sub1{
        margin: 10px;
        width: 180px;
        height: 80px;
        background-color: aliceblue;
        display: flex;
        justify-content: space-around;
        border-radius: 10px;
    }
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
    }
    .bboard{
		background-color: #73734F;
		display: flex;
		justify-content: center; 
		align-items: center;    
		flex-direction: column;   
		border-radius: 8px;
    }
    th{
       width: 100px;
    }
   .what{
      height: 60px;
   }
   .category{
      font-size: 20px;
   }
   .date{
      font-size: 16px;
   }
   .subject{
      width: 550px;
      height: 20px;
      text-align: left;
      vertical-align: top;
   }

   .alxwnf{
     width: 750px;
     margin-left: 1%;
     background-color: gray;
     height: 2px;
  }
  textarea{
        width: 100%;
        height: 250px;
        border-radius: 8px;
        resize: none;
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
}
input[type="button"]{
width: 50px;
}
</style>
</head>
<body>
 <header>
        <nav class="navbar">
            <div class="main_menu"><i class="fa-solid fa-bars"></i></div>
            <div class="logo_text">
                <a href="./#">SULBAZI</a>
            </div>
            <div>
                <ul class="icon">
                    <li><a href="login.go">로그인</a></li>
                    <li>
                        <i class="fa-regular fa-message"></i>
                        <div class="sub_1">
                            <div class="sub_txt1">대화중인 대화방</div>
                            <div class="sub1">알림1</div>
                            <div class="sub1">알림2</div>
                        </div>
                    </li>
                    <li>
                        <i class="fa-regular fa-bell"></i>
                        <div class="sub_">
                            <div class="sub_txt">3개 알림</div>
                            <div class="sub">알림1</div>
                            <div class="sub">알림2</div>
                            <div class="sub">알림3</div>
                        </div>
                    </li>
                    <li class="mypage"><i class="fa-regular fa-user"></i></li>
                </ul>
            </div>
        </nav>
        <div class="fullbox">
            <div class="full">
                <ul class="list1">
                    <li><a href="localChatRoom.go">지역 대화방</a></li>
                    <li><a href="userchatlist.go">개인 대화방</a></li>
                    <li><a href="storeList.go">매장 리스트</a></li>
                    <li><a href="boardList.go">게시판</a></li>
                </ul>
                <a href="userinquery.go">고객센터</a>
            </div>
            <div class="full2">
                <ul class="list2">
                    <li><a href="storeMyPage.go">나의 정보</a></li>
                    <li><a href="storeMyReview.go">나의 매장 리뷰</a></li>
                    <li><a href="storeMyBoard.go">나의 게시글</a></li>
                    <li><a href="storeMyMenu.go">매장 메뉴 등록</a></li>
                </ul>
                <div class="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <a href="logout.go">로그아웃</a>
                </div>
            </div>
        </div>  
    </header>
    <div class="boardlist">
       <div class="bboard">
       <form method="post" enctype="multipart/form-data">
         <table class="table">
            <tr class="what">
               <th>
               		<select name="menu_category" id="category">
	                    <option value="select">카테고리</option>
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
            	<th class="contentphoto" colspan="3">사진을 넣어주세요!</th>
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
         		<th><input type="file" id="file" multiple="multiple"></th>
         		<th></th>
         		<th><button onclick="location.href='boardList.go'">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="등록" onclick="save(event)"/></th>
         	</tr>
         </table>
         <input type="hidden" id="store_id" value="'${sessionScope.loginId}'">
       </form>
       </div>
    </div>
</body>
<script>
var loginId = '${sessionScope.loginId}'
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
	var form = new FormData($('form')[0]);
	form.append('loginId', $('#store_id').val()); // 로그인 ID 추가
	$.ajax({
		type:'POST',
		url:'boardWrite.ajax',
		enctype:'multipart/form-data',
		processData:false,
		contentType:false,
		data:form,
		dataType:'JSON',
		success:function(data){
			console.log(data);
		},
		error:function(e){
			console.log(e);
		}
	})
}
</script>
</html>