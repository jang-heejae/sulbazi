<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- controller 에 css 라는 요청이 없으면 static 폴더 밑에 css 찾아라 -->
<link rel="stylesheet" href="css/common.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<body>
		<table>
			<caption>상세보기</caption>
			<tr>
				<th>작성자</th>
				<td>${info.store_idx}
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${info.board_subject}
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${info.board_content}</td>
			</tr>
			<tr>
            <th>사진</th>
            <td>
                <c:if test="${not empty files}">
                    <c:forEach var="photo" items="${files}">
                        <img src="/photo/${photo}" alt="사진" style="width:100px;height:auto;"/>
                    </c:forEach>
                </c:if>
                <c:if test="${empty files}">
                    <p>사진이 없습니다.</p>
                </c:if>
            </td>
        </tr>
			<tr>
				<th colspan = "2">
					<a href="./">리스트</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="update.go?board_idx=${info.board_idx}">수정</a>
				</th>
			</tr>
		</table>
</body>
<script>
	function download(fileName){
		console.log(fileName+' download');
		location.href = 'download.do?fileName='+fileName;
	}












</script>
</html>