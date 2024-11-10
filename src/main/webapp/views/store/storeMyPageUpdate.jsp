<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4ae2258b561b1a937e5d3f2c155e60f9"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
		margin-top: 150px;
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
    	border: 2px solid rgb(255, 140, 9);
	}
		input[type="radio"] {
        appearance: none; /* 기본 스타일 제거 */
        width: 15px;
        height: 15px;
        background-color: #041d03; /* 원하는 배경색 */
        border: 2px solid #041d03; /* 테두리 색 */
        border-radius: 50%; /* 동그란 모양 */
        cursor: pointer;
        position: relative;
    }

    input[type="radio"]:checked {
        background-color: #041d03; /* 체크 시 배경색 */
        border: 0.1px solid #041d03; /* 체크 시 테두리 색 */
    }

    input[type="radio"]::after {
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
    input[type="radio"]:checked::after {
        background-color: rgb(255, 140, 9); /* 체크 시 점 색상 */
    }
	.mapwhatname{
		border-radius: 8px;
	}
	.all {
    	width: 65%;
    	gap: 20px;
    	margin-left: auto;
    	margin-right: auto;
	}
	.store_name {
    	display: flex;
    	justify-content: center; /* 수직 중앙 정렬 */
    	align-items: center; /* 양쪽 끝으로 요소 배치 */
    	width: 100%; /* 부모 요소의 너비에 맞춤 */
    	margin-bottom: 30px; /* 아래쪽 여백 */
    	position: relative;
	}
	.store_bookmark{
		position: absolute;
    	right: 0; /* 부모 요소의 오른쪽 끝에 배치 */
    	display: flex;
    	align-items: center; /* 수직 중앙 정렬 */
    	gap: 10px;
    	flex-direction: row;
	}
	#store-name {
    	flex: 1; /* 나머지 공간을 차지하여 중앙 정렬 효과 */
    	text-align: center; /* 텍스트를 가운데 정렬 */
    	font-size: 36px;
    	font-weight: bold;
	}
	.form-group {
    	width: 100%;
    	text-align: center;
    	gap: 10px; /* 요소 간의 간격 설정 */
    	color: white;
	}
	.table li{
	 	padding: 10px;
		display: flex;
    	flex-direction: row;
    	justify-content: space-evenly;
    	align-items: center; /* 수직 중앙 정렬 */
    	gap: 10px;
	}
	.table li label {
    	width: 100px; /* 모든 레이블의 너비를 동일하게 고정 */
   		text-align: right; /* 레이블을 오른쪽으로 정렬 */
	}
	.form-group2{
    	display: flex;
    	flex-direction: row;
    	flex-wrap: wrap;
    	justify-content: center;
	}
	.form-group3{
    	display: flex;
    	flex-direction: row;
    	flex-wrap: wrap;
    	justify-content: center;
	}
	.form-group3 div{
		margin: 3px;
	}
	textarea {
		outline: none;
		border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid #041d03;
		background-color: white;
		border-radius: 10px;
		width: 100%;
    	padding: 10px;
    	color:#041d03;
	}
	.radio-group {
    	display: flex; /* flex 컨테이너로 설정 */
   		gap: 10px; /* 요소 간 간격 설정 */
   		margin: 10px
	}
	input[type="text"], input[type="password"]{
		border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid #041d03;
		padding: 4px;
		border-radius: 10px;
		width: 250px;
		background-color: rgba(255, 255, 255, 0.1);
		color:#041d03;
		outline: none;
	}
	#mainPhoto{
		width: 215px;
    	height: 215px;
	}
	.storePhoto{
		width: 150px;
		height: 150px;
	}
	#bookmark li{
		text-align: center;
	}
	.store_cate li{
		display: flex;
    	flex-direction: column;
    	align-content: center;
    	align-items: center;
	}
	.likeIcon{
		width: 50px;
		margin-right: -12px;
	}
	.span {
    	margin-left: -9px;
    	margin-right: -9px;
    	padding: 0;/* 상위 요소와 동일한 글자 크기 사용 */
	}
	#store_menu {
    	display: flex;
    	flex-direction: column;
    	align-items: center; /* 전체 메뉴를 중앙에 위치시킴 */
    	width: 100%;
	}
	#store_menu li {
    	text-align: center;
    	margin-bottom: 20px;
	}
	#store_menu laber {
    	font-size: 24px;
    	font-weight: bold;
	}
	.store_menu2 {
    	width: 100%;
    	display: flex;
    	justify-content: center;
    	margin-bottom: 20px;
	}
	.menu-content {
    	display: flex;
    	justify-content: space-between;
    	align-items: center;
    	width: 100%; /* 메뉴 항목의 너비를 조정 */
    	padding: 10px;
    	border-radius: 8px;
    	background-color: rgba(255, 255, 255, 0.1);
	}
	#store_menu li img {
    	width: 50px;
    	height: 50px;
    	object-fit: cover;
    	margin-right: 20px;  /* 이미지 비율을 유지하면서 잘 맞게 설정 */
	}
	.menu-details {
    	display: flex;
    	flex-direction: column;
    	align-items: flex-end; /* 텍스트를 오른쪽 정렬 */
    	text-align: right;/* 이름과 가격을 왼쪽으로 정렬 */
    	gap: 5px; /* 이름과 가격 사이의 간격 */
	}
	label {
		font-size:  20px;
	}
	#upBtn, #ccBtn{
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
	.pwCheckMessage{
		     margin: -10px;
    margin-left: 30px;
	}
	
	.modal_madal2 {
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

.modal-content_madal2 {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

.btn_madal2 {
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

.btn_madal2:hover {
    background-color: #20290E;
    color: white;
}

.close_madal2 {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close_madal2:hover,
.close_madal2:focus {
    color: black;
}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
    <section class="chatBox2">
        <div class="chatitems2">
        <form id="storeForm" enctype="multipart/form-data">
			<div class="all"> 
				<div class="store_name">
					<div id="store_name" style="font-size: 36px; font-weight: bold; margin-bottom: 30px; color:rgb(255, 140, 9);">
						${storedto.store_name}</div> 
					<div class="store_bookmark">
						<i class="fas fa-star" style="color: yellow;"></i>
						${storedto.star_average}&nbsp;(<span class="span">${storedto.review_total}</span>)
						<img class="likeIcon" src="resources/img/userLike.png"/>
			${storedto.bookmark_user}
		</div>	
	</div>
	<div class="form-group">
	    <label style="color: #041d03;">매장 대표 사진</label>
	        <div style="margin-top: 10px;">
				<img id="mainPhoto" class="mainPhoto" src="/photo/${mystorebestphoto.new_filename}" name="mystorebestphoto"><br/>
	        </div>
	</div><br/>
	<input type="file" name="bestmystore" accept="image/*" multiple="multiple" id="fileInput" style="display: none;"/>
	<div class="form-group2">
    	<label style="margin-bottom:10px;">매장 내외부 사진</label>
   	 		<div class="form-group3">
        		<c:forEach items="${mystorephoto}" var="mystoreinout" varStatus="status">
            		<c:if test="${status.index < 5}">
                		<div class="photo-item" id="photoItem${status.index}">
                    		<img id="storePhoto${status.index}" name="mystoreinout" class="storePhoto" src="/photo/${mystoreinout.new_filename}" />
                    		<input type="file" name="newmystoreinout" multiple="multiple" accept="image/*" id="fileInput${status.index}" class="fileInput" style="display: none;" data-index="${status.index}" />
                		</div>
            		</c:if>
        		</c:forEach>
        		<c:forEach begin="${fn:length(mystorephoto)}" end="4" var="i">
            		<div class="photo-item" id="photoItem${i}">
                		<img id="storePhoto${i}" class="storePhoto" src="" />
                		<input type="file" name="newmystoreinout" id="fileInput${i}" class="fileInput" style="display: none;" data-index="${i}" />
            		</div>
        		</c:forEach>
    		</div>
	</div>
	<div class="storeinfo">
	<div class="table">
		<ul>
			<li><label>아이디</label> <input type="text" name="store_id" value="${storedto.store_id}" readonly></li>
			<li><label>비밀번호</label> <input type="password" id="store_pw" name="store_pw" value="${storedto.store_pw}"/></li>
			<li><label>비밀번호 확인</label> <input type="password" id="store_pwCheck" name="store_pwCheck" value=""/></li>
			<li class="pwCheckMessage"><span id="pwCheckMessage"></span></li>
			<li><label>사업자 번호</label> <input type="text" name="store_number" value="${storedto.store_number}" readonly/></li>
			<li><label>매장 이름</label> <input type="text" name="store_name" value="${storedto.store_name}"/></li>
			<li><label>전화번호</label> <input type="text" name="store_phone" value="${storedto.store_phone}"/></li>
			<li><label>주소</label> <input type="text"name="store_address" value="${storedto.store_address}"/></li>
			<li><div class="mapwhatname" id="map" style="width:789px;height:320px;"></div></li>
			<li><label>운영시간</label></li>
			<li><textarea id="textarea" name="store_time">${storedto.store_time}</textarea></li>
		</ul>
	</div>
	<br/>
	<div class="store_cate">
		<ul>
			<li>
				<label>주종</label>
					<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 1}">
	                   			<input type="radio" name="alchol" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if>/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
			</li><li>&nbsp;</li>
			<li>
				<label>안주</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
	               			<c:if test="${option.category_idx == 2}">
	                   			<input type="radio" name="food" value="${option.opt_idx}"
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if>/>
	                   			${option.opt_name} <br/>
	               			</c:if>
	           			</c:forEach>
	           		</div>
			</li><li>&nbsp;</li>
			<li>
				<label>분위기</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 3}">
		                   		<input type="radio" name="mood" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if>/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
			</li><li>&nbsp;</li>
			<li>
				<label>방문목적</label>
				<div class="radio-group">
						<c:forEach var="option" items="${options}">
		               		<c:if test="${option.category_idx == 4}">
		                   		<input type="radio" name="visit" value="${option.opt_idx}"
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if>/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
			</li>
			<li>
				<button type="button" id="upBtn">수정 하기</button>
				<button type="button" id="ccBtn">취소 하기</button>
			</li>
		</ul>
	</div>
	<br/>
	</div>
</div>
</form>
</div>
</section>
</body>
<div id="confirmationModal2" class="modal_madal2">
    <div class="modal-content_madal2">
        <span class="close_modal2" id="closeModal2">&times;</span>
        <p id="confirmationMessage2"></p>
        <button type="button" class="btn_madal2" id="confirmAction2">확인</button>
        <button type="button" class="btn_madal2" id="cancelAction2">취소</button>
    </div>
</div>

<script>
$(document).ready(function() {
    var textarea = $('#textarea');

    // textarea 내용의 줄 수를 세어 rows 속성 설정
    var lines = (textarea.val().split("\n").length) + 1; // \n의 개수를 세어 줄 수 계산
    textarea.attr('rows', lines);
});

var container = document.getElementById('map');
var storeLatitude = '${storedto.store_latitude}';
var storeLongitude = '${storedto.store_longitude}';
 
var options = {
    center: new kakao.maps.LatLng(storeLatitude, storeLongitude),
    level: 3
};

var map = new kakao.maps.Map(container, options);

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(storeLatitude, storeLongitude); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});
marker.setMap(map);

