<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<style>
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	justify-content: center;
    	align-items: flex-start;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
    	border: 2px solid rgb(255, 140, 9);
	}
	.userProfile {
        display: flex;
        width: 100%;
        align-items: flex-start; /* 상단 정렬 */
        justify-content: center;
    }

    .userProfile2 {
        width: 45%; /* 왼쪽에 위치 */
        display: flex;
        flex-direction: column;
        gap: 10px;
        align-items: center;
        margin-top:14px;
    	margin-left: -25px;
    }
    .userInfo {
        width: 45%; /* 오른쪽에 위치 */
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 10px;
        margin-top: 23px;
        margin-left: 77px;
    }
    .userProfile3 ul{
    	display: flex;
    	flex-direction: column;
    	align-items: flex-end;
    }
    .userProfile3 li{
    	    display: flex;
    	flex-direction: row;
    	align-items: center;
    }
    .userProfile3 label{
    	width: 100px;
    	color:#041d03;
    }
    .userProfile3 input[type="text"], input[type="password"]{
    	margin-left: 73px;
    	width: 255px;
    	padding: 8px;
    	margin-bottom: 5px;
    	border-radius: 10px;
    	border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid  rgb(255, 140, 9);
		background-color: rgba(255, 255, 255, 0.1);
		color:#041d03;
		outline: none;
		font-family: "Yeon Sung", system-ui;
    }
    .userNickname{
   		font-size: 96px;
   		margin-left: 31px;
    	 	margin-bottom: 12px;
    	 	color: rgb(255, 140, 9);
    	 	-webkit-text-stroke: 1px #20290E;
    }
    #userLike{
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    }
	.likeIcon{
    	width: 50px;
    	height: 50px;
    	object-fit: cover;
    	margin-right: 17px;
	}
	.profile-image {
    	width: 250px;
    	height: 250px;
    	border-radius: 50%; /* 동그란 모양으로 만들기 */
    	object-fit: cover; /* 이미지의 비율을 유지하면서 크기를 맞춤 */
	}
	.userCate{
	    margin-top: 36px;
	    color:#041d03;
	}
	.userCate li{
	    display: flex;
    	flex-direction: column;
    	align-items: center;
	}
	.userCate div{
		display: flex;
    	flex-direction: row;
    	    margin-bottom: 28px;
   		margin-top: -14px;
   		display: inline-block;
	}
	.userCate input[type="radio"] {
        appearance: none; /* 기본 스타일 제거 */
        width: 15px;
        height: 15px;
        background-color: #041d03; /* 원하는 배경색 */
        border: 2px solid #041d03; /* 테두리 색 */
        border-radius: 50%; /* 동그란 모양 */
        cursor: pointer;
        position: relative;
    }

    .userCate input[type="radio"]:checked {
        background-color: #041d03; /* 체크 시 배경색 */
        border: 0.1px solid #041d03; /* 체크 시 테두리 색 */
    }

    .userCate input[type="radio"]::after {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background-color: transparent; /* 체크되지 않았을 때는 투명 */
    }

    .userCate input[type="radio"]:checked::after {
        background-color: rgb(255, 140, 9); /* 체크 시 점 색상 */
    }
	button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	input:not([readonly]) {
    	background-color: white !important;
    	color: #041d03 !important; /* 텍스트 색상 */
	}
	label{
		font-size: 20px;
	}
.modal_madal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 300px;
    height: auto;
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 10px;
    box-shadow: 0px 4px 8px #041d03;
    color: #041d03;
    text-align: center;
    font-family: "Yeon Sung", system-ui;
}

