<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	body{
		color: white;
		font-weight: bold;
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
    	width: 373px;
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
		background-color: rgb(255, 140, 9);
		position: absolute;
		top: 226px;
    	left: 542px;
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
	#userProfile input{
		position: absolute;
    	top: 163px;
	}
	#userRevoke{
		position: absolute;
		top: 504px;
    	left: 560px;
	}
	.userCate{
		position: absolute;
		top: 555px;
    	left: 840px;
    	width: 373px;
	}
	.userCate li{
		padding: 10px;
	}
	.userCate input[type="radio"] {
    	transform: scale(1.5); /* 라디오 버튼 크기를 1.5배로 확대 */
    	margin-right: 10px; /* 레이블과 버튼 사이 간격 조정 */
	}
	#userLike{
		position: absolute;
		top: 370px;
    	left: 691px;
    	width: 30px;
   		padding: 10px;
	}
	#userLike li{
		color: black;
		font-size: 48;
	}
	.userLike{
		position: absolute;
		top: 392px;
    	left: 589px;
    	width: 157px;
    	height: 47px;
    	border-radius: 15px;
    	background-color: #FFFAD4;
    	border: 1px solid black;
	}
	.likeIcon{
		position: absolute;
		top: 26px;
    	left: -80px;
    	width: 40px;
    	height: 40px;
    	object-fit: cover;
	}
	.profile-image {
    	width: 100px;  /* 너비 설정 */
    	height: 100px; /* 높이 설정 */
    	border-radius: 50%; /* 동그란 모양으로 만들기 */
    	object-fit: cover; /* 이미지의 비율을 유지하면서 크기를 맞춤 */
    	border: 2px solid #fff; /* 이미지 주변에 흰색 테두리 (선택 사항) */
    	position: absolute;
    	top: 13px;
    	left: 40px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="userProfile">
		<div>
			<c:if test="${files.size()>0}">
				<c:forEach items="${files}" var="file">
					<img class="profile-image" alt="${file.user_photo}" src="/photo/${file.user_photo}"/>
				</c:forEach>
			</c:if>
		</div>
	</div>
	<div class="userLike"></div>
	<div id="userLike">
			<img class="likeIcon" src="resources/img/userLike.png"/>
		<ul>
			<li>${info.user_likecount}</li>
		</ul>
	</div>
	<div id="userRevoke">
		<ul>
			<li>신고 당한 횟수 ${info.user_reportedcases}</li>
			<li>신고 한 횟수 ${info.user_reportno}</li>
			<li>이용 상태
				<c:choose>
        			<c:when test="${info.user_revoke == 0}">
            			<span style="color: #32CD32; font-weight: bold;">정상</span>
        			</c:when>
        			<c:when test="${info.user_revoke == 1}">
            			<span style="color: red; font-weight: bold;">이용제한</span>
        			</c:when>
    			</c:choose>
			</li>
			<c:if test="${not empty revoke_start && not empty revoke_stop}">
    			<li>사용 제한 시작일 <fmt:formatDate value="${revoke_start}" pattern="yyyy-MM-dd" /></li>
    			<li>사용 제한 종료일 <fmt:formatDate value="${revoke_stop}" pattern="yyyy-MM-dd" /></li>
			</c:if>
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
		</ul>
	</div>
	<div class="userCate">
		    <ul>
        <!-- 주종 카테고리 -->
        <li>
            <label>주종</label>&nbsp;&nbsp;&nbsp;
                <c:forEach var="category" items="${allCategories}">
                    <c:if test="${category.category_idx == 1}">
                        <c:set var="isChecked" value="false" />
                        <!-- 사용자가 선택한 항목인지 확인 -->
                        <c:forEach var="userCategory" items="${categories}">
                            <c:if test="${category.opt_idx == userCategory.opt_idx}">
                                <c:set var="isChecked" value="true" />
                            </c:if>
                        </c:forEach>
                        <!-- 주종 카테고리 옵션 출력 -->
                            <input type="radio" name="opt_name1" value="${category.opt_name}"
                                   <c:if test="${isChecked}">checked="checked"</c:if>/>
                            ${category.opt_name}
                    </c:if>
                </c:forEach>
        </li>

        <!-- 안주 카테고리 -->
        <li>
            <label>안주</label>&nbsp;&nbsp;&nbsp;
                <c:forEach var="category" items="${allCategories}">
                    <c:if test="${category.category_idx == 2}">
                        <c:set var="isChecked" value="false" />
                        <!-- 사용자가 선택한 항목인지 확인 -->
                        <c:forEach var="userCategory" items="${categories}">
                            <c:if test="${category.opt_idx == userCategory.opt_idx}">
                                <c:set var="isChecked" value="true" />
                            </c:if>
                        </c:forEach>
                        <!-- 안주 카테고리 옵션 출력 -->
                            <input type="radio" name="opt_name2" value="${category.opt_name}"
                                   <c:if test="${isChecked}">checked="checked"</c:if>/>
                            ${category.opt_name}
                    </c:if>
                </c:forEach>
        </li>

        <!-- 분위기 카테고리 -->
        <li>
            <label>분위기</label>&nbsp;&nbsp;&nbsp;
                <c:forEach var="category" items="${allCategories}">
                    <c:if test="${category.category_idx == 3}">
                        <c:set var="isChecked" value="false" />
                        <!-- 사용자가 선택한 항목인지 확인 -->
                        <c:forEach var="userCategory" items="${categories}">
                            <c:if test="${category.opt_idx == userCategory.opt_idx}">
                                <c:set var="isChecked" value="true" />
                            </c:if>
                        </c:forEach>
                        <!-- 분위기 카테고리 옵션 출력 -->
                            <input type="radio" name="opt_name3" value="${category.opt_name}"
                                   <c:if test="${isChecked}">checked="checked"</c:if>/>
                            ${category.opt_name}
                    </c:if>
                </c:forEach>
        </li>

        <!-- 방문목적 카테고리 -->
        <li>
            <label>방문목적</label>&nbsp;&nbsp;&nbsp;
                <c:forEach var="category" items="${allCategories}">
                    <c:if test="${category.category_idx == 4}">
                        <c:set var="isChecked" value="false" />
                        <!-- 사용자가 선택한 항목인지 확인 -->
                        <c:forEach var="userCategory" items="${categories}">
                            <c:if test="${category.opt_idx == userCategory.opt_idx}">
                                <c:set var="isChecked" value="true" />
                            </c:if>
                        </c:forEach>
                        <!-- 방문목적 카테고리 옵션 출력 -->
                            <input type="radio" name="opt_name4" value="${category.opt_name}"
                                   <c:if test="${isChecked}">checked="checked"</c:if>/>
                            ${category.opt_name}
                    </c:if>
                </c:forEach>
        </li>
    </ul>
<%-- 		<ul>
			<c:forEach var="category" items="${categories}">
            <c:choose>
                <c:when test="${category.category_idx == 1}">
                    <li>주종 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="opt_name1" value="${category.opt_name}" checked="checked" readonly="readonly"/>&nbsp;${category.opt_name}</li>
                </c:when>
                <c:when test="${category.category_idx == 2}">
                    <li>안주 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="opt_name2" value="${category.opt_name}" checked="checked" readonly="readonly"/>&nbsp;${category.opt_name}</li>
                </c:when>
                <c:when test="${category.category_idx == 3}">
                    <li>분위기 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="opt_name3" value="${category.opt_name}" checked="checked" readonly="readonly"/>&nbsp;${category.opt_name}</li>
                </c:when>
                <c:when test="${category.category_idx == 4}">
                    <li>방문목적 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="opt_name4" value="${category.opt_name}" checked="checked" readonly="readonly"/>&nbsp;${category.opt_name}</li>
                </c:when>
            </c:choose>
        </c:forEach>
		</ul> --%>
	</div>
</body>
<script>

</script>
</html>