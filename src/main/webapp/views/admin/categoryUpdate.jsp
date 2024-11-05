<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		color: #041d03;
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
   	    flex-direction: column;
    	font-family: "Yeon Sung", system-ui;
    	font-weight: normal;
    	border: 2px solid rgb(255, 140, 9);
	}
	button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	#category{
		position: absolute;
		width: 880px;
		top: 240px;
		left: 520px;
	}
	#categoryInsert{
		position: absolute;
		background-color: #73734F;
		border: 2px solid rgb(255, 140, 9);
		border-radius: 20px;
		width: 350px;
        height: 500px;
		top: 130px;
    	left: 5px;
	}
	#categoryDel{
		position: absolute;
		background-color: #73734F;
		border: 2px solid rgb(255, 140, 9);
		border-radius: 20px;
		width: 350px;
        height: 500px;
		top: 131px;
    	left: 521px
	}
	.cateDell{
        left: 141px;
    	position: absolute;
    	top: -46px;
	}
	#liveee{
		margin-left: 40px;
		left: 121px;
    	position: absolute;
    	top: 86px;
	}
	#btn{
		position: absolute;
		top: 311px;
    	left: 401px;
		display: flex;
   		flex-direction: column;
    	flex-wrap: nowrap;
    	align-items: stretch;
	}
	#optDrink{
		position: absolute;
		padding: 10px;
		top: 10px;
	}
	#optMenu{
		position: absolute;
		padding: 10px;
		top: 120px;
	}
	#optMood{
		position: absolute;
		padding: 10px;
		top: 230px;
	}
	#optVisit{
		position: absolute;
		padding: 10px;
		top: 350px;
	}
	#optDrinkDel{
		position: absolute;
		padding: 10px;
		top: 10px;
		width: 330px;
	}
	#optMenuDel{
		position: absolute;
		padding: 10px;
		top: 120px;
		width: 330px;
	}
	#optMoodDel{
		position: absolute;
		padding: 10px;
		top: 230px;
		width: 330px;
	}
	#optVisitDel{
		position: absolute;
		padding: 10px;
		top: 350px;
		width: 330px;
	}
	input[type="radio"] {
        appearance: none; /* 기본 스타일 제거 */
        width: 15px;
        height: 15px;
        background-color: #73734F; /* 원하는 배경색 */
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
    hr{
    	border: none;
    	height: 2px;
   		background-color: rgb(255, 140, 9);
    }
.modal_madal {
    display: none; /* 초기 상태에서 숨김 */
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 530px;
    height: 231px; /* 모달 높이 설정 */
    background-color: #041d03;
    padding: 20px;
    border: 1px solid #888;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
    color: #041d03;
    text-align: center;
    font-family: "Yeon Sung", system-ui;
    overflow: auto; /* 내용이 넘칠 때 스크롤 */
}

.modal-content_madal {
    padding: 20px;
    text-align: center;
    color: #041d03;
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
<jsp:include page="../main/adminMain.jsp"/>
		<section class="chatBox2">
        	<div class="chatitems2">
				<div id="category">
				<span style="margin-top: 39px; font-size:36px;">카테고리</span>
				<hr/>
					<div class="cateInsert">
					<div id="liveee"><h1>활성화</h1></div>
					<div id="categoryInsert">
						<br/>
					<div id="optDrink">
						<h2>&nbsp;&nbsp;&nbsp;주종</h2>
						<hr/>
						<br/>
						<div id="cateOptDrink">
					</div>
			</div>
			<div id="optMenu">
				<h2>&nbsp;&nbsp;&nbsp;안주</h2>
				<hr/>
				<br/>
				<div id="cateOptMenu">
				</div>
			</div>
			<div id="optMood">
				<h2>&nbsp;&nbsp;&nbsp;분위기</h2>
				<hr/>
				<br/>
				<div id="cateOptMood">
				</div>
			</div>
			<div id="optVisit">
				<h2>&nbsp;&nbsp;&nbsp;방문목적</h2>
				<hr/>
				<br/>
				<div id="cateOptVisit">
				</div>
			</div>
			</div>
		</div>
		<div id="btn">
			<button>활성화</button>
			<br/>
			<button>비활성화</button>
			<br/>
			<button onclick="openModal(); return false;">카테고리 추가</button>
		</div>
		<div id="categoryDel">
		<div class="cateDell"><h1>비활성화</h1></div>
		<div id="optDrinkDel">
				<h2>&nbsp;&nbsp;&nbsp;주종</h2>
				<hr/>
				<br/>
					<div id="cateOptDrinkDel">
					</div>
			</div>
			<div id="optMenuDel">
				<h2>&nbsp;&nbsp;&nbsp;안주</h2>
				<hr/>
				<br/>
				<div id="cateOptMenuDel">
				</div>
			</div>
			<div id="optMoodDel">
				<h2>&nbsp;&nbsp;&nbsp;분위기</h2>
				<hr/>
				<br/>
				<div id="cateOptMoodDel">
				</div>
			</div>
			<div id="optVisitDel">
				<h2>&nbsp;&nbsp;&nbsp;방문목적</h2>
				<hr/>
				<br/>
				<div id="cateOptVisitDel">
				</div>
			</div>
		</div>
	</div>
	</div>
	</section>
</body>
<div id="adminModal" class="modal_madal" style="display:none;">
    <div class="modal-content_madal">
        <span class="close_madal" onclick="closeModal()">&times;</span>
        <!-- JSP 내용을 불러올 위치 -->
        <div id="modalContent"></div>
    </div>
</div>
<script>
optListCall();
function optListCall(){
	$.ajax({
		type:'GET',
		url:'categoryList.ajax',
		data:{},
		dataType:'JSON',
		success:function(data){
			optList(data.list);
		},
		error:function(e){
			console.log(e);
		}
	});
}
function optList(list){
	var contentDrink = '';
    var contentMenu = '';
    var contentMood = '';
    var contentVisit = '';
    var contentDrinkDel = '';
    var contentMenuDel = '';
    var contentMoodDel = '';
    var contentVisitDel = '';
	for (var item of list) {
		var option = '<input type="radio" name="category" value="'+item.opt_name+'"/>&nbsp;'+item.opt_name+'&nbsp;&nbsp;&nbsp;';
		if(item.category_idx == '1' && item.category_state == 1){
			contentDrink += option;
		}else if(item.category_idx == '2' && item.category_state == 1){
			contentMenu += option;
		}else if(item.category_idx == '3' && item.category_state == 1){
			contentMood += option;
		}else if(item.category_idx == '4' && item.category_state == 1){
			contentVisit += option;
		}else if(item.category_idx == '1' && item.category_state == 0){
			contentDrinkDel += option;
		}else if(item.category_idx == '2' && item.category_state == 0){
			contentMenuDel += option;
		}else if(item.category_idx == '3' && item.category_state == 0){
			contentMoodDel += option;
		}else if(item.category_idx == '4' && item.category_state == 0){
			contentVisitDel += option;
		}
	}
		$('#cateOptDrink').html(contentDrink);
		$('#cateOptMenu').html(contentMenu);
		$('#cateOptMood').html(contentMood);
		$('#cateOptVisit').html(contentVisit);
		$('#cateOptDrinkDel').html(contentDrinkDel);
		$('#cateOptMenuDel').html(contentMenuDel);
		$('#cateOptMoodDel').html(contentMoodDel);
		$('#cateOptVisitDel').html(contentVisitDel);
}
$(document).ready(function(){
	$('#btn button').eq(0).on('click', function(){
		var selCate = $('input[name="category"]:checked').val();
		if(selCate){
			upCate(selCate, 1);
		}else{
			alert('카테고리를 선택하세요.');
		}
	});
	$('#btn button').eq(1).on('click', function(){
		var selCate = $('input[name="category"]:checked').val();
		if(selCate){
			upCate(selCate, 0);
		}else{
			alert('카테고리를 선택하세요.');
		}
	});
	function upCate(cateName, state){
		$.ajax({
			type: 'POST',
			url: 'categoryState.ajax',
			data:{category: cateName, state: state},
			dataType:'JSON',
			success: function(data){
				if(data.success){
					if(state == 1){
						moveCategory(cateName);
					}else{
						moveCategory(cateName);
					}
				}
				location.reload();
			},
			error: function(e){
				console.log(e);
			}
		});
		function moveCategory(cateName){
			$('#cateOptDrinkDel, #cateOptMenuDel, #cateOptMoodDel, #cateOptVisitDel')
			.find('input[value="${cateName}"]').parent().remove();
			$('#cateOptDrink, #cateOptMenu, #cateOptMood, #cateOptVisit')
			.append('<input type="radio" name="category" value="${cateName}"/> ${cateName}&nbsp;&nbsp;&nbsp;');
		}
		function moveCategory(cateName){
			$('#cateOptDrink, #cateOptMenu, #cateOptMood #cateOptVisit')
			.find('input[value="${cateName}"]').parent().remove();
			$('#cateOptDrinkDel, #cateOptMenuDel, #cateOptMoodDel, #cateOptVisitDel')
			.append('<input type="radio" name="category" value="${cateName}"/> ${cateName}&nbsp;&nbsp;&nbsp;');
		}
	}
});

function openModal() {
    $.ajax({
        url: "categoryAdd.go", // 불러올 JSP 파일 경로
        method: "GET",
        success: function(data) {
            // 불러온 JSP 내용을 모달에 삽입
            $('#modalContent').html(data);
            $('#adminModal').css('display', 'block');
        },
        error: function() {
            alert("모달 내용을 불러오는 데 실패했습니다.");
        }
    });
}
$('#closeModal').off('click').on('click', function() {
    $('#adminModal').css('display', 'none'); // 모달 숨기기
    window.location.reload();
});
function closeModal() {
    $('#adminModal').css('display', 'none');
    window.location.reload();
}
</script>
</html>