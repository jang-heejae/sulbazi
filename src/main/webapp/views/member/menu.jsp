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
    .table{
    	margin-left: 28%;
    	
    }
    table, th, td{
    	color: white;
    	text-align: center;
		padding: 1%;
		width: 400px;
    }
    table{
    	width: 120%;
    	margin-left: -147px;
    }
</style>
<body>
<form id="menu.go" method="post" enctype="multipart/form-data">
    <header>
        <nav class="navbar">
            <div class="logo_text">
                <a href="./mainPage.go">SULBAZI</a>
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
                <input type="file" name="file" multiple="multiple" id="menuImage"/>
                <button type="button" id="menu_go">등록</button>
                <div class="table"> <!-- 메뉴 리스트 표시 영역 -->
			        <table>
			        	<thead>
			        		<tr>
			        			<th>카테고리</th>
			        			<th>메뉴 사진</th>
			        			<th>메뉴 이름</th>
			        			<th rowspan="4">가격</th>
			        		</tr>
			        	</thead>
			        	<tbody id="list">
			        	</tbody>
			        </table>
			    </div>
            </div>
        </div>
    </form>
    <button type="button" id="main" onclick="checkMenuBeforeSignup(); return false;">회원 가입</button>
</body>
<script>
function checkMenuBeforeSignup() {
    if ($('#list').children().length === 0) {
        alert("메뉴 등록은 필수입니다.");
    } else {
    	alert("회원가입에 성공하였습니다.");
        location.href = './login.go';
    }
}
$(document).ready(function() {
    $('#menu_go').click(function() {
        var menuImage = $('#menuImage')[0].files.length;
        if (menuImage === 0) {
            alert("사진을 넣어주세요.");
            return; // 사진이 없으면 실행 멈춤
        }
        var formData = new FormData($('#menu.go')[0]);

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
        formData.append('file', $('input[name="file"]')[0].files[0]);

        // AJAX 요청
        $.ajax({
            url: 'menu.ajax', // 요청 URL
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
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

    // 초기 메뉴 리스트 로드
    fetchMenuList();

    // 카테고리가 변경될 때마다 메뉴 리스트 업데이트
    $('#category').on('change', function() {
        fetchMenuList();
    });
});

function fetchMenuList() {
    var storeIdx = ${store_idx}; // JSP에서 store_idx 가져오기
    var menuCategory = $('#category').val();

    $.ajax({
        url: 'menulist.ajax', // 등록된 메뉴 목록을 가져오는 URL
        type: 'GET',
        data: {
            store_idx: storeIdx,
            menu_category: menuCategory
        },
        dataType:'JSON',
        success: function(data) {
        	listPrint(data.storeM, data.storeMP, data.storeD, data.storeDP);
        },
        error: function(e) {
			console.error(e);
		}
    });
}
function listPrint(storeM, storeMP, storeD, storeDP) {
    var content = '';
    var combinedList = storeM.concat(storeD);

    combinedList.forEach(function(item) {
        // 현재 항목이 주류인지 확인
        var isAlcohol = storeD.includes(item);
        var photo; // 사진 객체
        var category; // 카테고리 설정

        if (isAlcohol) {
            photo = storeDP[item.menu_idx]; 
            category = "주류";
        } else {
            photo = storeMP[item.menu_idx]; 
            category = "안주";
        }

        content += '<tr>';
        content += '<td>' + category + '</td>'; 
        content += '<td>';
        if (photo && photo.new_filename) {
            content += '<img src="photo/' + photo.new_filename + '" alt="Menu Photo" style="width:50px; height:50px; border-radius: 8px; display: inline;">';
        } else {
            content += '<span>사진 없음</span>';
        }

        content += '</td>';
        content += '<td><input type="text" name="menu_name" value="' + item.menu_name + '" style="width:100px;" readonly/></td>';
        content += '<td><input type="text" name="menu_price" value="' + item.menu_price + '" style="width:100px;" readonly/></td>';
        content += '</tr>';
    });

    $('#list').html(content);
}
</script>
</html>