.modal-content_madal {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

.btn_madal {
    background-color: rgb(255, 140, 9);
    color: #041d03;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin: 10px;
    font-family: "Yeon Sung", system-ui;
}

.btn_madal:hover {
    background-color: #20290E;
    color: white;
}

.close_madal {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close_madal:hover,
.close_madal:focus {
    color: black;
}
</style>
</head>
<body>
<form action="userUpdate.do" method="post" id="userForm" enctype="multipart/form-data">
	<c:import url="../main/main.jsp"/>
	    <section class="chatBox2">
        	<div class="chatitems2">
        	<div class="userProfile">
        		<div class="userProfile2">
				<div id="userProfile">
				<div class="userNickname">${info.user_nickname}</div>
					<div id="previewContainer">
						<c:if test="${files.size()>0}">
							<c:forEach items="${files}" var="file">
								<img id="profileImage" class="profile-image" alt="${file.user_photo}" src="/photo/${file.user_photo}"/>
							</c:forEach>
						</c:if>
					</div>
				</div>
			<input type="file" name="files" multiple="multiple" id="fileInput" style="display: none;"/>
			<div class="userLike"></div>
			<div id="userLike">
				<img class="likeIcon" src="resources/img/userLike.png"/>
				<ul>
					<li>${info.user_likecount}</li>
				</ul>
			</div>
			<button type="button" id="updateBtn">수정 하기</button>
			<button type="button" id="cancelBtn">취소 하기</button>
			</div>
			<div class="userInfo">
			<div class="userProfile3">
				<ul>
					<li><label>아이디</label> <input type="text" name="user_id" value="${info.user_id}" readonly="readonly"/></li>
					<li><label>비밀번호</label> <input type="password" id="user_pw" name="user_pw" value="${info.user_pw}" /></li>
					<li><label>비밀번호 확인</label> <input type="password" id="user_pwCheck" name="user_pwCheck" value=""/></li>
					<li><span id="pwCheckMessage"></span></li>
					<li><label>이름</label> <input type="text" name="user_name" value="${info.user_name}" readonly="readonly"/></li>
					<li><label>닉네임</label> 
                			<input type="text" name="user_nickname" value="${info.user_nickname}"/>
					</li>
                	<li><div><span id="checkNickname"></span><button type="button" id="overlay">중복확인</button></div></li>
					<li><label>생년월일</label> <input type="text" name="user_birth" value="${info.user_birth}"/></li>
					<li><label>전화번호</label> <input type="text" name="user_phone" value="${info.user_phone}"/></li>
					<li><label>이메일</label> <input type="text" name="user_email" value="${info.user_email}" readonly="readonly"/></li>
				</ul>
			</div>
			<div class="userCate">
		    	<ul>
				<!-- 주종 카테고리 -->
					<li>
						<label>주종</label>&nbsp;&nbsp;&nbsp;
						<div><c:forEach var="category" items="${allCategories}">
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
						</c:forEach></div>
					</li>

				<!-- 안주 카테고리 -->
					<li>
						<label>안주</label>&nbsp;&nbsp;&nbsp;
							<div><c:forEach var="category" items="${allCategories}">
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
						</c:forEach></div>
					</li>

				<!-- 분위기 카테고리 -->
					<li>
						<label>분위기</label>&nbsp;&nbsp;&nbsp;
							<div><c:forEach var="category" items="${allCategories}">
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
					</c:forEach></div>
				</li>

				<!-- 방문목적 카테고리 -->
				<li>
					<label>방문목적</label>&nbsp;&nbsp;&nbsp;
						<div><c:forEach var="category" items="${allCategories}">
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
					</c:forEach></div>
			</li>
    		</ul>
		</div>
		</div>
	</div>
	</div>
</section>

<!-- 수정 및 취소 확인 모달 -->
<div id="confirmationModal" class="modal_madal">
    <div class="modal-content_madal">
        <span class="close_modal" id="closeModal">&times;</span>
        <p id="confirmationMessage"></p>
        <button type="button" class="btn_madal" id="confirmAction">확인</button>
        <button type="button" class="btn_madal" id="cancelAction">취소</button>
    </div>
</div>

</form>
</body>
<script>
$(document).ready(function() {
    var originalImageSrc = $('#previewContainer img').attr('src'); // 원래 이미지의 경로를 저장

    // 이미지 클릭 시 파일 입력 창 열기 - 이벤트 위임 방식 사용
    $(document).on('click', '#profileImage, .profile-image', function() {
        $('#fileInput').click();
    });

    $('#fileInput').on('change', function(event) {
        var files = event.target.files;
        var $previewContainer = $('#previewContainer');

        if (files.length === 0) {
            // 파일 선택을 취소한 경우 원래 이미지로 복원
            if (originalImageSrc) {
                $previewContainer.html('<img class="profile-image" src="' + originalImageSrc + '"/>');
            }
            return;
        }

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

    // 파일 선택 취소 시 원래 이미지를 복원하기 위한 input reset 처리
    $('#fileInput').on('click', function() {
        originalImageSrc = $('#previewContainer img').attr('src'); // 파일 선택 전 원래 이미지를 저장
    });
    
    // 비밀번호 확인
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

    // 중복확인 버튼 클릭 이벤트
    $('#overlay').on('click', function() {
        var user_nickname = $('#user_nickname').val();
        $.ajax({
            url: 'overlay.ajax', // 서버에서 닉네임 중복 확인을 처리하는 경로
            type: 'GET',
            data: { user_nickname: user_nickname },
            success: function(data) {
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

    // 수정하기 버튼 클릭 이벤트
    $('#updateBtn').on('click', function() {
        $('#confirmationMessage').text('수정하시겠습니까?');
        $('#confirmationModal').show();

        // 확인 버튼 클릭 이벤트 설정 (수정 작업 수행)
        $('#confirmAction').off('click').on('click', function() {
            var password = $('#user_pw').val();
            var passwordCheck = $('#user_pwCheck').val();

            // 비밀번호 일치 여부 확인
            if (password !== passwordCheck) {
                alert('비밀번호가 일치하지 않습니다. 수정이 불가능합니다.');
                $('#confirmationModal').hide();
                return;
            }

            // 모든 조건을 만족하면 폼 제출
            $('#userForm').submit();
            $('#confirmationModal').hide();
        });

        // 취소 버튼 클릭 시 모달 닫기 (확인 버튼과 이벤트 겹치지 않도록 함)
        $('#cancelAction').off('click').on('click', function() {
            $('#confirmationModal').hide();
        });

        // 모달 닫기 버튼 클릭 시 모달 닫기
        $('#closeModal').off('click').on('click', function() {
            $('#confirmationModal').hide();
        });
    });

    // 취소하기 버튼 클릭 이벤트
    $('#cancelBtn').on('click', function() {
        $('#confirmationMessage').text('취소하시겠습니까?');
        $('#confirmationModal').show();

        // 확인 버튼 클릭 이벤트 설정 (취소 작업 수행)
        $('#confirmAction').off('click').on('click', function() {
            // 취소 확인 시 페이지 이동
            location.href = '/SULBAZI/userMyPage.go';
        });

        // 취소 버튼 클릭 시 모달 닫기 (확인 버튼과 이벤트 겹치지 않도록 함)
        $('#cancelAction').off('click').on('click', function() {
            $('#confirmationModal').hide();
        });

        // 모달 닫기 버튼 클릭 시 모달 닫기
        $('#closeModal').off('click').on('click', function() {
            $('#confirmationModal').hide();
        });
    });
});
</script>
</html>
