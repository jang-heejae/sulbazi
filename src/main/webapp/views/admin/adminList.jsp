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
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
		margin-top: 140px;
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	flex-wrap: wrap;
    	flex-direction: column;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	font-family: "Yeon Sung", system-ui;
    	color: #20290E;
    	font-weight: normal;
    	border: 2px solid rgb(255, 140, 9);
	}
	table, th, td{
		border-bottom: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		text-align: center;
		padding: 10px;
	} 
	#addBtn{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	}
	.adminList{
	    display: flex;
    	flex-direction: column;
	}
.modal_madal {
    display: none; /* 초기 상태에서 숨김 */
    position: fixed;
    z-index: 1000;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 530px;
    height: 336px; /* 모달 높이 설정 */
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
<body>
<jsp:include page="../main/adminMain.jsp"/>
	    <section class="chatBox2">
        	<div class="chatitems2">
        		<div class="adminList">
					<table id="adminListTable">
						<thead  id="thead">
							<tr>
								<th colspan="3" style="font-size:36px;">관리자 리스트</th>
							</tr>
							<tr>
								<th>관리자 아이디</th>
								<th>관리자 이름</th>
								<th>관리자 생성날짜</th>
							</tr>
						</thead> 
						<tbody id="list">
			
						</tbody>
					</table>
					<button id="addBtn" onclick="openModal(); return false;">관리자 추가</button>
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
listCall();
	function listCall(){
		$.ajax({
			type:'GET',
			url:'adminList.ajax',
			data:{},
			dataType:'JSON',
			success:function(data){
				printList(data.list);
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	function formatDate(dateString) {
	    // Date 객체 생성
	    const date = new Date(dateString);
	    const today = new Date(); // 오늘 날짜 객체 생성
	    if (date.toDateString() === today.toDateString()) {
	        // 오늘이면 시간만 표시
	        return date.toLocaleTimeString('en-GB'); // 'HH:mm:ss' 형식
	    } else {
	        // 오늘이 아니면 날짜만 표시
	        return date.toLocaleDateString('en-CA'); // 'YYYY-MM-DD' 형식
	    }
	}
	function printList(list){
		var content ='';
		for (var item of list) {
			content+='<tr>';
			content += '<td><a href="#" onclick="openAdminUpdateModal(\'' + item.admin_id + '\'); return false;">' + item.admin_id + '</a></td>';
			content+='<td>'+item.admin_name+'</td>';
			content+='<td>'+formatDate(item.admin_doc)+'</td>';
			content+='</tr>';
		}
        $('#list').html(content);
   }
	function openAdminUpdateModal(admin_id) {
	    $.ajax({
	        url: "adminUpdate.do",
	        method: "GET",
	        data: { admin_id: admin_id }, // 전달할 데이터
	        success: function(data) {
	            // 받은 데이터를 모달에 삽입
	            $('#modalContent').html(data);
	            $('#adminModal').css('display', 'block'); // 모달 표시
	        },
	        error: function() {
	            alert("모달 내용을 불러오는 데 실패했습니다.");
	        }
	    });
	}
	function openModal() {
	    $.ajax({
	        url: "adminDetail.go", // 불러올 JSP 파일 경로
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