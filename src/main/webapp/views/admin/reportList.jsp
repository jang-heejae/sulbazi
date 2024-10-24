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
	body{
		color: white;
	}
	#reportList{
		position: absolute;
		top: 194px;
    	left: 507px;
	}
	#reportTable{
		background-color: #20290E;
		border: 1px solid #20290E;
		border-collapse: collapse;
		padding: 3px;
	}
	#reportDiv{
		position: absolute;
		top: 320px;
    	left: 507px;
    	height: 200px;
	}
	td{
		width: 143px;
		text-align: center;
	}
	.pagination{
		justify-content: center;
	}
	
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="reportList">
		<h3>신고 목록</h3>
		<hr/>
		<input type="radio" value=""/>처리중&nbsp;&nbsp;
		<input type="radio" value=""/>처리 완료&nbsp;&nbsp;
		<input type="radio" value=""/>전체 보기
		<br/>
		<input type="radio" value=""/>리뷰&nbsp;&nbsp;
		<input type="radio" value=""/>메시지
	</div>
	<div id="reportDiv">
	<table>
		<thead>
			<tr id="reportTable">
				<td>신고자 아이디</td>
				<td>신고 대상 아이디</td>
				<td>접수 분류</td>
				<td>신고 내용</td>
				<td>신고 일자</td>
				<td>처리 상태</td>
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
        url: 'reportList.ajax',
        data: {
            page: page,
            cnt: 10
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
        content += '<td>' + item.reporting_id + '</td>';
        content += '<td>' + item.reported_id + '</td>';
        content += '<td>' + item.report_category + '</td>';
        content += '<td><a href="reportDetail.go?repor_idx=' + item.report_idx + '">' + item.report_content + '</a></td>';
        content += '<td>' + item.report_date + '</td>';
        content += '<td>' + item.report_state + '</td>';
        content += '</tr>';
    }
    $('#list').html(content); 
}
</script>
</html>