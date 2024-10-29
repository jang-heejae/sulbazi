<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
       background-color: white;
    }
    th{
       width: 100px;
       border: 1px solid #aaa;
    }
    .photo1{
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    position: absolute; /* 테이블 내 원하는 위치에 배치 가능 */
    top: 55px; /* 원하는 Y 좌표 */
    left: 35px; /* 원하는 X 좌표 */
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
   .alxwnf{
      width: 800px;
      margin-left: 1%;
      background-color: black;
      height: 2px;
   }
   .storephoto{
      width: 1000px;
      height: 160px;
   }
   .subject{
      width: 1000px;
      height: 300px;
      text-align: left;
      vertical-align: top;
   }
   .like-button {
    background-color: transparent;
   
    border: none;
    color: red;
    font-size: 20px;
    cursor: pointer;
    display: flex;
    align-items: center;
   }
   .like-button i {
       margin-right: 5px;
   }
   .photo4{
   	width: 100%; /* th의 너비에 맞추기 위해 100%로 설정 */
    height: 100%; /* 비율에 맞게 자동으로 높이를 조정 */
    object-fit: cover; /* 비율을 유지하면서도 전체 영역을 채우도록 설정 */
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
         <table>
            <tr>
               <th class="category">${info.board_category}</th>
               <th colspan="2" class="category" style="text-align: left; width: 400px;">${info.board_content}</th>
               <th></th>
               <th><i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>${info.like_count}</th>
               <th><i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>${info.board_bHit}</th>
            </tr>
            <tr class="what">
               <th>${info.board_category}</th>
               <th></th>
               <th></th>
               <th></th>
               <th></th>
               <th class="date">${info.board_date}</th>
            </tr>
         </table>
               <c:if test="${not empty files}">
                   <c:forEach var="photo" items="${files}">
                       <img src="/photo/${photo}" alt="사진" class="photo1"/>
                   </c:forEach>
               </c:if>
               <c:if test="${empty files}">
                   <p>사진이 없습니다.</p>
               </c:if>
               <hr class="alxwnf">
            <table>
               <tr>
                  	<th class="subject">
						<c:if test="${not empty files4}">
		                   <c:forEach var="photo" items="${files4}">
		                       <img src="/photo/${photo}" alt="사진" class="photo4"/>
		                   </c:forEach>
              		 	</c:if>
              		 	<c:if test="${empty files4}">
		                   <p>사진이 없습니다.</p>
			            </c:if>
					</th>
               </tr>
               <tr>
                  <th>${info.board_subject}</th>               
               </tr>
            
            <%-- <tr>
               <th colspan = "2">
                  <a href="./">리스트</a>
                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <a href="update.go?board_idx=${info.board_idx}">수정</a>
               </th>
            </tr> --%>
           </table>
           <button id="likeButton" class="like-button">
               <i class="fa-solid fa-heart"></i> <span id="likeCount">${info.like_count}</span>
           </button>
       </div>
    </div>
</body>
<script>
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

$.ajax({
   type: 'GET',
   url : 'boardList.ajax',
   data:{},
   dataType:'JSON',
   success:function(data){
      console.log(data);
      if(data.login){
         drawList(data.list);
      }else{
         alert('로그인이 필요한 서비스입니다.');
         location.href='./login.go';
      }
   },error:function(e){
      console.log(e);
   }
});

$(document).on('click', '.like-button', function() {
    var boardIdx = $(this).data('board_idx'); // 해당 게시물의 board_idx 가져오기
    var userId = $('user_id').val(); // 사용자 ID 가져오기 (예: 숨겨진 input에서)

    $.ajax({
        url: 'boardlike.ajax', // 좋아요를 처리할 URL
        type: 'POST',
        data: {
            board_idx: boardIdx,
            user_id: userId // user_id를 전송
        },
        success: function(response) {
            // 성공적으로 처리된 후의 행동
            if (response.success) {
                alert('좋아요가 등록되었습니다.');
            } else {
                alert('좋아요 등록에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error: ', error);
            alert('서버 오류가 발생했습니다. 나중에 다시 시도하세요.');
        }
    });
});



</script>
</html>