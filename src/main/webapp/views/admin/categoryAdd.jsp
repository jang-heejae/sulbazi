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
		background-color: #20290E;
	} 
	#newCate{
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
	#opt_bar{
		width: 100%;
	}
</style>
</head>
<body>
	<form action="categoryAdd.do" method="post">
	<div id="newCate">
	<h3>카테고리 추가</h3>
	<hr/>
	<table>
		<tr>
			<th>카테고리 분류</th>
			<td>
				<select id="opt_bar" name="cate_opt">
					<option value="drink">주종</option>
					<option value="menu">안주</option>
					<option value="mood">분위기</option>
					<option value="visit">방문목적</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>카테고리 선택사항</th>
			<td><input type="text" name="keyword" id="new_categoryOpt" value=""/></td>
		</tr>
	</table>
	<br/>
	<div id="acp">
		<button type="submit">카테고리 추가</button>
	</div>
	<br/>
	</div>
	<div id="wcb">
		<button onclick="window.close();">닫기</button>
	</div>
	</form>
</body>
<script>

</script>
</html>