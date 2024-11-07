<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	body{
		color: #20290E;
    	font-weight: normal;
		background-color: #20290E;
		overflow: hidden; 
		font-family: "Yeon Sung", system-ui;
	} 
	#newPW{
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

	.change, .closeChange{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
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
	.modal_madal4 {
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

.modal-content_madal4 {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

.btn_madal4 {
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

.btn_madal4:hover {
    background-color: #20290E;
    color: white;
}

.close_madal4 {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close_madal4:hover,
.close_madal4:focus {
    color: black;
}
</style>
<body>
	<form action="adminUpdate.do">
	<div id="newPW">
	<table>
		<thead>
		<tr>
			<th colspan="2">관리자 비빌번호 변경</th>
		</tr>
		<tr>
			<th>관리자 아이디</th>
			<td><input type="text" name="admin_id" value="${info.admin_id}" readonly="readonly"/></td>
		</tr>
		<tr>
			<th>새로운 비밀번호</th>
			<td><input type="password" id="new_password" value=""/></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" id="new_passwordOk" value=""/></td>
		</tr>
		<tr>
			<th id="message" colspan="2"></th>
		</tr>
		</thead>
	</table>
		<button type="button" id="change" class="change">비밀번호 변경</button>
		<button type="button" id="closeChange" class="closeChange" onclick="closeModal2()">닫기</button>
		</div>
	</form>
</body>
<div id="confirmationModal4" class="modal_madal4">
    <div class="modal-content_madal4">
        <span class="close_modal4" id="closeModal4">&times;</span>
        <p id="confirmationMessage4"></p>
        <button type="button" class="btn_madal4" id="confirmAction4">확인</button>
        <button type="button" class="btn_madal4" id="cancelAction4">취소</button>
    </div>
</div>
<script>
$(document).ready(function() {
    // 실시간으로 비밀번호 일치 여부 확인
    $('#new_password, #new_passwordOk').on('keyup', function() {
        var new_pw = $('#new_password').val();
        var confirm_pw = $('#new_passwordOk').val();

        if (new_pw === confirm_pw) {
            $('#message').text("비밀번호가 일치합니다.").css({'color':'#041d03'});
        } else {
            $('#message').text("비밀번호가 일치하지 않습니다.").css({'color':'rgb(255, 140, 9)'});
        }
    });

    // 비밀번호 변경 확인 모달 열기
    $('#change').on('click', function() {
        $('#confirmationMessage4').text('수정하시겠습니까?');
        $('#confirmationModal4').css('display', 'block'); // 확인 모달을 보이도록 설정
    });

    // 확인 버튼 클릭 시 비밀번호가 일치할 때만 adminChanPw 함수 실행
    $('#confirmAction4').on('click', function() {
        // 모달 숨기기
        $('#confirmationModal4').css('display', 'none');
        
        var new_pw = $('#new_password').val();
        var confirm_pw = $('#new_passwordOk').val();

        // 비밀번호가 일치하는 경우에만 AJAX 요청 실행
        if (new_pw === confirm_pw) {
            adminChanPw(); // AJAX 요청 실행
        } else {
            alert("비밀번호가 일치하지 않습니다."); // 일치하지 않으면 경고
        }
    });

    // 취소 버튼 클릭 시 모달 닫기
    $('#cancelAction4, #closeModal4').on('click', function() {
        $('#confirmationModal4').css('display', 'none'); // 모달 숨기기
    });
});
function closeModal2() {     // adminAdd 영역 숨기기
    $('#adminModal').css('display', 'none'); // 확인 모달도 함께 숨기기
    window.location.reload();
}
// 비밀번호 변경 AJAX 요청 함수
function adminChanPw(){
    var new_pw = $('#new_password').val();

    var param = {admin_id:'${info.admin_id}', new_password:new_pw};

    $.ajax({
        type: 'POST',
        url: 'adminUpdate.ajax',
        data: param,
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if(data.success){
                window.location.reload(); // 수정 후 페이지 새로고침
            }
        },
        error: function(e) {
            console.log(e);
        }
    }); 
}
</script>
</html>