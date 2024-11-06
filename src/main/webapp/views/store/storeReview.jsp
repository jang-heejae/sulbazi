<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>리뷰와 댓글</title>
<style>
    .reviewallarea {
        background-color: #041d03;
        width: 1300px;
        height: auto;
        display: grid;
        grid-template-columns: 1fr 1fr;
        margin: auto;
        border-radius: 10px;
        margin-top: 200px;
        gap: 20px;
        padding: 20px;
    }
    .reviewarea, .replyarea {
        background-color: rgb(255, 140, 9);
        border-radius: 10px;

    }
    .review-item, .reply-item {
        margin-bottom: 20px;
        height:50px;
    }
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
<div class="reviewallarea">
    <div class="reviewarea">
        <c:forEach var="review" items="${totalReviews}">
            <div class="review-item">
                <h3>리뷰 작성자: ${review.user_name}</h3> <!-- 리뷰 유저 이름 -->
                <p>리뷰 내용: ${review.review_content}</p> <!-- 리뷰 내용 -->
                <p>리뷰 날짜: ${review.review_date}</p> <!-- 리뷰 날짜 -->
                <c:if test="${review.photoexist}">
                    <p>(사진이 첨부됨)</p>
                </c:if>
                <hr/>
            </div>
        </c:forEach>
    </div>
    <div class="replyarea">
        <c:forEach var="review" items="${totalReviews}">
            <c:forEach var="reply" items="${review.replies}">
                <div class="reply-item">
                    <p>댓글 내용: ${reply.comm_content}</p> <!-- 댓글 내용 -->
                    <p>댓글 날짜: ${reply.comm_date}</p> <!-- 댓글 날짜 -->
                </div>
                <hr/>
            </c:forEach>
        </c:forEach>
    </div>
</div>
</body>
</html>
