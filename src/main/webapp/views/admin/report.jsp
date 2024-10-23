<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
	body{
		color: white;
		background-color: #20290E;
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
</style>
<body>
	<form action="report.do" method="post">
	<div id="report">
	<i class="far fa-siren-on"></i>
	<h3>신고하기</h3>
	<hr/>
		<div>
			<input type="text" name="reportContent" placeholder="20자 이내로 신고내용을 입력해주세요." value=""/>
		</div>
	<div id="acp">
		<button onclick="report()">신고</button>
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