<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page session="true" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<meta charset="UTF-8">
<title>SULBAZI</title>
<style>
th {
	background-color: rgb(255, 140, 9);
	height:35;
	padding:7;
}

td{
	color: white;
	text-align: center;
}

div.board {
	margin-top:200;
    margin: auto; /* 좌우 여백을 자동으로 설정하여 중앙 정렬 */
    width: 625px; /* 테이블의 너비를 설정 */
    border-collapse: collapse; /* 테이블의 경계선 겹치지 않도록 설정 */
    height: 800px; /* 원하는 높이 설정 (필요에 따라 조정) */
    flex-wrap: wrap; /* flexbox 사용 */
    flex-direction: column; /* 수직으로 정렬 */
    align-items: center; /* 수평 중앙 정렬 */
    justify-content: center; /* 수직 중앙 정렬 (옵션) */
    overflow-y: auto;
     -ms-overflow-style: none;
}

.board::-webkit-scrollbar { 
	display: none;          /* Chrome, Safari에서 스크롤바 숨김 */
}

</style>
<body>
<jsp:include page="../main/storeMain.jsp"></jsp:include>
	<div class="board">
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