<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
    table {
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid black;
        padding: 10px;
        text-align: left;
    }  
    #imgview {
        width: 150px;
        height: 150px;
    }
</style>
</head>
<body>
    <h1>메뉴 목록</h1>
    <table>
        <tbody>
            <c:if test="${files.size() > 0 && storeAlcohol.size() > 0}">
                <!-- 두 리스트가 같은 크기일 때만 처리 -->
				<c:forEach var="file" items="${files}" varStatus="status">
				    <!-- 같은 인덱스의 storeMenu 항목을 사용 -->
					<tr>
					    <!-- 이미지 표시 -->
					    <td><img src="/photo/${file.new_filename}" alt="Store Photo" id="imgview" /></td>
					    <!-- 메뉴 이름 및 가격 -->
					    <td>${storeAlcohol[status.index].menu_name}</td>
					    <td>${storeAlcohol[status.index].menu_price}</td>
					</tr>
				</c:forEach>
            </c:if>
        </tbody>
    </table>
    <button onclick="location.href='storeDetail.do?storeidx=${store}'">상세보기로 돌아가기</button>
</body>

<script>

</script>
</html>