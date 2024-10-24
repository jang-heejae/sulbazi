<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	body{
		color: white;
	}
	table, th, td{
		border: 1px solid white;
		padding: 3px;
	}
	#reportDiv{
		position: absolute;
		top: 250px;
		left: 550px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="reportDiv">
	<h3>신고 상세보기</h3>
	<hr/>
	<table>
		<tr><td><input type="hidden" name="repord_idx" value="${info.report_idx}"/></td></tr>
		<tr>
			<th>신고자 아이디</th>
			<td>${info.reporting_id}</td>
		</tr>
		<tr>
			<th>신고자 대상 아이디</th>
			<td>${info.reported_id}</td>
		</tr>
		<tr>
			<th>신고 사유</th>
			<td>${info.report_content}</td>
		</tr>
		<tr>
			<th>신고 내용</th>
			<td>${info.report_category}</td>
			<td>${info.reported_idx}</td>
		</tr>
		<tr>
            <th>신고 일자</th>
            <td>${info.report_date}</td>
        </tr>
	</table>
	<br/>
    <a href="reportList.go">목록으로 돌아가기</a>
	<table>
		<tr>
			<td>처리 내용 : 
				<select id="report_cate" name="cate_opt">
					<option value="dismiss">반려</option>
					<option value="revoke">이용 제한</option>
				</select>
			</td>
			<td>이용제한 시작일 : 
			<input type="text" name="revoke_start" value=""/></td>
			<td>이용제한 종료일 :
			<input type="text" name="revoke_stop" value=""/></td>
			<td>처리 사유 :
			<input type="text" name="process_content" value=""/></td>
			<td>처리자 : ${sessionScope.loginId}</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>처리 내용</td>
			<td>이용제한 시작일</td>
			<td>이용제한 종료일</td>
			<td>처리 사유</td>
			<td>처리결과</td>
			<td>처리날짜</td>
			<td>처리자</td>
		</tr>
		<tr>
			<td id="list">
			</td>
		</tr>
	</table>
	</div>
</body>
<script>
listCall();
function listCall(){
	$.ajax({
		type:'GET',
		url:'reportWrite.ajax',
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
		content+='<td>'+revoke_start+'</td>'
		content+='<td>'+revoke_stop+'</td>'
		content+='<td>'+process_content+'</td>'
		content+='<td>'+report_result+'</td>'
		content+='<td>'+process_date+'</td>'
		content+='<td>'+admin_id+'</td>'
		content+='</tr>';
	}
    $('#list').html(content);
}
</script>
</html>