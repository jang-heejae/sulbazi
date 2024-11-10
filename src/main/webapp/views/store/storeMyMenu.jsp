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
    margin-top:10;
    border:1px solid #73734;
}

#menufiltering{
	margin-bottom:3;
}
input{
    margin-left: 10;
    margin: 0;
    padding:3;    
}
table{ 
    margin: auto;
	padding:50;
    margin-right:auto;
}
table,th, td{
    border: 1px solid #73734F;
    border-collapse: collapse;
}
td{
	max-width:100;
	height: 20;
	border-top: 1px solid #73734F; /* 위쪽 경계선 */
    border-bottom: 2px solid white; /* 아래쪽 경계선 */
    border-left: none; /* 왼쪽 경계선 제거 */
    border-right: none; /* 오른쪽 경계선 제거 */
    padding: 5px 5px; /* 여백 조정 */
}
th{
    background-color: #73734F;
    padding:0 23;
}
label{
    height:30;
    width: 100;
    font-size: 16;
}
label.selected{
    background-color: rgb(255, 140, 9);
}

.insert{
	background-color: #979767;
	width: 300;
	margin: 61 auto;
	border-radius: 10px;
	padding: 40;
	margin-right: 0;
	margin-left: 40;
	margin-top: 50;
}

.all{
	display:flex;
	width: 970;
	margin:200 auto;
	background-color:#73734F;
	height: 600;
	border-radius: 10px;
}

.table{
	background-color: #73734F;
	border:solid 1px #73734F;
	color: white;
	width: 520;
	height: 500;
	overflow-y: scroll;

}

.table::-webkit-scrollbar { 
    display: none;
}
.menuinsert{
	padding: 10;
	height: 400;
	width:300;
}

fieldset{
	display:flex;
	padding:10;
	border: #73734F;
	margin: auto;
}

input[type="text"] {
	width: 100;
	height: 30;
	border-radius:5px;
}

input[type="radio"] {
	width: 20;
	height: 20;
}
 td[type="button"] {
 	width:40;

 }
button[type="submit"]{
	margin: auto;
}
.menuappear{
	margin-right:10;
}

#preview {
	margin-top: 1px;
	max-width: 65%; /* 최대 너비 설정 */
	height: auto; /* 높이는 자동 조정 */
}

button.up{
	background-color: #73734F; /* 배경색 */
	color: white; /* 글자색 */
	border: none; /* 테두리 없애기 */
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer; /* 마우스 커서 변경 */
	font-size: 16px; /* 글자 크기 */
}

button.del{
	background-color: #73734F; /* 배경색 */
	color: red; /* 글자색 */
	border: none; /* 테두리 없애기 */
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer; /* 마우스 커서 변경 */
	font-size: 16px; /* 글자 크기 */
}
fieldset label {
    margin-right: 10px; /* 라디오 버튼과 텍스트 사이의 간격을 설정 */
    display: inline-block; /* 라벨을 인라인으로 표시 */
    width: 60px;
}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"></jsp:include>
<div class="all">
	<div class="insert">
		<form action="menuInsert.do" method="post" enctype="multipart/form-data"> 
		    <table class="menuinsert">
		        <tr>
		            <th>메뉴 추가하기</th>
		        </tr>
		        <tr>
		            <td>사진 추가<input type="file" name="files" multiple="multiple" id="imageInput" accept="image/*"/>
		            <div id="previewContainer"></div></td>
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
	</div>
	<div class="menuappear">
		<form>
			<div class="stateselect">
				<fieldset>
			    <label>
			        <input type="radio" name="menu_category" value="안주" checked/> 안주
			    </label>
			    <label>
			        <input type="radio" name="menu_category" value="주류"/> 주류
			    </label>
				</fieldset>
			</div>
		</form>
		<div class="table">
			<table>
				<thead>
					<tr>
						<th>메뉴 사진</th>
						<th>메뉴 이름</th>
						<th rowspan="3">가격</th>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
<script>

/* var menu_category = $(':input:radio[name=menu_category]:checked').val();

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
}	 */	

