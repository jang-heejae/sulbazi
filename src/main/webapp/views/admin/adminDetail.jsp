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
		overflow: hidden; 
		font-family: "Yeon Sung", system-ui;
	} 
	table, th, td{
		border-bottom: 1px solid white;
		border-collapse: collapse;
		padding: 10px;
	} 
	input{
		margin-left: 2px;
    	width: 224px;
    	padding: 8px;
    	margin-bottom: 5px;
    	border-radius: 10px;
    	border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid #041d03;
		background-color: white;
		color:#041d03;
		font-family: "Yeon Sung", system-ui;
	}
	button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	#wcb{
		position: absolute;
		top: 257px;
    	left: 537px;
	}
	.adminAdd{
		background-color: #73734F;
		border-radius: 10px;
		position: absolute;
		top: 27px;
    	left: 116px;
	} 
</style>
<body>
	<form action="adminAdd.do" method="post">
	<div class="adminAdd">
	<table>
		<thead>
			<tr>
				<th colspan="2"> 관리자 생성 </th>
			</tr>
			<tr>
				<th>관리자 아이디</th>
				<td><input type="text" name="admin_id" value=""/></td>
			</tr>
			<tr>
				<th>관리자 비밀번호</th>
				<td><input type="password" name="admin_pw" value=""/></td>
			</tr>
			<tr>
				<th>관리자 이름</th>
				<td><input type="text" name="admin_name" value=""/></td>
			</tr>
			<tr>
				<td></td>
				<td><button>관리자 추가</button></td>
			</tr>
		</thead>
	</table>
	</div>
	<div id="wcb">
		<button onclick="window.close();">닫기</button>
	</div>
	</form>
</body>
<script>

</script>
</html>