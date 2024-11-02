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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
</head>
<style>
	body{
		color: white;
		background-color: #20290E;
		font-family: "Yeon Sung", system-ui;
	} 
	#newPW{
		background-color: #E98D1C;
		position: absolute;
		top: 30px;
		left: 100px;
		padding: 20px;
		margin: 5px 10px;
		border-radius: 20px;
	} 
	table, th, td{
		border: 1px solid white;
		border-collapse: collapse;
		padding: 10px;
		font-family: "Yeon Sung", system-ui;
	}
	#acp{
		position: absolute;
		left: 250px;
	}
	#wcb{
		position: absolute;
		top: 350px;
		left: 500px;
	}
	button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	input{
		font-family: "Yeon Sung", system-ui;
		}
</style>
<body>
	<form action="adminUpdate.do">
	<div id="newPW">
	<h3>관리자 비빌번호 변경</h3>
	<hr/>
	<table>
		<tr>
			<th>관리자 아이디</th>
			<td><input type="text" name="admin_id" value="${info.admin_id}" readonly="readonly"/></td>
		</tr>
		<tr>
			<th>새로운 비밀번호</th>
			<td><input type="password" id="new_password" value=""/></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" id="new_passwordOk" value=""/></td>
		</tr>
	</table>
	<div id="message"></div>
	<br/>
	<div id="acp">
		<button onclick="adminChanPw()">비밀번호 변경</button>
	</div>
	<br/>
	</div>
	<div id="wcb">
		<button onclick="window.close();">닫기</button>
	</div>
	</form>
</body>
<script>
function adminChanPw(){
	var new_pw = $('#new_password').val();
	var cur_pw = $('#new_passwordOk').val();
		if(new_pw !== cur_pw){
			$('#message').text("비밀번호가 일치하지 않습니다.").css({'color':'red'});
			return;
		}else{
			$('#message').text("비밀번호가 일치합니다.").css({'color':'blue'});
		}
	var param = {admin_id:'${info.admin_id}', new_password:new_pw};
	$.ajax({
		type:'POST',
		url:'adminUpdate.ajax',
		data:param,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.success){
				alert('수정 성공');
			}
		},
		error:function(e){
			alert('수정 실패');
			console.log(e);
		}
	});	
}
</script>
</html>