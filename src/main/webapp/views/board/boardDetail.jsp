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
    .boardlist{
        position: relative;
        width: 1200px;
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
   	width: 100%;
    height: 100%; 
    object-fit: cover; 
   }
   .button, .buttonn, .buttonnn {
    display: inline-block; 
    padding: 7px 15px; 
    background-color: #ccc;
    color: black; 
    border: 1px solid #999; 
    border-radius: 5px; 
    text-align: center; 
    text-decoration: none;
    font-size: 14px;
    cursor: pointer;
    float: right;
    margin: 1%;
	}

	.button:hover, .buttonn:hover, .buttonnn:hover {
	    background-color: #bbb; 
	}
	textarea{
        width: 100%;
        height: 250px;
        border-radius: 8px;
        resize: none;
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
       <input type="hidden" id="board_idx" value="${info.board_idx}">
    	<input type="hidden" id="user_id" value="${sessionScope.loginId}">
         <table>
            <tr>
               <th class="category">${info.board_category}</th>
               <th colspan="2" class="category" style="text-align: left; width: 400px;">${info.board_subject}</th>
               <th></th>
               <th><i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>${info.like_count}</th>
               <th><i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>${info.board_bHit}</th>
            </tr>
            <tr class="what">
               <th>${store}</th>
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
                  <th><textarea name="board_content">${info.board_content}</textarea></th>               
               </tr>
           </table>
            <c:if test="${sessionScope.loginId == store}">
            	<a href="update.go?board_idx=${info.board_idx}" class="button">수정</a>
			</c:if>
			<a href="boardList.go" class="buttonnn">목록</a>
            <c:if test="${sessionScope.loginId == store}">
			    <a href="delete.go?board_idx=${info.board_idx}" class="buttonn">삭제</a>
			</c:if>
           <button id="likeButton" class="like-button">
               <i class="fa-solid fa-heart"></i> <span id="likeCount">${info.like_count}</span>
           </button>
       </div>
    </div>
</body>
<script>

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

$('.like-button').on('click', function() {
    var boardIdx = $('#board_idx').val(); // 해당 게시물의 board_idx 가져오기
    var userId = $('#user_id').val(); // 사용자 ID 가져오기 (예: 숨겨진 input에서)

    $.ajax({
        url: 'boardlike.ajax', // 좋아요를 처리할 URL
        type: 'GET',
        data: {
            board_idx: boardIdx,
            user_id: userId // user_id를 전송
        },
        success: function(data) {
			console.log(data);
			if (data.response) {
				$('#likeCount').text(data.response.likeCount);
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