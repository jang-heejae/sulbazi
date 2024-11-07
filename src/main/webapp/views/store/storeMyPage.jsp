<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		background-color: rgba(255, 255, 255, 0.1);
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
	#storePhoto{
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
	#upBtn{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
</style>
</head>
<body>
<jsp:include page="../main/adminMain.jsp"/>
    <section class="chatBox2">
        <div class="chatitems2">
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
				<img id="mainPhoto" src="/photo/${mystorebestphoto.new_filename}"><br/>
	        </div>
	</div><br/>
	<div class="form-group2">
		<label style="margin-bottom:10px;">매장 내외부 사진</label>
			<div class="form-group3">
				<c:forEach items="${mystorephoto}" var="mystoreinout">
					<div><img id="storePhoto" src="/photo/${mystoreinout.new_filename}"></div><br/>
				</c:forEach>
			</div>
	</div><br/>
	<div class="storeinfo">
	<div class="table">
		<ul>
			<li><label>아이디</label> <input type="text" value="${storedto.store_id}" readonly></li>
			<li><label>비밀번호</label> <input type="password" value="${storedto.store_pw}" readonly></li>
			<li><label>매장 이름</label> <input type="text" value="${storedto.store_name}" readonly></li>
			<li><label>사업자 번호</label> <input type="text" value="${storedto.store_number}" readonly></li>
			<li><label>전화번호</label> <input type="text" value="${storedto.store_phone}" readonly></li>
			<li><label>주소</label> <input type="text" value="${storedto.store_address}" readonly></li>
			<li><div class="mapwhatname" id="map" style="width:789px;height:320px;"></div></li>
			<li><label>운영시간</label></li>
			<li><textarea id="textarea" readonly>${storedto.store_time}</textarea></li>
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
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
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
	                       			<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
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
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
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
		                       		<c:if test="${selectedValues.contains(option.opt_idx)}">checked="checked"</c:if> readonly/>
		                   		${option.opt_name} <br/>
		               		</c:if>
		           		</c:forEach>
		           	</div>
			</li>
			<li>
				<button type="submit" id="upBtn" onclick="location.href='mystoreUpdate.go'">수정 하기</button>
			</li>
		</ul>
	</div>
	<br/>
	</div>
</div>
</div>
</section>
</body>
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

</script>
</html>
