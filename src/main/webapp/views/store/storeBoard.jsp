<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<body>
	<div>
		<table>
			<thead>
				<tr>
					<th>게시판 분류</th>
					<th>게시물 제목</th>
					<th>좋아요 수</th>
					<th>조회 수</th>
					<th>게시 일자</th>
				</tr>
			</thead>
            <tbody>
                <c:forEach var="board" items="${myboard}">
                    <tr>
                        <td>${board.board_category}</td>
                        <td>${board.board_subject}</td>
                        <td>${board.like_count}</td>
                        <td>${board.board_bHit}</td>
                        <td>${board.board_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
		</table>
	</div>
</body>
<script>

</script>
</html>