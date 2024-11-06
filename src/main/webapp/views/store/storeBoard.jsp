<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page session="true" %>
<html>
<head>
<meta charset="UTF-8">
<title>SULBAZI</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body.storeboard {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
    background-color: #041d03;
}

body.storeboard .navbar {
    z-index: 99;
    position: absolute;
    left: 360px;
    width: 1200px;
    height: 120px;
    background-color: #041d03;
    color: rgb(255, 140, 9);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

body.storeboard .board {
    width: 900px;
    background-color: rgb(255, 140, 9);
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
}

.table-container {
    width: 100%;
    height: 500px;
    overflow-y: scroll;
}

.table-container::-webkit-scrollbar { 
    display: none;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
}

th {
    background-color: white;
    height: 35px;
    padding: 7px;
}

td {
    color: white;
    text-align: center;
}
</style>
</head>
<body class="storeboard">
<jsp:include page="../main/storeMain.jsp"></jsp:include>
<div class="board">
    <div class="table-container">
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
                        <td><a href="storeDetail.do?storeidx=${board.board_idx}">${board.board_subject}</a></td>
                        <td>${board.like_count}</td>
                        <td>${board.board_bHit}</td>
                        <td>${board.board_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
