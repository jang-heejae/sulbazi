<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
	body {
    	display: flex;
    	flex-direction: column;
    	align-items: center;
    	justify-content: center; 
    	gap: 20px;
    	margin: 20px;
    	font-weight: bold;
    	color: #041d03;
    	min-height: 100vh;
    	background-color: #041d03;
	}
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
	}
	#store{
		position: absolute;
		top: 120px;
    	left: 525px;
	}
	#storeSearch{
		position: absolute;
		top: 120px;
    	left: 799px;
    	width: 514px;
	}
	#storeSearch2{
		width: 283px;
		padding: 10px;
		border-radius: 20px;
	}
	#store_cate, option{
		padding: 10px;
		border-radius: 20px;
	}
	#storeTable{
		color: rgb(255, 140, 9);
		background-color: #20290E;
		border: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		padding: 3px;
		font-family: "Irish Grover", system-ui;
		font-weight: bold;
	}
	#storeDiv{
		position: absolute;
		top: 256px;
    	left: 507px;
    	height: 200px;
    	width: 896px;
    	
	}
	td{
		padding: 5px;
		width: 143px;
		text-align: center;
		border-bottom: 2px solid white;
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
	<c:import url="../main/adminMain.jsp"/>
	    <section class="chatBox2">
        <div class="chatitems2">
	<div id="store"><h1>매장 사용자</h1></div>
	<div id="storeSearch">
		<ul>
			<li>
				<select id="store_cate" name="store_cate">
                	<option value="store_id">아이디</option>
                    <option value="store_name">매장 이름</option>
               	</select>
           		<input type="text" id="storeSearch2" name="storeSearch" value=""/>
           		<i class="fas fa-search" id="searchIcon" style="cursor: pointer;"></i>
           </li>
		</ul>
	</div>
	<div id="storeDiv">
	<table style="width: 100%; height: 100%;">
		<thead>
			<tr id="storeTable">
				<td>아이디</td>
				<td>매장 이름</td>
				<td>사업자 번호</td>
				<td>리뷰 갯수</td>
				<td>별점</td>
				<td>즐겨찾기</td>
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
	var category = $('#store_cate').val();
	var keyword = $('#storeSearch2').val();
	pageCall(1, category, keyword);
});
 function pageCall(page, category, keyword) {
    $.ajax({
        type: 'GET',
        url: 'adminStoreList.ajax',
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
	function listPrint(list) {
	    var content = '';
	    for (var item of list) {
	        content += '<tr>';
	        content += '<td style="color:#041d03;"><a href="adminStoreDetail.go?store_idx=' + item.store_idx + '">'+ item.store_id +'</a></td>';
	        content += '<td>' + item.store_name + '</td>';
	        content += '<td>' + item.store_number + '</td>';
	        content += '<td>' + item.review_total + '</td>';
	        content += '<td>' + item.star_average + '</td>';
	        content += '<td>' + item.bookmark_user + '</td>';
	        content += '</tr>';
	    }
	    $('#list').html(content); 
	}
</script>
</html>