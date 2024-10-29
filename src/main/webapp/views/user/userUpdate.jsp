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
	.chatBox{
      display: flex;
         justify-content: space-around;
         align-items: center;
      width : 100%;
      height: 100%;
   }
   .chatitems{
      position: absolute;
      top: 20%;
       width: 940px;
       height: 650px;
       display: flex;
       flex-wrap: wrap;
       justify-content: center;
       align-items: center;
       align-content: center;
       background-color: #73734F;
       border-radius: 20px;
   }
	.userNickname{
		position: absolute;
		top: 185px;
   		left: 953px;
    	font-size: 55px;
	}
	.userProfile{
		position: absolute;
		top: 258px;
    	left: 840px;
    	width: 373px;
	}
	.userProfile li{
		padding: 3px;
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
	.userCate{
		position: absolute;
		top: 555px;
    	left: 535px;
    	width: 707px;
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
	#button{
		position: absolute;
		top: 452px;
    	left: 632px;
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.file{
		position: absolute;
		top: 504px;
    	left: 572px;
	}
	#pwCheckMessage{
		margin-left: 172px;
    	font-size: 0.8em;
   	 	margin-top: -5px;
	}
	#checkNickname{
		margin-left: 172px;
    	font-size: 0.8em;
    	margin-top: -5px;
	}
	.overlay{
		position: absolute;
		top: 139px;
    	left: 379px;
    	width: 100px;
	}
</style>
</head>
<body>
<form action="userUpdate.do" method="post" id="userForm" enctype="multipart/form-data">
	<c:import url="../main/main.jsp"/>
	<section class="chatBox">
        <div class="chatitems">
        </div>
   </section>
	<div id="userProfile">
		<div id="previewContainer">
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
	<div class="file"><input type="file" name="files" multiple="multiple" id="fileInput"></div>
	<div id="button"><button type="submit" id="updateBtn">수정 확인</button></div>
	<div class="userNickname">${info.user_nickname}</div>
	<div class="userProfile">
		<ul>
			<li>아이디 <input type="text" name="user_id" value="${info.user_id}" readonly="readonly"/></li>
			<li>비밀번호 <input type="password" id="user_pw" name="user_pw" value="${info.user_pw}"/></li>
			<li>비밀번호 확인 <input type="password" id="user_pwCheck" name="user_pwCheck" value=""/></li>
			<li><span id="pwCheckMessage"></span></li>
			<li>이름 <input type="text" name="user_name" value="${info.user_name}" readonly="readonly"/></li>
			<li>닉네임 <input type="text" name="user_nickname" value="${info.user_nickname}"/>
				<div class="overlay"><button type="button" id="overlay">중복확인</button></div>
			</li>
			<li><span id="checkNickname"></span></li>
			<li>생년월일 <input type="text" name="user_birth" value="${info.user_birth}" readonly="readonly"/></li>
			<li>전화번호 <input type="text" name="user_phone" value="${info.user_phone}"/></li>
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
                            ${category.opt_name}&nbsp;&nbsp;
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
                            ${category.opt_name}&nbsp;&nbsp;
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
                            ${category.opt_name}&nbsp;&nbsp;
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
                            ${category.opt_name}&nbsp;&nbsp;
                    </c:if>
                </c:forEach>
        </li>
    </ul>
</div>
</form>
</body>
<script>
$(document).ready(function() {
    $('#fileInput').on('change', function(event) {
        var files = event.target.files;
        var $previewContainer = $('#previewContainer');

        // 기존 미리보기 이미지 제거
        $previewContainer.empty();

        // 선택한 파일들에 대해 미리보기 이미지 생성
        $.each(files, function(index, file) {
            if (file.type.startsWith('image/')) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    var img = $('<img>').addClass('profile-image').attr('src', e.target.result);
                    $previewContainer.append(img);
                };

                reader.readAsDataURL(file);
            }
        });
    });
});
$(document).ready(function() {
    $('#user_pwCheck, #user_pw').on('keyup blur', function() {
        var password = $('#user_pw').val();
        var passwordCheck = $('#user_pwCheck').val();
        var message = $('#pwCheckMessage');

        if (passwordCheck.length > 0) {
            if (password === passwordCheck) {
                message.text('비밀번호가 맞습니다.').css('color', '#20290E');
            } else {
                message.text('비밀번호가 다릅니다.').css('color', 'rgb(255, 140, 9)');
            }
        } else {
            message.text('');
        }
    });
});
$(document).ready(function() {
    // 중복확인 버튼 클릭 이벤트
    $('#overlay').on('click', function() {
        var user_nickname = $('#user_nickname').val();
        $.ajax({
            url: 'overlay.ajax', // 서버에서 닉네임 중복 확인을 처리하는 경로
            type: 'GET',
            data: { user_nickname: user_nickname },
            success: function(data) {
                // 서버에서 중복 여부에 대한 결과를 응답 (예: 사용 가능 여부)
                if (data.overlay > 0) {
                	$('#checkNickname').text('이미 사용 중인 닉네임입니다.').css('color', 'rgb(255, 140, 9)');
                } else {
                    $('#checkNickname').text('사용 가능한 닉네임입니다.').css('color', '#20290E');
                }
            },
            error: function() {
                $('#checkNickname').text('닉네임 중복 확인 중 오류가 발생했습니다.').css('color', 'rgb(255, 140, 9)');
            }
        });
    });
});
$('#updateBtn').on('click', function() {
    var password = $('#user_pw').val();
    var passwordCheck = $('#user_pwCheck').val();
    var nickname = $('#user_nickname').val();

    // 비밀번호 일치 여부 확인
    if (password !== passwordCheck) {
        alert('비밀번호가 일치하지 않습니다. 수정이 불가능합니다.');
        return;
    }

    // 모든 조건을 만족하면 폼 제출
    $('#userForm').submit();
});
</script>
</html>