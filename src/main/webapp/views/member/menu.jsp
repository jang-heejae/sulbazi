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
        width: 100px;
        height: 30px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 1%;
    }

    button{
        color: #707070;
    }
    h6{
        margin-top: 0px;
        color: white;
    }
    button[id="main"]{
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
</style>
<body>
<form id="menu.go" method="post" enctype="multipart/form-data">
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="#">SULBAZI</a>
            </div>
        </nav>
    </header>
        <div class="container">
            <div class="wrapper">
                <h2>메뉴 등록</h2>
                <select name="menu_category" id="category">
                    <option value="select">카테고리</option>
                    <option value="안주">안주</option>
                    <option value="술">술</option>
                  </select>
                <input type="text" name="menu_name" value="" placeholder="메뉴 이름"/>
                <input type="text" name="menu_price" value="" placeholder="메뉴 가격"/><span class="price">원</span>
                <input type="file" name="file" multiple="multiple"/>
                <button type="button" id="menu_go">등록</button>
                <div id="menulist" style="color:white; margin-top:30px;"> <!-- 메뉴 리스트 표시 영역 -->
			        <h3>메뉴 목록</h3>
			    </div>
            </div>
        </div>
    </form>
    <button type="button" id="main" onclick="location.href='/main.go'">메인 페이지로 돌아가기</button>
</body>
<script>
	$(document).ready(function() {
	    $('#menu_go').click(function() {
	        var formData = new FormData($('#menu.go')[0]); // 올바른 ID 사용
	
	        // 추가적인 데이터 설정
	        var menuName = $('input[name="menu_name"]').val();
	        var menuPrice = $('input[name="menu_price"]').val();
	        var menuCategory = $('#category').val();
	        var storeIdx = ${store_idx}; // JSP에서 store_idx 가져오기
	        console.log("storeIdx from JSP:", storeIdx);
	        
	        // FormData에 추가 데이터 append
	        formData.append('menu_name', menuName);
	        formData.append('menu_price', menuPrice);
	        formData.append('menu_category', menuCategory);
	        formData.append('store_idx', storeIdx);
	        formData.append('file', $('input[name="file"]')[0].files[0]); // 파일 이름 수정
	
	        // AJAX 요청
	        $.ajax({
	            url: 'menu.do', // 요청 URL
	            type: 'POST',
	            data: formData,
	            contentType: false, // multipart/form-data를 전송할 때 필요
	            processData: false, // 데이터를 쿼리 문자열로 변환하지 않도록 설정
	            success: function(response) {
	                if (response.success) {
	                    fetchMenuList(); // 메뉴 목록 업데이트
	                } else {
	                    alert(response.message);
	                }
	            },
	            error: function() {
	                alert('오류가 발생했습니다.');
	            }
	        });
	    });
	    fetchMenuList();
	});
	
	function fetchMenuList() {
	    var storeIdx = ${store_idx};
	    $.ajax({
	        url: 'menulist', // 등록된 메뉴 목록을 가져오는 URL
	        type: 'GET',
	        data: {store_idx : storeIdx},
	        success: function(data) {
	            $('#menulist').empty(); // 이전 목록을 비우기
	            data.menulist.forEach(function(menu) {
	                $('#menulist').append('<div>' + menu.menu_name + ' - ' + menu.menu_price + '원 (' + menu.menu_category + ')</div>');
	            });

	            // 사진 목록 추가
	            data.menuphoto.forEach(function(photo) {
	            	$('#menulist').append('<div><img src="/photo/' + photo.new_filename + '" alt="사진" style="width:100px; height:auto;" /></div>');
	            });
	        },
	        error: function() {
	            alert('메뉴 목록을 가져오는 데 오류가 발생했습니다.');
	        }
	    });
	}
</script>
</html>
