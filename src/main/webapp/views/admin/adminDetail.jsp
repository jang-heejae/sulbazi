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
	table, th, td{
		border-bottom: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		padding: 10px;
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
	.add{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	.adminAdd{
		background-color: #73734F;
		border-radius: 10px;
		position: absolute;
		top: 27px;
    	left: 116px;
    	display: flex;
    	flex-direction: column;
	} 
	.modal_madal {
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

.modal-content_madal {
    padding: 20px;
    text-align: center;
    color: #041d03;
    background-color: #fefefe;
    border-radius: 10px;
}

.btn_madal {
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

.btn_madal:hover {
    background-color: #20290E;
    color: white;
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
<body>
	<form action="adminAdd.do" method="post">
		<div class="adminAdd">
			<table>
				<thead>
					<tr>
						<th colspan="2"> 관리자 생성 </th>
					</tr>
					<tr>
						<th>관리자 아이디</th>
						<td><input type="text" name="admin_id" value=""/></td>
					</tr>
					<tr>
						<th>관리자 비밀번호</th>
						<td><input type="password" name="admin_pw" value=""/></td>
					</tr>
					<tr>
						<th>관리자 이름</th>
						<td><input type="text" name="admin_name" value=""/></td>
					</tr>
				</thead>
			</table>
			<button type="button" id="add" class="add">관리자 추가</button>
			<button class= "add" onclick="window.close();">닫기</button>
		</div>
	</form>
</body>
<div id="confirmationModal" class="modal_madal">
    <div class="modal-content_madal">
        <span class="close_modal" id="closeModal">&times;</span>
        <p id="confirmationMessage"></p>
        <button type="button" class="btn_madal" id="confirmAction">확인</button>
        <button type="button" class="btn_madal" id="cancelAction">취소</button>
    </div>
</div>

<script>
$(document).ready(function() {
    // 모달을 표시하는 이벤트 등록
    $('#add').on('click', function() {
        $('#confirmationMessage').text('추가하시겠습니까?');
        $('#confirmationModal').css('display', 'block'); // 모달을 보이도록 설정
    });

    // 확인 버튼 클릭 시 폼 제출
    $('#confirmAction').off('click').on('click', function() {
        // 모달 숨기기
        $('#confirmationModal').css('display', 'none');

         // 폼을 제출하고, 부모 창을 새로고침한 후 현재 창 닫기
        $('form').submit(); // 폼 제출

        window.opener.location.reload();

         // 현재 창 닫기
        setTimeout(function() {
            window.close();
        }, 200); 
    });

    // 취소 버튼 클릭 시 모달 닫기
    $('#cancelAction, #closeModal').off('click').on('click', function() {
        $('#confirmationModal').css('display', 'none'); // 모달 숨기기
    });
});
</script>
</html>