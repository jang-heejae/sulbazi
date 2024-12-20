<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
    	width: 940px;
    	min-height: 650px;
    	height: auto;
    	display: flex;
    	flex-wrap: wrap;
    	justify-content: space-between;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px;
    	margin-top: 140px;
    	font-family: "Yeon Sung", system-ui;
    	flex-direction: row;
    	border: 2px solid rgb(255, 140, 9);
	}
	#userSearch2{
		width: 283px;
		padding: 10px;
		border-radius: 20px;
	}
	#user_cate, option{
		padding: 10px;
		border-radius: 20px;
	}
	#userTable{
		color: rgb(255, 140, 9);
		background-color: #20290E;
		border: 1px solid #20290E;
		border-collapse: collapse;
		padding: 3px;
		font-family: "Yeon Sung", system-ui;
	}
	td{
		padding: 5px;
		width: 143px;
		text-align: center;
		border-bottom: 2px solid rgb(255, 140, 9);
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
</head>
<body>
<jsp:include page="../main/adminMain.jsp"/>
		<section class="chatBox2">
        <div class="chatitems2">
	<div id="user"><h1>일반 사용자</h1></div>
	<div id="userSearch">
		<ul>
			<li>
				<select id="user_cate" name="user_cate">
                	<option value="user_id">아이디</option>
                    <option value="user_nickname">닉네임</option>
                    <option value="user_email">이메일</option>
               	</select>
           		<input type="text" id="userSearch2" name="userSearch" value=""/>
           		<i class="fas fa-search" id="searchIcon" style="cursor: pointer; color:rgb(255, 140, 9);"></i>
           </li>
		</ul>
	</div>
		<div id="userDiv">
	<table style="width: 100%; height: 100%;">
		<thead>
			<tr id="userTable">
				<td>아이디</td>
				<td>닉네임</td>
				<td>신고 한 횟수</td>
				<td>신고 당한 횟수</td>
				<td>가입한 날짜</td>
				<td>이용제한 상태</td>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
		<tr>
			<th colspan="6">
				<div class="container">
    				<nav aria-label="Page navigation">
        			<ul class="pagination" id="pagination"></ul>
    				</nav>
				</div>
			</th>
		</tr>
	</table>
	</div>
	</div>
	</section>
</body>
<script>
var showPage = 1;
pageCall(showPage);

$('#searchIcon').on('click', function(){
	var category = $('#user_cate').val();
	var keyword = $('#userSearch2').val();
	pageCall(1, category, keyword);
});
$('#userSearch2').on('keydown', function(event) {
    if (event.key === "Enter") {
        var category = $('#user_cate').val();
        var keyword = $('#userSearch2').val();
        pageCall(1, category, keyword);
    }
});
 function pageCall(page, category, keyword) {
    $.ajax({
        type: 'GET',
        url: 'adminUserList.ajax',
        data: {
            page: page,
            cnt: 15,
            category: category,
            keyword: keyword
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data); 
            if (data.list && data.totalPages) {
                listPrint(data.list);
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
                        pageCall(page, category, keyword); 
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
	    for (var item of list) {
	        content += '<tr>';
	        content += '<td><a href="adminUserDetail.go?user_id=' + item.user_id + '">'+ item.user_id +'</a></td>';
	        content += '<td>' + item.user_nickname + '</td>';
	        content += '<td>' + item.user_reportno + '</td>';
	        content += '<td>' + item.user_reportedcases + '</td>';
	        content += '<td>' + formatDate(item.user_date) + '</td>';
	        content += '<td>' + (item.user_revoke == 1 ? '<span style="color: red;">이용제한</span>' : '정상') + '</td>';
	        content += '</tr>';
	    }
	    $('#list').html(content); 
	}
</script>
</html>