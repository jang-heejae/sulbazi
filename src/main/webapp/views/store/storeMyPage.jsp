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
    font-weight: bold;
    color: white;
}

.all {
    width: 65%;
    display: flex;
    flex-direction: row;
    gap: 20px;
    margin-top: 150px;
    margin-left: auto;
    margin-right: auto;
        z-index: 9999;
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
    gap: 10px; /* 요소 간의 간격 설정 */
    color: white;
}

td {
    text-align: left; /* 텍스트 왼쪽 정렬 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
}
	.table{
	position: absolute;
	top: 200px;
	left: 1016px;
	width:400px;
	}
	.table li{
	 	padding: 10px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	.form-group{
		left: 562px;
    	position: absolute;
    	top: 190px;
    	width: 400px;
	}
	.form-group2{
		position: absolute;
    	top: 443px;
    	left: 505px;
	}
	.form-group3{
		height: 335px;
    	width: 523px;
    	display: flex;
   		flex-wrap: wrap;
	}
	.form-group2 div{
		margin: 3px;
	}
	input[type="text"]{
		padding: 4px;
		border-radius: 15px;
		width: 250px;
	}
	.store_cate{
		position: absolute;
		top: 630px;
    	left: 842px;
	}
	textarea {
		border-radius: 10px;
		width: 400px;
		height: 150px;
	}
	.radio-group {
    	display: flex; /* flex 컨테이너로 설정 */
   		gap: 10px; /* 요소 간 간격 설정 */
	}
	#mainPhoto{
		width: 215px;
    	height: 215px;
	}
	#storePhoto{
		width: 150px;
		height: 150px;
	}
	#button{
		position: absolute;
		top: -224px;
    	left: 73px;
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	#bookmark{
		top: 219px;
    	position: absolute;
    	left: 925px;
	}
	#bookmark li{
		text-align: center;
	}
	.likeIcon{
		width: 50px;
	}

</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
<div class="all">
	<div class="form-group">
	    <label>매장 대표 사진</label>
	        <div>
				<img id="mainPhoto" src="/photo/${mystorebestphoto.new_filename}"><br/>
	        </div>
	</div>
	<div id="bookMark">
			<img class="likeIcon" src="resources/img/userLike.png"/>
		<ul>
			<li>${storedto.bookmark_user}</li>
		</ul>
	</div>
	<div class="form-group2">
		<label>매장 내외부 사진</label>
			<div class="form-group3">
				<c:forEach items="${mystorephoto}" var="mystoreinout">
					<div><img id="storePhoto" src="/photo/${mystoreinout.new_filename}"></div><br/>
				</c:forEach>
			</div>
	</div>
	<div class="storinfo">
	<div class="table">
		<ul>
			<li>아이디 <input type="text" value="${storedto.store_id}" readonly></li>
			<li>비밀번호 <input type="text" value="${storedto.store_pw}" readonly></li>
			<li>매장 이름 <input type="text" value="${storedto.store_name}" readonly></li>
			<li>사업자 번호 <input type="text" value="${storedto.store_number}" readonly></li>
			<li>전화번호 <input type="text" value="${storedto.store_phone}" readonly></li>
			<li>운영시간</li>
			<li><textarea readonly>${storedto.store_time}</textarea></li>
		</ul>
	</div>
	<div class="store_cate">
		<ul>
			<li>
				<label>주종</label>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 1}">
	                   			<input type="radio" name="alchol" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
			</li>
			<li>
				<label>안주</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 2}">
	                   			<input type="radio" name="food" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
			</li>
			<li>
				<label>분위기</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 3}">
		                   		<input type="radio" name="mood" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
			</li>
			<li>
				<label>방문목적</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 4}">
		                   		<input type="radio" name="visit" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
		           	<div id="button"><button type="button" onclick="mystoreUpdate.go?idx=${store_idx}">정보 수정</button></div>
			</li>
		</ul>
	</div>
	</div>
</div>
</body>
<script>

</script>
</html>