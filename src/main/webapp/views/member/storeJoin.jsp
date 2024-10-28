<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    input[type="text"]{
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
</style>
<body>
<form id="joinForm" method="post" enctype="multipart/form-data">
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="#">SULBAZI</a>
            </div>
        </nav>
    </header>
        <div class="container">
            <div class="wrapper">
                <h2>사업자 회원가입</h2>
                <input type="text" name="store_id" value="" placeholder="아이디(필수)"/>&nbsp;<button>중복확인</button><br>
                <input type="text" name="store_pw" value="" placeholder="비밀번호(필수)">
                <input type="text" name="storepwcheck" value="" placeholder="비밀번호 확인(필수)">
                <h6>※ 비밀번호 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</h6>
                <input type="text" name="store_number" value="" placeholder="사업자번호(필수)"/>&nbsp;<button id="checknumberBtn">중복확인</button>
                <span id="numberCheckMessage" style="color: red;"></span>
	            <span id="numberAvailableMessage" style="color: blue;"></span><br> <!-- 사용 가능한 아이디 메시지 추가 -->
                <input type="text" name="store_name" value="" placeholder="매장 이름(필수)">
                <input type="text" name="store_phone" value="" placeholder="매장 전화번호(선택사항)">
                <input type="text" id="store_address" name="store_address" value="" placeholder="매장 주소(필수)">
                <!-- <input type="hidden" id="latitude" name="latitude">
				<input type="hidden" id="longitude" name="longitude"> -->
                <textarea name="store_time" placeholder="ex) 운영 시간                                                      월요일 15:00 ~ 02:00                                    화요일 휴무                                             수요일 15:00 ~ 02:00"></textarea>
                <h2>대표 사진</h2>
                <input type="file" name="fileone" multiple="multiple">
                <h6>※ 대표메뉴는 필수 등록입니다. 최대 1개</h6>
                <h2>가게 내, 외부사진</h2>
                <input type="file" name="files" value="1" multiple="multiple" onchange="readFile(this)"/>
                <div id="img_list"></div>
                <h6>※파일은 5MB 이하, 최대 5개까지 가능합니다.</h6>
                <h2>카테고리(각 1개 선택가능(필수))</h2>
                <fieldset>
				    <legend>Category 1</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 1}">
				            <input type="radio" id="category_${category.category_idx}" name=category1 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>

				<fieldset>
				    <legend>Category 2</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 2}">
				            <input type="radio" id="category_${category.category_idx}" name=category2 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>Category 3</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 3}">
				            <input type="radio" id="category_${category.category_idx}" name=category3 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
				
				<fieldset>
				    <legend>Category 4</legend>
				    <c:forEach var="category" items="${category}">
				        <c:if test="${category.category_state && category.category_idx == 4}">
				            <input type="radio" id="category_${category.category_idx}" name=category4 value="${category.opt_idx}" />
				            <label for="category_${category.category_idx}">${category.opt_name}</label>
				        </c:if>
				    </c:forEach>
				</fieldset>
            <!--     <h2>메뉴 등록</h2>
                <select name="menu_category" id="category">
                    <option value="food">안주</option>
                    <option value="sul">주류</option>
                </select>
                <input type="text" name="menu_name" value="" placeholder="메뉴 이름"/>
                <input type="text" name="menu_price" value="" placeholder="메뉴 가격"/><span class="price">원</span>
                <input type="file" name="files" multiple="multiple"/>
                <button type="button" id="menu_go">등록</button>
                <div id="menu_list"></div> -->
            </div>
        </div>
        <button type="button" id="save" onclick="save(event)">회원가입</button>
    </form>
