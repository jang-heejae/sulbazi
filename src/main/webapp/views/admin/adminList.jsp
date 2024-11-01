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
	body {
    	display: flex;
    	flex-direction: column;
    	align-items: center;
    	justify-content: center;  
    	gap: 20px;
    	margin: 20px;
    	font-weight: bold;
    	color: #041d03;
    	min-height: 100vh;
    	background-color: #041d03;
	}
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
		margin-top: 150px;
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
    	margin-top: 140px; 
	}
		table, th, td{
		border-bottom: 1px solid white;
		border-collapse: collapse;
		padding: 10px;
	}
	.adminList{
		    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-around;
	}
	#adminList{
		position: absolute;
	}
	button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.btn{
		margin-top: 10px;
		margin-left: 274px;
	}

</style>
<body>
	<c:import url="../main/adminMain.jsp"/>
	    <section class="chatBox2">
        <div class="chatitems2">
        <div class="adminList">
	<div id="adminList">
	<h1>관리자 리스트</h1>
	<hr/>
	<br/>
	<table id="adminListTable">
		<thead  id="thead">
			<tr>
				<th>관리자 아이디</th>
				<th>관리자 이름</th>
				<th>관리자 생성날짜</th>
			</tr>
		</thead> 
		<tbody id="list">
			
		</tbody>
	</table>
	<div class="btn"><button onclick="window.open('<c:url value="adminDetail.go"/>', 'popup', 'width=600,height=330'); return false;">관리자 추가</button></div>
	</div>
	</div>
	</div>
	</section>
</body>
<script>
function refresh() {
    window.opener.location.reload();
}
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
			content += '<td><a href="#" onclick="window.open(\'<c:url value="/adminUpdate.do?admin_id=' + item.admin_id + '" />\', \'popup\', \'width=600,height=400\'); return false;">' + item.admin_id + '</a></td>';
			content+='<td>'+item.admin_name+'</td>';
			content+='<td>'+formatDate(item.admin_doc)+'</td>';
			content+='</tr>';
		}
        $('#list').html(content);
   }
</script>
</html>