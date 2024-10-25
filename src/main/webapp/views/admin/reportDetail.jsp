<%@page import="com.sulbazi.report.ReportDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	table, th, td{
		border: 1px solid white;
		padding: 3px;
	}
	#reportDiv {
    	width: 918px;
    	position: absolute;
    	top: 128px;
    	left: 489px;
    	color: white;
	}
	#ul{
		position: absolute;
		top: 199px;
    	left: 626px;
    	width: 670px;
	}
	#ul li{
		margin: 10px;
	}
	#process{
		position: absolute;
		top: 560px;
		left: 488px;
	}
	#ul input{
		font-size: large;
		border-radius: 20px;
		padding-left: 8px;
	}
	textarea{
		border-radius: 20px;
		padding: 8px;
	}
	input[name="reporting_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="reporting_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="reported_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="report_content"]{
		position: absolute;
		left: 230px;
	}
	input[name="report_date"]{
		position: absolute;
		left: 164px;
		width: 300px;
	}
	table, td{
		border: none;
		padding: 3px;
		border-collapse: collapse;
		width: 926px;
		text-align: center;
		border-radius: 20px;
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
	<c:import url="../main/adminMain.jsp"/>
	<div id="reportDiv">
	<h1>신고 상세보기</h1>
	<hr/>
	</div>
		<div id="ul">
			<ul>
				<li><h3>신고자 아이디 : <input type="text" name="reporting_id"  value="${info.reporting_id}" readonly="readonly"/></h3>
				<li><h3>신고자 대상 아이디 : <input type="text" name="reported_id"  value="${info.reported_id}" readonly="readonly"/></h3>
				<li><h3>신고 사유 : <input type="text" name="report_content"  value="${info.report_content}" readonly="readonly"/></h3>
				<li><h3>신고 내용 : ${info.report_category}
				<textarea rows="10" cols="80">${info.reported_idx}</textarea></h3>
				<li><h3>신고 날짜 :  <input type="text" name="report_date"  value="${info.report_date}" readonly="readonly"/></h3>
			</ul>
			</div>
		<br/>
		<div>
<form action="processWrite.do" method="POST">
<input type="hidden" name="report_idx" value="${info.report_idx}"/>
<input type="hidden" name="reported_id" value="${info.reported_id}"/>
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