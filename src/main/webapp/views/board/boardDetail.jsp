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
	}
    .boardlist{
    	width: 100%;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        margin-top: 10%;
        left: 20%;
        padding: 3% 10% 3% 10%;
        box-sizing: border-box;
        font-family: "Yeon Sung", system-ui;
    }
    .bboard{
       background-color: white;
       border-radius: 10px;
    }
    th{
       width: 100px;
    }
    .photo1{
    width: 60px;
    height: 60px;
    border-radius: 50%;
    object-fit: cover;
    position: absolute; /* 테이블 내 원하는 위치에 배치 가능 */
    top: 89px; /* 원하는 Y 좌표 */
    left: 243px; /* 원하는 X 좌표 */
   }
   .what{
      height: 60px;
   }
   .category{
      font-size: 17px;
   }
   .category2{
         font-size: 25px;
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
    background-color: rgb(255, 140, 9);
    border: none;
    color: red;
    font-size: 15px;
    cursor: pointer;
    display: flex;
    align-items: center;
    padding: 1% 3%;
    border-radius: 12px;
    margin-left: 47%;
   }
   #likeCount{
   color: white;
   }
   .like-button i {
       margin-right: 5px;
   }
   .photo4{
      width: 85%;
    height: 85%; 
    object-fit: cover;
    margin: 3% 7%;
    border-radius: 10px;
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
        border: none;
    }
    .shit{
       padding-left: 5%;
    }
</style>
</head>
<body>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <div class="boardlist">
       <div class="bboard">
       <input type="hidden" id="board_idx" value="${info.board_idx}">
       <input type="hidden" id="user_id" value="${sessionScope.loginId}">
         <table>
            <tr>
               <th class="category">${info.board_category}</th>
               <th colspan="2" class="category2" style="text-align: left; width: 400px;">${info.board_subject}</th>
               <th></th>
               <th></th>
               <th><i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i><span id="likeCount2">${info.like_count}</span></th>
               <th><i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>${info.board_bHit}</th>
            </tr>
            <tr class="what">
               <th></th>
               <th>${store.store_name}</th>
               <th></th>
               <th></th>
               <th></th>
               <th></th>
               <th class="date">
			       <fmt:formatDate value="${info.board_date}" pattern="yyyy.MM.dd HH:mm:ss" />
			   </th>
            </tr>
         </table>
               <c:if test="${not empty files}">
                   <c:forEach var="photo" items="${files}">
                       <img src="photo/${photo}" alt="사진" class="photo1"/>
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
                             <img src="photo/${photo}" alt="사진" class="photo4"/>
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
       </div>
           <table>
              <tr>
                    <th></th>
                    <th></th>
                  <th class="shit" style="width: 600px;">
                     <c:if test="${sessionScope.opt == 'user_log'}">
                        <c:if test="${detailcheck == 1}">
                         <button id="likeButton" class="like-button" onclick="like()">
                             <i class="fa-solid fa-heart" id="heartIcon" style="color: red;"></i> 
                             <span id="likeCount">${info.like_count}</span>
                         </button>
                     </c:if>
                     <c:if test="${detailcheck == 0}">
                         <button id="likeButton" class="like-button" onclick="like()">
                             <i class="fa-solid fa-heart" id="heartIcon" style="color: gray;"></i> 
                             <span id="likeCount">${info.like_count}</span>
                         </button>
                     </c:if>
                     </c:if>
                  </th>
                 	<th>
					   <c:if test="${sessionScope.loginId == store.store_id || sessionScope.opt == 'admin_log'}">
					      <a href="javascript:void(0);" class="buttonn" onclick="confirmDelete('${info.board_idx}')">삭제</a>
					   </c:if>
					</th>
                    <th>
                    <a href="boardList.go" class="buttonnn">목록</a>
                    </th>
                    <th>
					   <c:if test="${sessionScope.loginId == store.store_id}">
					      <a href="javascript:void(0);" class="button" onclick="confirmUpdate('${info.board_idx}')">수정</a>
					   </c:if>
					</th>
              </tr>
           </table>
    </div>
    </div>
    </section>
</body>
<script>
function like(){
   var board_idx = '${info.board_idx}';
   var user_id = '${sessionScope.loginId}';
   var heartIcon = $('#heartIcon');
   console.log(board_idx);
   console.log(user_id);
   $.ajax({
      type: 'POST',
      url : 'boardLike.ajax',
      data : {'user_id':user_id, 'board_idx':board_idx},
      dataType : 'JSON',
      success : function(data) {
         if(data.success) {
            $('#likeCount').text(data.like);
            $('#likeCount2').text(data.like);
            if (data.Check) {
                  $('#heartIcon').removeClass('fa-heart-o').addClass('fa-heart').css('color', 'red'); // 좋아요 한 경우
              } else {
                 $('#heartIcon').removeClass('fa-heart-o').addClass('fa-heart').css('color', 'gray'); // 좋아요 취소한 경우
              }
         }else {
            alert('좋아요 실패');
         }
      },
      error : function(error) {
         console.error('Error', error);
      }
   })
}
function confirmUpdate(board_idx) {
	   var result = confirm("수정하시겠습니까?");
	   if (result) {
	      window.location.href = "update.go?board_idx=" + board_idx;  // 수정 페이지로 이동
	   }
	   // 취소 시 아무 것도 하지 않음
	}

	// 삭제 버튼 클릭 시
	function confirmDelete(board_idx) {
	   var result = confirm("삭제하시겠습니까?");
	   if (result) {
	      window.location.href = "delete.go?board_idx=" + board_idx;  // 삭제 처리
	   }
	   // 취소 시 아무 것도 하지 않음
	}
</script>
</html>