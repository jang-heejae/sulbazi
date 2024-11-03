<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	body{
		color:#20290E;
		font-weight: normal;
		background-color: #20290E;
		overflow: hidden; 
		font-family: "Yeon Sung", system-ui;
	} 
	#newCate{
		background-color: #73734F;
		border-radius: 10px;
		position: absolute;
		top: 27px;
    	left: 116px;
    	display: flex;
    	flex-direction: column;
	} 
	table, th, td{
		border-bottom: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		padding: 10px;
	}
	#opt_bar{
		width: 100%;
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
	#opt_bar{
		border-radius: 10px;
		padding: 4px;
		width: 100%;
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
	option{
		font-family: "Yeon Sung", system-ui;
	}
</style>
</head> 
<body>
	<form action="categoryAdd.do" method="post" onsubmit="refresh();">
	<div id="newCate">
	<table>
		<tr>
			<th colspan="2">카테고리 추가</th>
		</tr>
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
			<th>카테고리 옵션</th>
			<td><input type="text" name="keyword" id="new_categoryOpt" value=""/></td>
		</tr>
	</table>
		<button type="submit">카테고리 추가</button>
		<button onclick="window.close();">닫기</button>
	</div>
	</form>
</body>
<script>
function refresh() {
       window.opener.location.reload();
}
</script>
</html>