<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
	    .pagination {
       display: flex; /* Flexbox로 설정 */
       justify-content: center; /* 중앙 정렬 */
       margin-top: 10px; /* 테이블과의 간격 */
   }

   .pagination li {
       list-style: none; /* 기본 리스트 스타일 제거 */
       margin: 0 5px; /* 버튼 간격 조정 */
   }

   .pagination a {
      font-family: "Irish Grover", system-ui;
      font-size: 20px;
       color: #041d03; /* 버튼 글자색 */
       background-color: rgb(255, 140, 9); /* 버튼 배경색 */
       padding: 5px 10px; /* 버튼 안쪽 여백 */
       text-decoration: none; /* 밑줄 제거 */
       border-radius: 5px; /* 둥근 모서리 */
       border: 1px solid rgb(255, 140, 9); /* 버튼 테두리 색 */
   }
   .pagination .active a {
       background-color: #041d03;/* 현재 페이지 강조 색 */
       color: #041d03; /* 현재 페이지 글자색 */
   }
   .page-item.active .page-link {
       z-index: 1;
       color: highlight;
       background-color: rgb(255, 140, 9);
       border-color: rgb(255, 140, 9);
   }
   .page-item.disabled .page-link {
       color: #fff;;
       pointer-events: none;
       cursor: auto;
       background-color: blue;
       border-color: blue;
   }
   .page-item.disabled .page-link {
       color: #041d03;
       pointer-events: none;
       cursor: auto;
       background-color: rgb(255, 140, 9);
       border-color: rgb(255, 140, 9);
   }
    .catego{
		color: white;
		font-size: 21px;
		font-weight: 700;
		margin-bottom: -16px;
   }
    #reportList input[type="radio"] {
        display: none;
    }
    
    #reportList .category {
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 5px;
        font-family: "Yeon Sung", system-ui;
    }

    #reportList input[type="radio"]:checked + label.category {
        background-color: rgb(255, 140, 9);
        color: white;
    }
       
       
    .boardlist{
    	color: #041d03;
        height: auto;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        padding: 20px;
        font-family: "Yeon Sung", system-ui;
        border-collapse: collapse;
        width: 100%;
    }
    #boardlist{
    	width: 100%;
    	    text-align: center;
    }
    #list td{
    	color: #041d03;
        padding: 5px;
        border-bottom: 1px solid #041d03;
        background-color: whitesmoke;
    }
    #sear{
	    margin-left: 305px;
    }
    .boar{
    	width: 240px;
    	border-radius: 15px;
    	height: 40px;
    }
    .dkahffk{
    	    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: flex-end;	
	}
	#store-name{
		white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	max-width: 54%;
    	display: inline-block;
	}
</style>
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
        <div class="sear" id="sear">
   				<input type="text" id="searchInput" name="board_search" class="boar" value=""/>
                <i class="fas fa-search" id="searchIcon" style="color:rgb(255, 140, 9);"></i>
   </div>
   <div class="dkahffk">
    <div id="reportList" class="catego">
	    <input type="radio" name="board_category" id="category_all" value="all" checked>
	    <label for="category_all" class="category">전체 보기</label>&nbsp;&nbsp;
	    
	    <input type="radio" name="board_category" id="category_promo" value="홍보">
	    <label for="category_promo" class="category">홍보</label>&nbsp;&nbsp;
	    
	    <input type="radio" name="board_category" id="category_event" value="이벤트">
	    <label for="category_event" class="category">이벤트</label>&nbsp;&nbsp;
	    
	    <input type="radio" name="board_category" id="category_newmenu" value="신메뉴">
	    <label for="category_newmenu" class="category">신메뉴</label>&nbsp;&nbsp;
	    
	    <input type="radio" name="board_category" id="category_newopen" value="신규오픈">
	    <label for="category_newopen" class="category">신규오픈</label>
	</div>
    <div class="writebutton" style="text-align: right; margin: 10px;">
       <c:if test="${not empty sessionScope.opt && sessionScope.opt == 'store_log'}">
           <a href="boardWrite.go" style="padding: 10px 20px; background-color: rgb(255, 140, 9); color: white; text-decoration: none; border-radius: 5px;">
               글쓰기
           </a>
       </c:if>
    </div>
    </div>
    <div class="boardlist">
        <table id="boardlist">
            <tbody id="list">
            </tbody>
        </table>
        <div class="container">
         <nav aria-label="Page navigation">
             <ul class="pagination" id="pagination"></ul>
         </nav>
      </div>
    </div>
    <div class="si"></div>
    </div>
    </section>
