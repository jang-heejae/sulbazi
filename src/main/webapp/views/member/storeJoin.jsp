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
    button[type="button"]{
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
                <input type="text" name="store_number" value="" placeholder="사업자 번호(필수)"/>&nbsp;<button>중복확인</button>
                <input type="text" name="store_name" value="" placeholder="매장 이름(필수)">
                <input type="text" name="store_phone" value="" placeholder="매장 전화번호(선택사항)">
                <input type="text" name="store_address" value="" placeholder="매장 주소(필수)">
                <textarea name="store_time" placeholder="ex) 운영 시간                                                      월요일 15:00 ~ 02:00                                    화요일 휴무                                             수요일 15:00 ~ 02:00"></textarea>
                <h2>대표 사진</h2>
                <input type="file" name="files" value="1" multiple="multiple" onchange="readFile(this)"/>
                <div id="img_list"></div>
                <h6>※ 대표메뉴는 필수 등록입니다. 최대 1개</h6>
                <h2>가게 내, 외부사진</h2>
                <!-- <input type="file" name="fileone" multiple="multiple">-->
                <h6>※파일은 5MB 이하, 최대 5개까지 가능합니다.</h6>
                <h2>카테고리(각 1개 선택가능(필수))</h2>
                <h3>안주</h3>
                <input type="radio" name="food" value="한식">한식
                <input type="radio" name="food" value="양식">양식
                <input type="radio" name="food" value="중식">중식
                <input type="radio" name="food" value="일식">일식
                <h3>분위기</h3>
                <input type="radio" name="mood" value="조용한">조용한
                <input type="radio" name="mood" value="시끌벅적">시끌벅적
                <input type="radio" name="mood" value="이색적인">이색적인
                <input type="radio" name="mood" value="고급스러운">고급스러운
                <input type="radio" name="mood" value="가성비">가성비 좋은
                <input type="radio" name="mood" value="기타">기타
                <h3>주종</h3>
                <input type="radio" name="sul" value="소주">소주
                <input type="radio" name="sul" value="맥주">맥주
                <input type="radio" name="sul" value="양주">양주
                <input type="radio" name="sul" value="막걸리">막걸리
                <input type="radio" name="sul" value="와인">와인
                <input type="radio" name="sul" value="하이볼">하이볼
                <input type="radio" name="sul" value="기타">기타
                <h3>방문목적</h3>
                <input type="radio" name="why" value="혼술">혼술
                <input type="radio" name="why" value="회식">회식
                <input type="radio" name="why" value="데이트">데이트
                <input type="radio" name="why" value="모임">모임
                <input type="radio" name="why" value="기타">기타
                <br><br><br>
            </div>
        </div>
        <button type="button" onclick="save(event)">회원가입</button>
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
</script>
</html>
