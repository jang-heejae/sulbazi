<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4ae2258b561b1a937e5d3f2c155e60f9&libraries=services"></script>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
    a{
        text-decoration: none;
        color: white;
    }
    body{
        background-color: #041d03;
        height: 1800;
    }
    .navbar{
        z-index: 99;
        position: absolute;
        left: 360px;
        justify-items: center;
        width: 1200px;
        height: 120px;
        background-color: #041d03;
        color: rgb(255, 140, 9);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: 455px;
        color: rgb(255, 140, 9);
        font-size: 70px;
        font-weight: bolder;
    }
   .container .wrapper {
      width: 803px;
        height: auto;
        margin: 0 auto;
      background-color: #e98d1c;
      border-radius: 8px;
        text-align: center;
   }
    .wrapper{
        position: relative;
        top: 160px;
    }
   h2, h3{
      color: white;
   }
    input[type="text"], input[type="password"]{
        text-align: left;
        width: 400px;
        height: 30px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 1%;
    }
    input[name="storeid"], input[name="storenum"]{
        margin-left: 10.5%;
    }
    button{
        color: #707070;
    }
    h6{
        margin-top: 0px;
        color: white;
    }
    input[name="storetime"]{
        height: 50px;
    }
    textarea{
        width: 50%;
        height: 250px;
        border-radius: 8px;
        resize: none;
    }
    button[id="save"]{
        width: 40%;
        height: 60px;
        position: relative;
        top: 220;
        left: 570;
        background-color: #e98d1c;
        border-radius: 8px;
        color: white;
        font-weight: 700;
        font-size: 30;
    }
    select[id="category"]{
        height: 30px;
    }
    .price{
        color: white;
        font-weight: 1000;
    }
    input[name="menu_name"], input[name="menu_price"]{
         text-align: left;
        width: 100px;
        height: 30px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 1%;
    }
    #iduncheck{
    	font-size: 11px;
    	margin-left: -95%;
    }
    #idoncheck{
    	font-size: 11px;
    	margin-left: -34%;
    }
    #idc{
    	margin-left: 10%;
    }
    #numb{
    	margin-left: 10%;
    }
    #numberCheckMessage{
    	font-size: 11px;
    	margin-left: -29%;
    }
    #pwCheckMessage{
	    position: absolute;
	    top: 186px;
	    right: 71px;
	    font-size: 13;
	}
	fieldset {
    border: 2px solid #e98d1c; /* 테두리 색을 파란색으로 설정 */
    padding: 10px; /* 내부 여백 */
    border-radius: 5px; /* 둥근 모서리 */
	}

	legend {
	    font-weight: bold; /* legend 텍스트를 굵게 */
	    color: white; /* legend 색상 */
	}
