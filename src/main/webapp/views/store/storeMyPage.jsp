<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    margin: 20px;
}

.all {
    width: 65%;
    height: 121%;
    display: flex;
    flex-direction: row;
    gap: 20px;
    margin-top: 150px;
    margin-left: auto;
    margin-right: auto;
    background-color:rgb(250, 140, 9);
}

.filter {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: space-around;
}

fieldset {
    width: 200px;
    height: auto;
}

.form-group {
    width: 100%;
    text-align: center;
    display: flex; /* Flexbox 사용 */
    flex-direction: column; /* 세로 방향으로 정렬 */
    align-items: center; /* 수평 중앙 정렬 */
    gap: 13px; /* 요소 간의 간격 설정 */
}

table {
    width: 400px;
    border-collapse: collapse; /* 테두리 겹침 방지 */
}

table, tr, td {
    padding: 15px; /* 단위 추가, 원하는 만큼 늘림 */
    border: 1px solid rgb(250, 140, 9); /* 테두리 색상 및 두께 설정 */
    background-color: rgb(250, 140, 9); /* 셀 배경 색상 */
    vertical-align: middle; /* 수직 정렬 */
}

td {
    text-align: left; /* 텍스트 왼쪽 정렬 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
    max-width:600;
    font-size:16px;
    font-weight:700;
}
div.table{
	width:400px;
	
}
div.form-group{
	width:300px;
}
input[type="text"]{
	border-radius: 10px;
	height: 32;
	width: 550;
	font-size:18px;
	border-color:black;
}

textarea {
	border-radius: 10px;
	font-size:18px;
	overflow-y:scroll;
	scrollbar-width: none;
	font-weight:700;
	
}

.radio-group {
    display: flex; /* flex 컨테이너로 설정 */
    gap: 13px; /* 요소 간 간격 설정 */
    flex-wrap: wrap;
}

input[type="radio"]{
	width:15px;
	height:21px;
}

img{
	width: 200px;
	height: 200px;
}

img.inout{
	width: 150px;
	height: 150px;
}
a.edit{
	width: 62px;
    height: 27px;
    border: 1px solid white;
    border-radius: 10px;
    padding: 5px;
    font-size: 24;
}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
<div class="all">
	<div class="form-group">
	    <label class="form-label">매장 대표 사진</label>
	        <div>
				<img src="/photo/${mystorebestphoto.new_filename}"><br/>
	        </div>
		<label class="form-label">첨부 파일</label>
			<div>
				<c:forEach items="${mystorephoto}" var="mystoreinout">
				<img class="inout" src="/photo/${mystoreinout.new_filename}"><br/>
			</c:forEach>
			</div>
		<a class="edit" href="mystoreUpdate.go?idx=${store_idx}">수정</a>
	</div>
	<div class="table">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" value="${storedto.store_id}" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" value="${storedto.store_pw}" readonly></td>
			</tr>
			<tr>
				<td>매장이름</td>
				<td><input type="text" value="${storedto.store_name}" readonly></td>
			</tr>
			<tr>
				<td>사업자 번호</td>
				<td><input type="text" value="${storedto.store_number}" readonly></td>
			</tr>
			<tr>
				<td>매장 전화번호</td>
				<td><input type="text" value="${storedto.store_phone}" readonly></td>
			</tr>
			<tr>
				<td>매장 주소</td>
				<td><input type="text" value="${storedto.store_address}" readonly></td>
			</tr>
			<tr>
				<td>매장 운영시간</td>
				<td><textarea style="width: 400px; height: 250px;" readonly>${storedto.store_time}</textarea></td>
			</tr>
			<tr>
				<td>주종</td>
				<td>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 1}">
	                   			<input type="radio" name="alchol" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
	           	</td>
			</tr>
			<tr>
				<td>안주</td>
				<td>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 2}">
	                   			<input type="radio" name="food" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
	           	</td>
			</tr>
			<tr>
				<td>분위기</td>
				<td>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 3}">
		                   		<input type="radio" name="mood" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
	           	</td>
			</tr>
			<tr>
				<td>방문목적</td>
				<td>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 4}">
		                   		<input type="radio" name="visit" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
	           	</td>
			</tr>
		</table>		
	</div>
</div>
</body>
<script>

</script>
</html>