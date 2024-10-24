<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
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
	
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="reportList">
		<h3>신고 목록</h3>
		<hr/>
		<input type="radio" name="status" value=""/>처리중&nbsp;&nbsp;
		<input type="radio" name="status" value=""/>처리 완료&nbsp;&nbsp;
		<input type="radio" name="status" value=""/>전체 보기
		<br/>
		<input type="radio" name="category" value=""/>리뷰&nbsp;&nbsp;
		<input type="radio" name="category" value=""/>메시지
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
			<th colspan="5">
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
<<<<<<< HEAD
$('input[name="status"], input[name="category"]').on('change', function() {
    pageCall(1);  // 페이지를 1로 설정하고 호출
});
function pageCall(page){
	var status = $('input[name="status"]:checked').val();
    var category = $('input[name="category"]:checked').val();
=======
function pageCall(page){
>>>>>>> parent of f666e84 (리포트 페이지네이션)
	$.ajax({
		type:'GET',
		url:'reportList.ajax',
		data:{
<<<<<<< HEAD
			page : page, 
			cnt : 10,
			status : status,
			category : category
=======
			'page' : page, 
			'cnt' : 10
>>>>>>> parent of f666e84 (리포트 페이지네이션)
		},
		dataType:'JSON',
		success:function(data){
			listPrint(data.list);
			$('#pagination').twbsPagination('destroy');
			if(data.totalPages > 0){
				$('#pagination').twbsPagination({ 
					startPage: page, 
					totalPages: data.totalPages,
					visiblePages: 5,
					onPageClick:function(evt, page){
						pageCall(page);
					}
				});				
			}
		},error:function(e){
			console.log(e);			
		}
	});
}
function listPrint(list){
	var content ='';
	for(var item of list){
		content+='<tr>';
		content+='<td>'+item.reporting_id+'</td>';
		content+='<td>'+item.reported_id+'</td>';
		content+='<td>'+item.report_category+'</td>';
<<<<<<< HEAD
		content+='<td><a href="reportDetail.go?report_idx='+item.report_idx+'">'+item.report_content+'</a></td>';
=======
		content+='<td><a href="reportDetail.go?id='+item.id+'">'+item.report_content+'</a></td>';
>>>>>>> parent of f666e84 (리포트 페이지네이션)
		content+='<td>'+item.report_date+'</td>';
		content+='<td>'+item.report_state+'</td>';
		content+='</tr>';
	}
	$('#list').html(content);
}
</script>
</html>