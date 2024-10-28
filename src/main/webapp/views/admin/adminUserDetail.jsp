<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	body{
		color: white;
	}
	.userNickname{
		position: absolute;
		top: 188px;
    	left: 841px;
	}
	.userProfile{
		position: absolute;
		top: 258px;
    	left: 840px;
    	width: 300px;
	}
	.userProfile li{
		padding: 10px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	.userProfile input{
		padding: 4px;
		border-radius: 15px;
		width: 200px;
	}
	#userProfile{
		background-color: gray;
		position: absolute;
		top: 173px;
    	left: 491px;
    	width: 250px;
    	height: 270px;
    	border-radius: 20px;
	}
	#userProfile div{
		position: absolute;
		top: 25px;
    	left: 31px;
    	width: 190px;
    	height: 218px;
		background-color: white;
		border-radius: 20px;
	}
	#userRevoke{
		position: absolute;
		top: 451px;
    	left: 501px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="userProfile">
		<div>
			<ul>
				<li>
					<c:if test="${files.size()>0}">
						<c:forEach items="${files}" var="file">
							<img alt="${file.user_photo}" src="/photo/${file.user_photo}">
						</c:forEach>
					</c:if>
				</li>
				<li><input type="text" name="user_likecount" value="${info.user_likecount}" readonly="readonly"/></li>
			</ul>
		</div>
	</div>
	<div id="userRevoke">
		<ul>
			<li>신고 당한 횟수 ${info.user_reportedcases}</li>
			<li>신고 한 횟수 ${info.user_reportno}</li>
			<li>이용 제한 ${info.user_revoke}</li>
			<li>이용 제한 시작일 ${info.revoke_start}</li>
			<li>이용 제한 종료일 ${info.revoke_stop}</li>
		</ul>
	</div>
	<div class="userNickname"><h2>${info.user_nickname} 님</h2></div>
	<div class="userProfile">
		<ul>
			<li>아이디 <input type="text" name="user_id" value="${info.user_id}" readonly="readonly"/></li>
			<li>비밀번호 <input type="password" name="user_pw" value="${info.user_pw}" readonly="readonly"/></li>
			<li>이름 <input type="text" name="user_name" value="${info.user_name}" readonly="readonly"/></li>
			<li>생년월일 <input type="text" name="user_birth" value="${info.user_birth}" readonly="readonly"/></li>
			<li>전화번호 <input type="text" name="user_phone" value="${info.user_phone}" readonly="readonly"/></li>
			<li>이메일 <input type="text" name="user_email" value="${info.user_email}" readonly="readonly"/></li>
			<li>주종 <input type="radio" name="user_category" value="${info.opt_name}" readonly="readonly"/></li>
			<li>안주 <input type="radio" name="user_category" value="${info.opt_name}" readonly="readonly"/></li>
			<li>분위기 <input type="radio" name="user_category" value="${info.opt_name}" readonly="readonly"/></li>
			<li>방문목적 <input type="radio" name="user_category" value="${info.opt_name}" readonly="readonly"/></li>
		</ul>
	</div>
</body>
<script>

</script>
</html>