// 이미지 클릭 시 파일 입력 창 열기 - 이벤트 위임 방식 사용
$(document).ready(function() {

    $(document).on('click', '#mainPhoto', function () {
        $('#fileInput').click();
    });

    // 매장 내외부 사진 클릭 시 파일 입력 창 열기
    $(document).on('click', '.storePhoto', function () {
        var index = $(this).attr('id').replace('storePhoto', '');
        $('#fileInput' + index).click();
    });

    // 대표 사진 파일 선택 시 미리보기 업데이트 및 AJAX 업로드
    $('#fileInput').on('change', function (event) {
        var files = event.target.files;
        if (files.length > 0 && files[0].type.startsWith('image/')) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#mainPhoto').attr('src', e.target.result);
            };
            reader.readAsDataURL(files[0]);

            // 대표 사진 업로드 AJAX 요청
            var formData = new FormData();
            formData.append('bestmystore', files[0]);

            $.ajax({
                url: 'mystoreBestPhotoUpdate.do',
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                	if (!response.success) {
                        console.error('대표 사진 업로드 중 오류가 발생했습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    alert('대표 사진 업로드 중 오류가 발생했습니다. 다시 시도해주세요.');
                    console.error(error);
                }
            });
        }
    });

    // 매장 내외부 사진 파일 선택 시 미리보기 업데이트 및 AJAX 업로드
    $('.fileInput').on('change', function (event) {
        var index = $(this).data('index');
        var files = event.target.files;
        var $previewImage = $('#storePhoto' + index);
        if (files.length > 0 && files[0].type.startsWith('image/')) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $previewImage.attr('src', e.target.result);
            };
            reader.readAsDataURL(files[0]);

            // 내외부 사진 업로드 AJAX 요청
            var formData = new FormData();
            formData.append('newmystoreinout', files[0]);

            $.ajax({
                url: 'mystoreInoutUpdate.do',
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                	if (!response.success) {
                        console.error('대표 사진 업로드 중 오류가 발생했습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    alert('내외부 사진 업로드 중 오류가 발생했습니다. 다시 시도해주세요.');
                    console.error(error);
                }
            });
        }
    });

    function checkPasswordMatch() {
        var password = $('#store_pw').val();
        var passwordCheck = $('#store_pwCheck').val();
        var message = $('#pwCheckMessage');

        if (passwordCheck.length === 0) {
            // 비밀번호 확인란이 비어 있을 경우 메시지 초기화
            message.text('');
        } else if (password === passwordCheck) {
            // 비밀번호가 일치할 때
            message.text('비밀번호가 맞습니다.').css('color', '#20290E');
        } else {
            // 비밀번호가 일치하지 않을 때
            message.text('비밀번호가 다릅니다.').css('color', 'rgb(255, 140, 9)');
        }
    }

    // 비밀번호와 비밀번호 확인 필드에서 keyup 이벤트 발생 시 호출
    $('#store_pw, #store_pwCheck').on('keyup', checkPasswordMatch);

    // 수정하기 버튼 클릭 이벤트 (AJAX 사용)
    $('#upBtn').on('click', function () {
        $('#confirmationMessage2').text('수정하시겠습니까?');
        $('#confirmationModal2').show();

        // 확인 버튼 클릭 이벤트 설정 (수정 작업 수행)
        $('#confirmAction2').off('click').on('click', function () {
            var formData = new FormData($('#storeForm')[0]);
            $.ajax({
                url: 'mystoreUpdate.do',
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response.success) {
                        $('#confirmationModal2').hide();
                        location.href = response.link;
                    } else {
                        alert('수정 중 오류가 발생했습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    alert('수정 중 오류가 발생했습니다. 다시 시도해주세요.');
                    console.error(error);
                }
            });
        });

        // 취소 버튼 클릭 시 모달 닫기
        $('#cancelAction2').off('click').on('click', function () {
            $('#confirmationModal2').hide();
        });

        // 모달 닫기 버튼 클릭 시 모달 닫기
        $('#closeModal2').off('click').on('click', function () {
            $('#confirmationModal2').hide();
        });
    });

    // 취소하기 버튼 클릭 이벤트
    $('#ccBtn').on('click', function () {
        $('#confirmationMessage2').text('취소하시겠습니까?');
        $('#confirmationModal2').show();

        // 확인 버튼 클릭 이벤트 설정 (취소 작업 수행)
        $('#confirmAction2').off('click').on('click', function () {
            location.href = 'storeMyPage.go';
        });

        // 취소 버튼 클릭 시 모달 닫기
        $('#cancelAction2').off('click').on('click', function () {
            $('#confirmationModal2').hide();
        });

        // 모달 닫기 버튼 클릭 시 모달 닫기
        $('#closeModal2').off('click').on('click', function () {
            $('#confirmationModal2').hide();
        });
    });
});
</script>
</html>