</body>
<script>
function save(event){
	var form = new FormData($('#joinForm')[0]);
	$.ajax({
		type:'POST',
		url:'storeJoin.ajax',
		encType:'multipart/form-data',
		processData:false,
		contentType:false, 
		data:form,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.success){
				location.href=data.link
			}else{
				alert(data.message);
			}
		},error:function(e){
			console.log(e);
		}
	});
}
function readFile(input){
	console.log(input.files);
	var reader;
	$('#img_list').empty();
	for (var file of input.files) {
		reader = new FileReader(); 
		reader.readAsDataURL(file); 
		reader.onload = function(e){ 
		$('#img_list').append('<img class="preview" src="'+e.target.result+'"/>');
		}
	}
}
$(document).ready(function() {
    $('#save').click(function(event) {
        save(event); // 여기서 save 함수를 호출
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
                    $('#numberCheckMessage').text("이미 있는 사업자 번호입니다.");
                    $('#numberAvailableMessage').text(""); // 아이디 사용 가능 메시지 초기화
                } else {
                    $('#numberCheckMessage').text(""); // 중복 메시지 초기화
                    $('#numberAvailableMessage').text("사용 가능한 사업자 번호입니다."); // 사용 가능 메시지 출력
                }
            }
        });
    });
});

/* $(document).ready(function() {
    $('#menu_go').click(function() {
        const menuName = $('input[name="menu_name"]').val(); // 메뉴 이름
        const menuPrice = $('input[name="menu_price"]').val(); // 메뉴 가격

        if (menuName && menuPrice) {
            // 메뉴 이름과 가격이 입력되었는지 확인
            $('#menu_list').append('<div>' + menuName + ' - ' + menuPrice + ' 원</div>'); // 입력한 값 추가
            $('#menu_list').children().last().css({
                'color': 'white',
                'background-color': '#e98d1c',
                'padding': '10px',
                'margin': '5px',
                'border-radius': '5px'
            });
            $('input[name="menu_name"]').val(''); // 입력 필드 초기화
            $('input[name="menu_price"]').val(''); // 입력 필드 초기화
        } else {
            alert('메뉴 이름과 가격을 모두 입력해주세요.'); // 필드가 비어 있을 경우 경고
        }
    });
});

$(document).ready(function() {
    $('#menu_go').click(function() {
    	const menuName = $('input[name="menu_name"]').val(); // 메뉴 이름
        const menuPrice = $('input[name="menu_price"]').val(); // 메뉴 가격
        const menuCategory = $('select[name="menu_category"]').val(); // 선택한 카테고리

        if (menuName && menuPrice && menuCategory !== 'select') {
            // 메뉴 이름, 가격, 카테고리가 입력되었는지 확인
            $('#menu_list').append('<div>' + menuCategory + ': ' + menuName + ' - ' + menuPrice + ' 원</div>'); // 입력한 값 추가
            $('input[name="menu_name"]').val(''); // 입력 필드 초기화
            $('input[name="menu_price"]').val(''); // 입력 필드 초기화
            $('select[name="menu_category"]').val('select'); // 카테고리 선택 초기화
        } else {
            alert('메뉴 이름, 가격 및 카테고리를 모두 입력해주세요.'); // 필드가 비어 있을 경우 경고
        }
    });
}); */
/* function getCoordinates() {
    const address = $('#store_address').val();
    const apiKey = 'c27fdf5010600b97cd4cc85f7f6a04f3'; // 실제 API 키로 변경

    // 주소를 JavaScript에서 직접 인코딩
    const encodedAddress = encodeURIComponent(address);
    
    $.ajax({
        type: 'GET',
        url: `https://dapi.kakao.com/v2/local/search/address.json?query=${encodedAddress}`,
        headers: {
            'Authorization': `KakaoAK ${apiKey}`
        },
        success: function(response) {
            if (response.documents.length > 0) {
                const { x, y } = response.documents[0].address;
                $('#latitude').val(y); // 위도
                $('#longitude').val(x); // 경도
            } else {
                alert('주소를 찾을 수 없습니다.');
            }
        },
        error: function(error) {
            console.error(error);
            alert('주소를 가져오는 데 오류가 발생했습니다.');
        }
    });
}
$(document).ready(function() {
    $('#store_address').blur(function() {
        getCoordinates(); // 주소 입력 후 포커스 아웃 시 좌표 가져오기
    });
}); */
</script>
</html>
