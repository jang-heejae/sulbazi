<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<style>
	table, td{
		border: none;
		padding: 3px;
		border-collapse: collapse;
		width: 926px;
		text-align: center;
		border-radius: 20px;
		font-family: "Yeon Sung", system-ui;
	} 
	input[name="revoke_start"], input[name="revoke_stop"]{
		width: 79px;
	}
	input[name="process_content"]{
		width: 130px;
	} 
	#processList{
		height: 229px;
    	width: 920px
	}
	#processDiv{
		background-color: white;
		border-radius: 20px;
		padding: 10px;
		margin-bottom: 10px;
	}
	#proList{
		background-color: white;
		margin-bottom: 10px;
		padding: 5px;
		border-radius: 20px;
	}
	.processList2{
		background-color: white;
	}
</style>
</head>
<body>
<div>
<form action="processWrite.do" method="POST">
	<div id="processDiv">
		<ul>
			<li>처리 내용 :
				<select id="report_cate" name="cate_opt">
					<option value="dismiss">반려</option>
					<option value="revoke">이용 제한</option>
				</select>
				이용제한 시작일 : 
				<input type="text" name="revoke_start" value=""/>
				이용제한 종료일 :
				<input type="text" name="revoke_stop" value=""/>
				처리 사유 :
				<input type="text" name="process_content" value=""/>
				${sessionScope.loginId}
				<button>등록</button>
			</li>
		</ul>
	</div>
</form>
	<div id="processList">
		<table>
			<tr class="processList2">
				<td>처리 내용</td>
				<td>이용제한 시작일</td>
				<td>이용제한 종료일</td>
				<td>처리 사유</td>
				<td>처리 결과</td>
				<td>처리 날짜</td>
				<td>처리 담당자</td>
			</tr>
			<tr>
				<td id="list"></td>
			</tr>
		</table>
	</div>
</div>
</body>
<script>
/* listCall();
function listCall(){
	$.ajax({
		type:'GET',
		url:'process.ajax',
		data:{},
		dataType:'JSON',
		success:function(data){
			printList(data.list);
		},
		error:function(e){
			console.log(e);
		}
	});
}
function printList(list){
	var content ='';
	for (var item of list) {
		content+='<tr>';
		content+='<td>'+item.process_result+'</td>';
		content+='<td>'+item.revoke_start+'</td>'
		content+='<td>'+item.revoke_stop+'</td>'
		content+='<td>'+item.process_content+'</td>'
		content+='<td>'+item.report_result+'</td>'
		content+='<td>'+item.process_date+'</td>'
		content+='<td>'+item.admin_id+'</td>'
		content+='</tr><hr/>';
	}
    $('#list').html(content);
} */
</script>
</html>