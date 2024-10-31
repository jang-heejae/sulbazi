<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Real-time Notifications</title>
</head>
<body>
	<div>${chatroomout.chatroomname}</div>
	<div>${chatroomout.kickalarm}</div>
</body>
<script>
	console.log(${chatroomout});
/* 	var loginId = ${sessionScope.loginId};
	var chatroomboss = ${sessionScope.loginId}; */
		
		
		
/* $.ajax({
	type: 'GET',
	url: '',
	data: {},
	dataType: 'JSON',
	success: function(data) {
		console.log("데이터 수신 성공:", data);
		if (data && data.list && Array.isArray(data.list)) {
			drawList(data.list);
		} else {
			console.log("유효한 리스트가 없습니다.");
		}
	},
	error: function(e) {
		console.log("AJAX 요청 실패:", e);
	}
}); */
		
</script>
</html>