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
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
</head>
<style>
    .boardlist{
        position: absolute;
        width: 1200px;
        height: auto;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        margin-top: 10%;
        left: 20%;
        padding: 20px;
        box-sizing: border-box;
    }
    td{
        padding: 1%;
        border: 1px solid #aaa;
        width: 150px;
        border-radius: 6px;
        background-color: whitesmoke;
        font-weight: 700;
    }
    .like, .view{
        width: 100px;
    }
    .time{
        width: 200px;
    }
    .subject{
    	width: 500px;
    }
    .writebutton{
    	position: absolute;
    	top: 140px;
    	right: 327px;
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
    <c:if test="${not empty sessionScope.opt && sessionScope.opt == 'store_log'}">
    <div id="reportList">
		<input type="radio" name="board_category" value="all" checked/> 전체 보기&nbsp;&nbsp;
		<input type="radio" name="board_category" value="홍보"/>홍보&nbsp;&nbsp;
		<input type="radio" name="board_category" value="이벤트"/>이벤트&nbsp;&nbsp;
		<input type="radio" name="board_category" value="신메뉴"/>신메뉴&nbsp;&nbsp;
		<input type="radio" name="board_category" value="신규오픈"/>신규오픈
		<div><input type="text" name="board_search" value=""/></div>
		<button id="searchButton">검색</button>
	</div>
    <div class="writebutton" style="text-align: right; margin: 10px;">
        <a href="boardWrite.go" style="padding: 10px 20px; background-color: rgb(255, 140, 9); color: white; text-decoration: none; border-radius: 5px;">
            글쓰기
        </a>
    </div>
    </c:if>
    <div class="boardlist">
        <table>
            <tbody id="list">
            </tbody>
        </table>
            	<div class="container">
	    				<nav aria-label="Page navigation">
	        			<ul class="pagination" id="pagination"></ul>
    				</nav>
				</div>
    </div>
    
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

function drawList(list) {
    var content = '';
    list.forEach(function(item) {
        // board_state가 0이 아닐 때만 테이블 행을 추가합니다.
        if (item.board_state) {
            content += '<tr>';
            content += '<td>' + item.board_category + '</td>';
            content += '<td class="subject"><a href="boardDetail.go?board_idx=' + item.board_idx + '" style="color: blue;">' + item.board_subject + '</a></td>';
            content += '<td class="like">' +
                '<i class="fa-solid fa-heart" style="color: red; margin-right: 5px;"></i>' + 
                item.like_count + 
                '</td>';
            content += '<td class="view">' +
                '<i class="fa-solid fa-eye" style="color: #999999; margin-right: 5px;"></i>' + 
                item.board_bHit + 
                '</td>';
            content += '<td>' + item.store_id + '</td>'; // store_id가 포함되어 있어야 함
            content += '<td>' + item.board_date + '</td>';
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
    $('#searchButton').click(function() {
    	board_filter('search');	
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