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
	body{
		color: white;
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
		background-color: #20290E;
		border: 1px solid #20290E;
		border-collapse: collapse;
		padding: 3px;
		font-family: "Irish Grover", system-ui;
	}
	#storeDiv{
		position: absolute;
		top: 201px;
    	left: 507px;
    	height: 200px;
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
    	background-color: rgb(255, 140, 9); /* 버튼 배경색 */
    	padding: 5px 10px; /* 버튼 안쪽 여백 */
    	text-decoration: none; /* 밑줄 제거 */
    	border-radius: 5px; /* 둥근 모서리 */
    	border: 1px solid rgb(255, 140, 9); /* 버튼 테두리 색 */
	}

	.pagination .active a {
    	background-color: rgb(255, 140, 9); /* 현재 페이지 강조 색 */
    	color: white; /* 현재 페이지 글자색 */
	}
	.page-item.active .page-link {
    	z-index: 1;
    	color: #fff;
    	background-color: rgb(255, 140, 9);
    	border-color: rgb(255, 140, 9);
	}
	.page-item.disabled .page-link {
    	color: #fff;;
    	pointer-events: none;
    	cursor: auto;
    	background-color: rgb(255, 140, 9);
    	border-color: rgb(255, 140, 9);
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="store"><h1>매장 사용자</h1></div>
	<div id="storeSearch">
		<ul>
			<li>
				<select id="store_cate" name="store_cate">
                	<option value="store_id">아이디</option>
                    <option value="store_name">매장 이름</option>
               	</select>
           		<input type="text" id="storeSearch2" name="storeSearch" value=""/>
           </li>
		</ul>
	</div>
	<div id="storeDiv">
	<table>
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
</body>
<script>
var showPage = 1;
pageCall(showPage);

 function pageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'adminStoreList.ajax',
        data: {
            page: page,
            cnt: 15
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
	function listPrint(list) {
	    var content = '';
	    for (var item of list) {
	        content += '<tr>';
	        content += '<td><a href="adminStoreDetail.go?store_idx=' + item.store_idx + '">'+ item.store_id +'</a></td>';
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