</style>
<body>
<form id="joinForm" method="post" id="joinForm" enctype="multipart/form-data" onsubmit="return validateForm()">
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="./mainPage.go">SULBAZI</a>
            </div>
        </nav>
    </header>
        <div class="container">
            <div class="wrapper">
                <h2>사업자 회원가입</h2>
                <input id="idc" type="text" name="store_id" value="" placeholder="아이디(필수)" required/>&nbsp;<button type="button" id="checkid">중복확인</button>
                <br>
                <span id="idoncheck"></span>
                <br>
                <input type="password" id="store_pw" name="store_pw" value="" placeholder="비밀번호(필수)" required>
                <input type="password" id="storepwcheck" name="storepwcheck" value="" placeholder="비밀번호 확인(필수)" required><span id="pwCheckMessage"></span>
                <h6>※ 비밀번호 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</h6>
                <input id="numb" type="text" name="store_number" value="" placeholder="사업자번호(필수)" oninput="this.value = this.value.replace(/[^0-9]/g, '')" required/>&nbsp;<button id="checknumberBtn">중복확인</button>
                <br>
                <span id="numberCheckMessage"></span>
	            <br> <!-- 사용 가능한 아이디 메시지 추가 -->
                <input type="text" name="store_name" value="" placeholder="매장 이름(필수)" required>
                <input type="text" name="store_phone" value="" placeholder="매장 전화번호(선택사항)" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                <input type="text" id="addressInput" name="store_address" value="" placeholder="매장 주소(필수)" required>
                <input type="hidden" id="latitude" name="latitude" value="" required>
				<input type="hidden" id="longitude" name="longitude" value="" required>
                <textarea name="store_time" maxlength="1000" placeholder="ex) 운영 시간                                                      월요일 15:00 ~ 02:00                                    화요일 휴무                                             수요일 15:00 ~ 02:00"></textarea>
                <h2>대표 사진</h2>
                <div id="img_list2"></div>
                <input type="file" name="fileone" multiple="multiple" onchange="readFileone(this)" required>
                <h6>※ 대표메뉴는 필수 등록입니다. 최대 1개</h6>
                <h2>가게 내, 외부사진</h2>
                <div id="img_list"></div>
                <input type="file" name="files" value="1" multiple="multiple" onchange="readFile(this)"/>
                <h6>※파일은 5MB 이하, 최대 5개까지 가능합니다.</h6>
                <h2>카테고리(각 1개 선택가능(필수))</h2>
                <fieldset>
				    <legend>주종</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 1}">
				            <input type="radio" id="category_${category.category_idx}" name=category1 value="${category.opt_idx}" required/>
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>

				<fieldset>
				    <legend>안주</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 2}">
				            <input type="radio" id="category_${category.category_idx}" name=category2 value="${category.opt_idx}" required/>
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>분위기</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 3}">
				            <input type="radio" id="category_${category.category_idx}" name=category3 value="${category.opt_idx}" required/>
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>방문목적</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 4}">
				            <input type="radio" id="category_${category.category_idx}" name=category4 value="${category.opt_idx}" required/>
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
            </div>
        </div>
        <button type="button" id="save" onclick="save(event)">회원가입</button>
    </form>
</body>
<script>
$('#idc').on('input', function() {
    this.value = this.value.replace(/[^a-zA-Z0-9]/g, ''); // 영문자, 숫자 외 문자 삭제
});

// 폼 제출 시 비밀번호 확인, 필수 입력 체크
function validateForm() {
    var store_pw = $('#store_pw').val();
    var storepwcheck = $('#storepwcheck').val();

    // 비밀번호 확인
    if (store_pw !== storepwcheck) {
        alert('비밀번호를 확인해주세요.');
        return false;
    }

    // 필수 입력값 체크
    if ($('#idc').val() === '' || $('#store_pw').val() === '' || $('#store_name').val() === '' || $('#store_address').val() === '' || $('#store_number').val() === '') {
        alert('모든 필수 항목을 입력해주세요.');
        return false;
    }

    return true;
}

