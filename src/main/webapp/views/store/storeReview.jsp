<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>리뷰와 댓글</title>
<style>
    .area {
        background-color: #73734F;
        width: 1300px;
        height: auto;
        display: flex;
        grid-template-columns: 1fr 1fr;
        margin: auto;
        border-radius: 10px;
        margin-top: 200px;
        gap: 20px;
        padding: 20px;
    }

	.review-item{
	
	}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
<div class="area">
    <div class="reviewarea">
        <c:forEach var="review" items="${totalReviews}">
            <div class="review-item">
                <h3>리뷰 작성자: ${review.user_name}</h3> <!-- 리뷰 유저 이름 -->
                <p>리뷰 내용: ${review.review_content}</p> <!-- 리뷰 내용 -->
                <p>리뷰 날짜: ${review.review_date}</p> <!-- 리뷰 날짜 -->
				<p>사진: ${review.photoexist}</p> 
                <hr/>
            </div>
			<div class="replyarea">
				<p>댓글 내용: ${review.comm_content}</p> <!-- 댓글 내용 -->
				<p>댓글 날짜: ${review.comm_date}</p> <!-- 댓글 날짜 -->
                <hr/>
			</div>
        </c:forEach>
    </div>
</div>
</body>
</html>