</body>
<script>
var showPage = 1;
pageCall(showPage);

   function pageCall(page){
      $.ajax({
          type: 'GET',
          url: 'boardList.ajax',
          data: {
             page: page,
             cnt: 15
          },
          dataType: 'JSON',
          success: function(data) {
              console.log(data);
              if (data.login) {
                  drawList(data.list);
                  $('.pagination').twbsPagination({
                     startPage: page,
                       totalPages: data.totalPages,
                       visiblePages: 5,
                       first: '<<',
                       prev: '<',
                       next: '>',
                       last: '>>',
                       onPageClick: function(evt, page) {
                           console.log('Page:', page);
                           pageCall(page); 
                       }
                   });
              } else {
                  alert('로그인이 필요한 서비스입니다.');
                  location.href = './login.go';
              }
          },
          error: function(e) {
              console.log(e);
          }
      });
   }
   function formatDate(dateString) {
	    // Date 객체 생성
	    const date = new Date(dateString);
	    const today = new Date(); // 오늘 날짜 객체 생성
	    if (date.toDateString() === today.toDateString()) {
	        // 오늘이면 시간만 표시
	        return date.toLocaleTimeString('en-GB'); // 'HH:mm:ss' 형식
	    } else {
	        // 오늘이 아니면 날짜만 표시
	        return date.toLocaleDateString('en-CA'); // 'YYYY-MM-DD' 형식
	    }
	}
function drawList(list) {
    var content = '';
    list.forEach(function(item) {
        // board_state가 0이 아닐 때만 테이블 행을 추가합니다.
        if (item.board_state) {
            content += '<tr>';
            content += '<td>' + item.board_category + '</td>';
            content += '<td class="subject"><a href="boardDetail.go?board_idx=' + item.board_idx + '" style="color: #041d03; width: 60%;">' + item.board_subject + '</a></td>';
            content += '<td class="like">' +
                '<i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>' + 
                item.like_count + 
                '</td>';
            content += '<td class="view">' +
                '<i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>' + 
                item.board_bHit + 
                '</td>';
            content += '<td><span id="store-name">' + item.store_name + '</span></td>'; // store_id가 포함되어 있어야 함
            content += '<td>' + formatDate(item.board_date) + '</td>';
            content += '<td style="display: none;">' + item.board_state + '</td>'; // 숨김 처리
            content += '</tr>';
        }
    });
    $('#list').html(content);
}

$(document).ready(function() {
   pageCall(showPage);
    $('input[name="board_state"], input[name="board_category"]').change(function() {
        board_filter('filter');
    });
    $('input[name="board_search"]').keypress(function(event) {
        if (event.key === 'Enter') {
            board_filter('search');
        }
    });
   });


function board_filter(action) {
   var boardCategory = $('input[name="board_category"]:checked').val() || "all";
   var boardSearch = $('input[name="board_search"]').val();
   console.log("카테고리 누른 값 : " + boardCategory);
   $.ajax({
      type: 'GET',
      url: 'board_category.ajax',
      data: {
         action: action,
         boardCategory: boardCategory,
         boardSearch: boardSearch
      },
      dataType: 'JSON',
      success: function(data) {
         drawList(data.list);
      },
      error: function(e) {
         console.error('AJAX Error:', e);
      }
   });
}

</script>
</html>