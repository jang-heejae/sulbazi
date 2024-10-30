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
	table, th, td{
		border: 1px solid white;
		border-collapse: collapse;
		padding: 10px;
	} 
</style>
<body>
	<hr/>
	<h3>관리자 생성</h3>
	<hr/>
	<form action="adminAdd.do" method="post">
	<table>
		<thead>
			<tr>
				<th>관리자 아이디</th>
				<td><input type="text" name="admin_id" value=""/></td>
			</tr>
			<tr>
				<th>관리자 비밀번호</th>
				<td><input type="text" name="admin_pw" value=""/></td>
			</tr>
			<tr>
				<th>관리자 이름</th>
				<td><input type="text" name="admin_name" value=""/></td>
			</tr>
			<tr>
				<td colspan="2"><button>관리자 추가</button></td>
			</tr>
		</thead>
	</table>
	</form>
</body>
<script>

</script>
</html>