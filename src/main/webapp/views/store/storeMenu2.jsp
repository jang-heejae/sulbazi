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
    <h1>메뉴 목록</h1>
    <table>
        <tbody>
	    	<tr>
	            <c:if test="${files.size()>0}">
	            	<c:forEach items="${files}" var="file">
	                	<td><img id="imgview" src="/photo/${file.new_filename}"></td>
	                </c:forEach>
	                <c:forEach items="${store_menu}" var="menu">
	                	<th>${menu.menu_name}</th>
	                	<td>${menu.menu_price}</td>
	                </c:forEach>
	         	</c:if>
	         </tr>
        </tbody>
    </table>
    <a href="detail.go?idx=${store.idx}">상세보기로 돌아가기</a>
</body>
<jsp:include page="storeMenuHub.jsp"/>
<script>

</script>
</html>