//메뉴 등록
document.querySelector('button[type="submit"]').addEventListener('click', function(event) {
    // 필수 필드 요소들
    var imageInput = document.querySelector('input[name="files"]');
    var categorySelect = document.querySelector('select[name="menu_category"]');
    var menuName = document.querySelector('input[name="menu_name"]');
    var menuPrice = document.querySelector('input[name="menu_price"]');

    // 필드 유효성 검사
    if (!imageInput.files.length || !categorySelect.value || !menuName.value || !menuPrice.value) {
        alert('모든 항목을 채워주세요.');
        event.preventDefault(); // 제출 방지
        return;
    }

    var result = confirm('등록하시겠습니까?');
    if (!result) {
        event.preventDefault(); // 제출 방지
    } else {
        event.preventDefault(); // 기본 제출 방지

        // 폼 데이터를 수집
        var formData = new FormData(document.querySelector('form'));

        // AJAX 요청
        $.ajax({
            type: 'POST',
            url: 'menuInsert.ajax',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                alert('등록되었습니다');
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.error('AJAX 오류:', error);
                alert('등록 중 오류가 발생했습니다.');
            }
        });
    }
});


$(document).ready(function() {
    // 기본 체크된 메뉴 카테고리에 따라 AJAX 요청 실행
    var menu_category = $(':input:radio[name=menu_category]:checked').val();
    executeFiltering(menu_category); // 페이지 로드 시 자동 실행

    // 라디오 버튼 변경 시 AJAX 요청 실행
    $(':input:radio[name=menu_category]').change(function() {
        var menu_category = $(this).val(); // 변경된 카테고리 값 가져오기
        executeFiltering(menu_category); // 필터링 실행
    });
});

// 선택된 카테고리에 맞는 필터링 함수
function executeFiltering(menu_category) {
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
}	
	
/* 
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
});  */
	
function drawList(menuphoto, menulist) {
    if (!Array.isArray(menuphoto) || !Array.isArray(menulist)) {
        console.error('Provided parameters are not arrays:', menuphoto, menulist);
        return;
    }

    var content = '';
    
    // menulist의 길이를 기준으로 loop
    menulist.forEach(function(item, idx) {
        content += '<tr>';
        
        // menuphoto가 없으면 "사진 없음" 텍스트를 표시
        var photo = (menuphoto[idx] && menuphoto[idx].new_filename) ? 'photo/' + menuphoto[idx].new_filename : '사진 없음';
        
        content += '<td>';
        if (photo === '사진 없음') {
            content += '<span>' + photo + '</span>'; // 사진이 없으면 텍스트로 "사진 없음" 표시
        } else {
            content += '<img src="' + photo + '" width="100" height="100">';
        }
        content += '</td>';

        // 메뉴 이름, 가격, 수정, 삭제 버튼은 계속 표시
        content += '<td><input type="text" id="menu_name_' + item.menu_idx + '" value="' + item.menu_name + '"/></td>';
        content += '<td><input type="text" id="menu_price_' + item.menu_idx + '" value="' + item.menu_price + '"/></td>';
        content += '<td><button type="button" class="up" onclick="menuUpdate('+item.menu_idx+')">수정</button></td>';
        content += '<td><button type="button" class="del" onclick="menuDelete('+item.menu_idx+')">삭제</button></td>';
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
		var menu_category = $(':input:radio[name=menu_category]:checked').val();
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

	
    document.getElementById('imageInput').addEventListener('change', function(event) {
        const files = event.target.files; // 선택된 파일들
        const previewContainer = document.getElementById('previewContainer');
        previewContainer.innerHTML = ''; // 기존 미리보기 내용 초기화

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function(e) {
                // 새 이미지를 생성하고 미리보기 컨테이너에 추가
                const img = document.createElement('img');
                img.src = e.target.result;
                img.id = 'preview';
                img.style.marginRight = '10px'; // 이미지 사이 간격
                previewContainer.appendChild(img);
            }

            // 파일 읽기 시작
            reader.readAsDataURL(file);
        }
    });
</script>
</html>