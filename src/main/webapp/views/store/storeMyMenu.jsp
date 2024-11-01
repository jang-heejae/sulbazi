<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.stateselect{
    display: flex;
    margin-bottom:0;
}
input{
    margin-left: 10;
    margin: 0;
}
table{ 
    margin: auto;
    margin-left:auto; 
    margin-right:auto;
}
table,th, td{
    border: 1px solid rgb(255, 140, 9);
    border-collapse: collapse;
}
th{
    background-color: rgb(255, 140, 9);
}
label{
    height:30;
    width: 100;
    font-size: 16;
}
label.selected{
    background-color: rgb(255, 140, 9);
}
img {
	width: 100;
	height: 100;
}
</style>
</head>
<body>
<form action="menuInsert.do" method="post" enctype="multipart/form-data"> 
    <table>
        <tr>
            <th>메뉴 추가하기</th>
        </tr>
        <tr>
            <td>사진 추가<input type="file" name="files" multiple="multiple"/></td>
        </tr>
        <tr>
            <td>
                <select class="search-select" id="searchCategory" name="menu_category">
                    <option value="안주">안주</option>
                    <option value="술">주류</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>메뉴 이름 : <input type="text" name="menu_name"></td>
        </tr>
        <tr>
            <td>메뉴 가격 : <input type="text" name="menu_price"></td>
        </tr>
        <tr>
            <td><button type="submit">메뉴 등록</button></td>
        </tr>
    </table>
</form>
    <form>
        <div class="stateselect">
              <fieldset>
                  <input type="radio" name="menu_category" value="안주" checked/> 안주 <br/>
                  <input type="radio" name="menu_category" value="주류"/> 주류<br/>
              </fieldset>
              <button type ="button" id="menufiltering">필터 적용</button>
          </div>
    </form>
    <table>
       <thead>
          <tr>
             <th>메뉴 사진</th>
             <th>메뉴 이름</th>
             <th rowspan="2">가격</th>
          </tr>
       </thead>
	   <tbody id="list">
	   
	   </tbody>
    </table>
</body>
<script>
var menu_category = $(':input:radio[name=menu_category]:checked').val();
menulist();
function menulist() {
	$.ajax({
	    type: 'GET',
	    url: 'menuFiltering.ajax',
	    data: { 'menu_category': menu_category },
	    dataType: 'JSON',
	    success: function(data) {
	        console.log(data);
	        if (data && Array.isArray(data.menulist) && Array.isArray(data.menuphoto)) {
	            drawList(data.menuphoto, data.menulist);
	        } else {
	            console.error('Unexpected response format:', data);
	        }
	    },
	    error: function(e) {
	        console.log(e);
	    }
	});
}		
//메뉴 등록
document.querySelector('button[type="submit"]').addEventListener('click', function(event) {
    var result = confirm('등록하시겠습니까?');
    if (!result) {
        event.preventDefault();
    } else {
        alert('등록되었습니다');
    }
});
	
	
	/* 메뉴 필터링*/
$(document).ready(function() {
    $('#menufiltering').click(function(event) {
        event.preventDefault(); // 기본 제출 방지

        var menu_category = $(':input:radio[name=menu_category]:checked').val();
        console.log("Selected category: " + menu_category); // 선택된 값을 확인

        if (menu_category === "안주") {
            // 안주일 경우 ajax1 실행
            $.ajax({
                type: 'GET',
                url: 'menuFiltering.ajax',
                data: { 'menu_category': menu_category },
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    if (data && Array.isArray(data.menulist) && Array.isArray(data.menuphoto)) {
                        drawList(data.menuphoto, data.menulist);
                    } else {
                        console.error('Unexpected response format:', data);
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        } else if (menu_category === "주류") {
            // 주류일 경우 ajax2 실행
            $.ajax({
                type: 'GET',
                url: 'alcholmenuFiltering.ajax',
                data: { 'menu_category': menu_category },
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    if (data && Array.isArray(data.menulist) && Array.isArray(data.menuphoto)) {
                        drawList(data.menuphoto, data.menulist);
                    } else {
                        console.error('Unexpected response format:', data);
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
    }); // click 이벤트 끝
}); 
	
	function drawList(menuphoto, menulist) {
	    if (!Array.isArray(menuphoto) || !Array.isArray(menulist)) {
	        console.error('Provided parameters are not arrays:', menuphoto, menulist);
	        return;
	    }
	
	    if (menuphoto.length !== menulist.length) {
	        console.error('The lists do not have the same length:', menuphoto.length, menulist.length);
	        return;
	    }
	
	    var content = '';
	    menulist.forEach(function(item, idx) {
	        content += '<tr>';
	        content += '<td><img src="/photo/' + menuphoto[idx].new_filename + '" width="100" height="100"></td>';
	        content += '<td><input type="text" id="menu_name_' + item.menu_idx + '" value="' + item.menu_name + '"/></td>'; // 고유 ID 추가
	        content += '<td><input type="text" id="menu_price_' + item.menu_idx + '" value="' + item.menu_price + '"/></td>';
	        content += '<td><button type="button" onclick="menuUpdate('+item.menu_idx+')">수정</button></td>';
	        content += '<td><button type="button" onclick="menuDelete('+item.menu_idx+')">삭제</button></td>';
	        content += '</tr>';
	    });
	
	    $('#list').html(content);
	}
	
	function menuUpdate(menu_idx) {
	    // 입력 필드에서 값을 가져옵니다.
	    var menu_name = document.getElementById('menu_name_' + menu_idx).value;
	    var menu_price = document.getElementById('menu_price_' + menu_idx).value;

	    console.log(menu_name);
	    console.log(menu_price);
	    // AJAX 요청
	    $.ajax({
	        type: 'POST',
	        url: 'menuUpdate.ajax', // 서버의 URL
	        data: {
	            'menu_idx': menu_idx,
	            'menu_name': menu_name,
	            'menu_price': menu_price
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            if (response.success) {
	                alert('메뉴가 성공적으로 수정되었습니다!');
	                location.reload(); // 페이지 새로 고침
	            } else {
	                alert('메뉴 수정에 실패했습니다: ' + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 오류:', error);
	            alert('메뉴 수정 중 오류가 발생했습니다.');
	        }
	    });
	}
	
	
	function menuDelete(menu_idx) {

		console.log(menu_category);
	    // AJAX 요청
	    $.ajax({
	        type: 'POST',
	        url: 'menuDelete.ajax', // 서버의 URL
	        data: {'menu_idx': menu_idx,
	        		'menu_category':menu_category},
	        dataType: 'JSON',
	        success: function(response) {
	            if (response.success) {
	                alert('메뉴가 성공적으로 삭제되었습니다!');
	                location.reload(); // 페이지 새로 고침
	            } else {
	                alert('메뉴 삭제에 실패했습니다: ' + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 오류:', error);
	            alert('메뉴 삭제 중 오류가 발생했습니다.');
	        }
	    });
	}
</script>
</html>