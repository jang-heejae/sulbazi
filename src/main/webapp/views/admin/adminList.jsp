<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
	body{
		color: white;
	}
	#thead{
		background-color: #20290E;
	} 
	#adminList{
		position: absolute;
		top: 250px;
		left: 550px;
	}
	#adminDetail{
		position: absolute;
		top: 350px;
		left: 1050px;
	}
</style>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="adminList">
	<h3>관리자 리스트</h3>
	<hr/>
	<br/>
	<table id="adminListTable">
		<thead  id="thead">
			<tr>
				<th>관리자 아이디</th>
				<th>관리자 이름</th>
				<th>관리자 생성날짜</th>
			</tr>
		</thead>
		<tbody id="list">
			
		</tbody>
	</table>
	</div>
	<div id="adminDetail">
	<c:import url="adminDetail.jsp"/>
	</div>
</body>
<script>
listCall();
	function listCall(){
		$.ajax({
			type:'GET',
			url:'adminList.ajax',
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
			content += '<td><a href="#" onclick="window.open(\'<c:url value="/adminUpdate.do?admin_id=' + item.admin_id + '" />\', \'popup\', \'width=600,height=400\'); return false;">' + item.admin_id + '</a></td>';
			content+='<td>'+item.admin_name+'</td>';
			content+='<td>'+item.admin_doc+'</td>';
			content+='</tr>';
		}
        $('#list').html(content);
   }
</script>
</html>