// 회원가입 버튼 클릭 시 validateForm 함수 호출
function save(event) {
    // validateForm 호출
    if (!validateForm()) {
        return;
    }

    var form = new FormData($('#joinForm')[0]);
    $.ajax({
        type: 'POST',
        url: 'storeJoin.ajax',
        encType: 'multipart/form-data',
        processData: false,
        contentType: false,
        data: form,
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if (data.success) {
                alert("회원가입에 성공하셨습니다.");
                location.href = data.link;
            } else {
                alert(data.message);
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
    $("#joinForm").submit(function(event) {
        var password = $("#store_pw").val();
        var confirmPassword = $("#storepwcheck").val();

        // 비밀번호와 비밀번호 확인이 다를 경우
        if (password !== confirmPassword) {
            event.preventDefault(); // 폼 제출 방지
            alert("비밀번호가 다릅니다."); // 경고창 띄우기
            return false; // 화면 유지
        }
    });	
}

function readFile(input){
	console.log(input.files);
	const files = input.files;
    const maxFileCount = 5;
    const maxFileSize = 5 * 1024 * 1024; // 2MB 제한

    // 파일 개수 체크
    if (files.length > maxFileCount) {
      alert("사진은 최대 5개까지만 가능합니다.");
      input.value = ''; // 파일 선택 초기화
      return;
    }
	var reader;
	$('#img_list').empty();
	for (var file of input.files) {
		reader = new FileReader(); 
		reader.readAsDataURL(file); 
		reader.onload = function(e){ 
		$('#img_list').append('<img class="preview" src="'+e.target.result+'" style="max-width: 100px; max-height: 100px; margin: 5px;"/>');
		}
	}
}

function readFileone(input){
	console.log(input.files);
	const files = input.files;
    const maxFileCount = 1;
    const maxFileSize = 5 * 1024 * 1024; // 2MB 제한

    // 파일 개수 체크
    if (files.length > maxFileCount) {
      alert("대표메뉴는 최대 1개까지만 등록 가능합니다.");
      input.value = ''; // 파일 선택 초기화
      return;
    }
	var reader;
	$('#img_list2').empty();
	const file = files[0];
	if (file.size > maxFileSize) {
        alert("파일 크기는 최대 5MB까지 가능합니다.");
        input.value = ''; // 파일 선택 초기화
        return;
    }
	$('#img_list2').empty(); // 기존 이미지 초기화
    reader = new FileReader(); 
    reader.readAsDataURL(file); 
    reader.onload = function(e){ 
        $('#img_list2').append('<img class="previews" src="'+e.target.result+'" style="max-width: 100px; max-height: 100px; margin: 5px;"/>');
    }
}


$(document).ready(function() {
    $('#save').click(function(event) {
        save(event); // 여기서 save 함수를 호출
    });
    $('#addressInput').on('blur', function() {
        getCoordinates();
    });
});

$(document).ready(function() {
    $('#checknumberBtn').click(function(event) {
    	event.preventDefault();
    	console.log("checknumberBtn 클릭됨");
        const storenumber = $('input[name="store_number"]').val();
        $.ajax({
            type: 'POST',
            url: 'checknumber.ajax',
            data: { store_number: storenumber },
            success: function(response) {
                if (response.exists) {
                    $('#numberCheckMessage').text("이미 있는 사업자 번호입니다.").css("color", "red");
                } else {
                    $('#numberCheckMessage').text("사용 가능한 사업자 번호입니다.").css("color", "blue");
                }
            }
        });
    });

    $('#store_pw, #storepwcheck').on('keyup blur', function(){
		var password = $('#store_pw').val();
		var passwordCheck = $('#storepwcheck').val();
		var message = $('#pwCheckMessage');
		if (passwordCheck.length > 0) {
			if (password === passwordCheck) {
				message.text('비밀번호가 맞습니다.').css('color', '#39FF14');
			}else {
				message.text('비밀번호가 다릅니다.').css('color', '#FF073A');
			}
		}else {
			message.text('');
		}
	});
});
    
    
    $('#checkid').click(function(event) {
    	event.preventDefault();
    	console.log("checkIdBtn 클릭됨");
        const userId = $('input[name="store_id"]').val();
        $.ajax({
            type: 'POST',
            url: 'checkstoreid.ajax',
            data: { store_id: userId },
            success: function(response) {
                if (response.exists) {
                	$('#idoncheck').text("이미 있는 아이디입니다.").css("color", "red"); 
                } else {
                    $('#idoncheck').text("사용 가능한 아이디입니다.").css("color", "blue");
                }
            }
        });
    });

function getCoordinates() {
    const address = document.getElementById('addressInput').value.trim(); 
    const geocoder = new kakao.maps.services.Geocoder();

    const callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            console.log("Result:", result);  
            const latitude = result[0].y; // y 값을 latitude 변수에
            const longitude = result[0].x; 
            document.getElementById('latitude').value = latitude; // 위도 값을 hidden input에 저장
            document.getElementById('longitude').value = longitude; // 경도 값을 hidden input에 저장
            console.log(`Latitude: ${latitude}, Longitude: ${longitude}`);
        } else {
            console.error("주소를 찾을 수 없습니다.");
        }
    };

    geocoder.addressSearch(address, callback);
}
</script>
</html>
