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
<form>
    <div class="filter">
        <fieldset>
            <legend>주종</legend>
            <c:forEach var="option" items="${options}">
                <c:if test="${option.category_idx == 1}">
                    <input type="radio" name="alchol" value="${option.opt_idx}"
                        <c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> />
                    ${option.opt_name} <br/>
                </c:if>
            </c:forEach>
        </fieldset>

        <fieldset>
            <legend>안주</legend>
            <c:forEach var="option" items="${options}">
                <c:if test="${option.category_idx == 2}">
                    <input type="radio" name="food" value="${option.opt_idx}"
                        <c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> />
                    ${option.opt_name} <br/>
                </c:if>
            </c:forEach>
        </fieldset>

        <fieldset>
            <legend>분위기</legend>
            <c:forEach var="option" items="${options}">
                <c:if test="${option.category_idx == 3}">
                    <input type="radio" name="mood" value="${option.opt_idx}"
                        <c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> />
                    ${option.opt_name} <br/>
                </c:if>
            </c:forEach>
        </fieldset>

        <fieldset>
            <legend>방문목적</legend>
            <c:forEach var="option" items="${options}">
                <c:if test="${option.category_idx == 4}">
                    <input type="radio" name="visit" value="${option.opt_idx}"
                        <c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> />
                    ${option.opt_name} <br/>
                </c:if>
            </c:forEach>
        </fieldset>
    </div>
</form>
<div>

</div>
<div>
	<table>
		<tr>
			<td>아이디</td>
			<td>${storedto.store_id}</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>${storedto.store_pw}</td>
		</tr>
		<tr>
			<td>매장이름</td>
			<td>${storedto.store_name}</td>
		</tr>
		<tr>
			<td>사업자 번호</td>
			<td>${storedto.store_number}</td>
		</tr>
		<tr>
			<td>매장 전화번호</td>
			<td>${storedto.store_phone}</td>
		</tr>
		<tr>
			<td>매장 주소</td>
			<td>${storedto.store_address}</td>
		</tr>
		<tr>
			<td>매장 운영시간</td>
			<td>${storedto.store_time}</td>
		</tr>
	</table>
	
</div>
</body>
<script>

</script>
</html>