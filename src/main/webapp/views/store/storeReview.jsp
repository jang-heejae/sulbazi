<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>SULBAZI</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
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
    	justify-content: center;
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
    	background-color: #73734F; /* 버튼 배경색 */
    	padding: 5px 10px; /* 버튼 안쪽 여백 */
    	text-decoration: none; /* 밑줄 제거 */
    	border-radius: 5px; /* 둥근 모서리 */
    	border: 1px solid #73734F; /* 버튼 테두리 색 */
	}
	.pagination .active a {
    	background-color: #73734F; /* 현재 페이지 강조 색 */
    	color: rgb(255, 140, 9); /* 현재 페이지 글자색 */
	}
	.page-item.active .page-link {
    	z-index: 1;
    	color: rgb(255, 140, 9);
    	background-color: #73734F;
    	border-color: #73734F;
	}
	.page-item.disabled .page-link {
    	color: #fff;;
    	pointer-events: none;
    	cursor: auto;
    	background-color: #73734F;
    	border-color: #73734F;
	}
	.page-item.disabled .page-link {
    	color: rgb(255, 140, 9);
    	pointer-events: none;
    	cursor: auto;
    	background-color: #73734F;
    	border-color: #73734F;
    }
	.reviewarea{
		width: 100%;
	}
	.reviewarea li{
		display: flex
	}
	.review-item, .replyarea {
		width: 437px;
		height: auto;
		border-radius: 10px;
    	margin: 10px;
    	background-color: #20290E;
		border: 2px solid rgb(255, 140, 9);
		color: white;
		flex-grow: 1;
	    padding: 10px
	}
	.reUl{
    	width: 100%;
        padding: 10px;
	}
	hr{
	    margin: 10px;
	    background-color: rgb(255, 140, 9);
	}
	#userpho{
		border-radius: 50%;
		width: 25px;
    	height: 25px;
    	display: inline;
	}
	.review-photo{
		width: 50px;
		height: 50px;
	    margin: 6px;
	}
	.userUl{
		display: flex;
	}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
    <section class="chatBox2">
        <div class="chatitems2">
        	<input type="hidden" name="store_idx" value="${store}"/>
   			<div class="reviewarea">
        		
   			</div>
    		<div class="container">
   				<nav aria-label="Page navigation">
       				<ul class="pagination" id="pagination"></ul>
   				</nav>
			</div>
		</div>
	</section>
</body>
<script>
var showPage = 1;
pageCall(showPage);

 function pageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'storeMyReview.ajax',
        data: {
        	page: page,
            cnt: 5,
            store_idx : '${store}'
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data); 
            if (data.list && data.totalPages) {
                listPrint(data.list);
                $('#pagination').twbsPagination({
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
                console.error('twbsPagination is not available');
            }
    },
    error: function(e) {
        console.error('AJAX Error:', e);
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
 function listPrint(list) {
	    var content = '';
	    if (list.length === 0) {
	        content = '<p>리뷰가 없습니다.</p>';
	    } else {
	        for (var item of list) {
	        	if (item.review_photos) {
 			        const photoArray = item.review_photos.split(',');  // 쉼표를 기준으로 문자열 분리
 			       item.photos = photoArray;
 			    }
	            content += '<ul>';
	            content += '<li>';
	            content += '<div class="review-item">';
	            content += '<ul class="userUl">';
	            content += '<li><img id="userpho" src="/photo/' + item.user_photo + '" alt="User Photo" class="user-photo"></li>';
	            content += '<li>' + '\u00A0' + item.user_nickname + '\u00A0' + '\u00A0' + '</li>';
	            content += '<li><img src="resources/img/종원리뷰별.png" style="width:25px; height:25px;"/>' + '\u00A0' + item.starpoint + '\u00A0' + '\u00A0' + '</li>';
	            content += '<li><img src="resources/img/thumb.png" style="width:25px; height:25px;"/>' + '\u00A0' + item.like_count + '\u00A0' + '\u00A0' + '</li>';
	            content += '<li style="color: gray"><span>#</span>' + item.opt_names + '</li>';
	            content += '</ul>';
	            content += '<ul style="margin: 10px;">';
	            if (item.photos && item.photos.length > 0 ) {
 			    	content += '<li class="review-imgs"><td colspan="3" class="photo-cell">';
 			    	item.photos.forEach(function(photo) {
 			            content += '<img  src="/photo/' + photo + '" alt="review photo" class="review-photo">';
 			        });
 			    	content += '</li>';
 			    }
	            content += '<li>' + item.review_content + '</li>';
	            content += '<li>' + formatDate(item.review_date) + '</li>';
	            content += '</ul>';
	            content += '</div>';

	            content += '<div class="replyarea">';
	            content += '<ul class="reUl">';
	            if(item.comm_content != null){
	                content += '<li>' + item.comm_content + '</li>';
	                content += '<li>' + formatDate(item.comm_date) + '</li>';            	
	            }else{
	            	content += '<li><p>작성된 댓글이 없습니다.</p></li>'
	            }
	            content += '</ul>';
	            content += '</div>';
	            content += '</li>';

	            content += '</ul>';
	            content += '<hr>'; // 리뷰가 있는 경우에만 <hr> 출력
	        }
	    }
	    $('.reviewarea').html(content);
	}
</script>
</html>
