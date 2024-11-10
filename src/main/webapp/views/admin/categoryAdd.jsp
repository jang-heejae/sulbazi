<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	body{
		color:#20290E;
		font-weight: normal;
		background-color: #20290E;
		overflow: hidden; 
		font-family: "Yeon Sung", system-ui;
	} 
	#newCate{
		background-color: #73734F;
		border-radius: 10px;
		position: absolute;
		top: 27px;
    	left: 116px;
    	display: flex;
    	flex-direction: column;
	} 
	table, th, td{
		border-bottom: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		padding: 10px;
	}
	#opt_bar{
		width: 100%;
	}
	input{
		margin-left: 2px;
    	width: 224px;
    	padding: 8px;
    	margin-bottom: 5px;
    	border-radius: 10px;
    	border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid #041d03;
		background-color: white;
		color:#041d03;
		font-family: "Yeon Sung", system-ui;
	}
	#opt_bar{
		border-radius: 10px;
		padding: 4px;
		width: 100%;
		font-family: "Yeon Sung", system-ui;
	}
	.acp{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	option{
		font-family: "Yeon Sung", system-ui;
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

.modal-content_madal3 {
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
	<form action="categoryAdd.do" method="post" onsubmit="refresh();">
	<div id="newCate">
	<table>
		<tr>
			<th colspan="2">카테고리 추가</th>
		</tr>
		<tr>
			<th>카테고리 분류</th>
			<td>
				<select id="opt_bar" name="cate_opt">
					<option value="drink">주종</option>
					<option value="menu">안주</option>
					<option value="mood">분위기</option>
					<option value="visit">방문목적</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>카테고리 옵션</th>
			<td><input type="text" name="keyword" id="new_categoryOpt" value=""/></td>
		</tr>
	</table>
		<button type="button" id="acps" class="acp">카테고리 추가</button>
		<button type="button" class="acp" onclick="closeModal2()">닫기</button>
	</div>
	</form>
</body>
<div id="confirmationModal2" class="modal_madal2">
    <div class="modal-content_madal3">
        <span class="close_modal2" id="closeModal2">&times;</span>
        <p id="confirmationMessage2"></p>
        <button type="button" class="btn_madal2" id="confirmAction2">확인</button>
        <button type="button" class="btn_madal2" id="cancelAction2">취소</button>
    </div>
</div>
<script>
$(document).ready(function() {
    // 모달을 표시하는 이벤트 등록
    $('#acps').on('click', function() {
        $('#confirmationMessage2').text('추가하시겠습니까?');
        $('#confirmationModal2').css('display', 'block'); // 모달을 보이도록 설정
    });

    // 확인 버튼 클릭 시 폼 제출
    $('#confirmAction2').off('click').on('click', function() {
        // 모달 숨기기
        $('#confirmationModal2').css('display', 'none');

         // 폼을 제출하고, 부모 창을 새로고침한 후 현재 창 닫기
        $('form')[0].submit(); // 폼 제출

        window.opener.location.reload();
 
    });

    // 취소 버튼 클릭 시 모달 닫기
    $('#cancelAction2, #closeModal2').off('click').on('click', function() {
        $('#confirmationModal2').css('display', 'none'); // 모달 숨기기
    });
});
function closeModal2() {     // adminAdd 영역 숨기기
    $('#adminModal').css('display', 'none'); // 확인 모달도 함께 숨기기
}
</script>
</html>