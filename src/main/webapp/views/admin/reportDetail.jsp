<%@page import="com.sulbazi.report.ReportDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		margin-top: 150px;
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	flex-direction: column;
    	align-items: stretch;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px;
    	font-family: "Yeon Sung", system-ui;
    	color:#20290E;
		font-weight: normal;
		border: 2px solid rgb(255, 140, 9);
	}
	#reportDiv{
		display: block;
		width: 913px;
    	margin-left: 2px;
    	margin-top: 11px;
    	height: 45px;
	}
	#ul{
		margin-top: 20px;
		margin-bottom: 15px;
	}
	#ul li{
		display: flex;
    	width: 100%;
    	justify-content: space-around;
    	align-items: center;
	}
	ul{
		display: flex;
	    flex-direction: column;
    	align-items: center;
	}
	label{
		display: block;
    	width: 154px;
    	font-weight: bold;
	}
	#ul input[type="text"]{
		width: 50%;
		padding: 10px;
		border-radius: 10px;
		border: none; /* 전체 테두리 제거 */
    	border-bottom: 2px solid #041d03;
		background-color: rgba(255, 255, 255, 0.1);
		color:#041d03;
		outline: none;
		font-family: "Yeon Sung", system-ui;
	}
	textarea{
		width: 83%;
		padding: 10px;
		border-radius: 10px;
		margin-bottom: 10px;
	    border-bottom: 2px solid #041d03;
	    font-family: "Yeon Sung", system-ui;
	}
	#textA {
	    margin-right: -1488px;
    	margin-left: -646px;
	}
	li:has(#textA){
		margin-bottom: 10px;
	}
	#processDiv2 {
    	display: block;
    	position: relative;
    	width: 100%;
	}
	#processList {
    	position: relative;
    	width: 100%;
    	margin-top: 20px;
	}
	input[name="reporting_id"], input[name="reported_id"]{
		cursor: pointer;
	}
	input[name="revoke_start"], input[name="revoke_stop"]{
		width: 79px;
		border-radius: 10px;
		font-family: "Yeon Sung", system-ui;
	}
	input[name="process_content"]{
		width: 130px;
		border-radius: 10px;
		font-family: "Yeon Sung", system-ui;
	}

	#button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
		width: 46px;
	}
	.processList2{
		color: rgb(255, 140, 9);
		background-color: #20290E;
		border-collapse: collapse;
		padding: 3px;
		font-size: 20px;
		font-family: "Yeon Sung", system-ui;
		border: 1px solid #20290E;
	}
	td{
		padding: 5px;
		width: 143px;
		text-align: center;
		border-bottom: 2px solid rgb(255, 140, 9);
	}
	#report_cate, option{
		color:#20290E;
		font-weight: normal;
		font-family: "Yeon Sung", system-ui;
		padding: 5px;
		border: 1px solid #20290E;
		border-radius: 10px;
	}
	#list{
		color:#20290E;
		font-weight: normal;
	}
	#processDiv input{
		padding: 3px;
	}
	hr{
    	border: none;
    	height: 2px;
   		background-color: rgb(255, 140, 9);
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
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<section class="chatBox2">
        <div class="chatitems2">
    <div id="reportDiv">
        <input type="hidden" name="report_idx" value="${info.report_idx}"/>
        <h1 style="color:rgb(255, 140, 9); font-size:48px; -webkit-text-stroke: 1px #20290E;">신고 상세보기</h1>
        <hr/>
    </div>
    <br/>
    <div id="ul">
        <ul>
            <li><label>신고자 아이디 : </label><input type="text" name="reporting_id" value="${info.reporting_id}" onclick="location.href='adminUserDetail.go?user_id=${info.reporting_id}'" readonly="readonly"/></li>
            <li><label>신고자 대상 아이디 : </label><input type="text" name="reported_id" value="${info.reported_id}" onclick="location.href='adminUserDetail.go?user_id=${info.reported_id}'" readonly="readonly"/></li>
            <li><label>신고 사유 : </label><input type="text" name="report_content" value="${info.report_content}" readonly="readonly"/></li>
            <li><label id="textA">신고 내용 : </label><span>${info.report_category}</span></li>
                <li><textarea rows="10" cols="80" readonly="readonly">${reported_content}</textarea></li>
            <li>
    			<label>신고 날짜 :</label> 
        		<input type="text" name="report_date" 
               		value="<fmt:formatDate value='${info.report_date}' pattern='yyyy-MM-dd HH:mm:ss'/>" 
               		readonly="readonly"/>
			</li>
        </ul>
    </div>
    <br/>
    <form action="processWrite.do" method="get">
        <input type="hidden" id="report_idx" name="report_idx" value="${info.report_idx}"/>
        <input type="hidden" name="reported_id" value="${info.reported_id}"/>
        <input type="hidden" name="process_idx" value="${proinfo.process_idx}"/>
        <div id="processDiv2">
            <div id="processDiv">
                <ul>
                    <li>처리 내용 :
                        <select id="report_cate" name="cate_opt">
                            <option value="dismiss">반려</option>
                            <option value="revoke">이용 제한</option>
                        </select>
                        이용제한 시작일 : 
                        <input type="text" name="revoke_start" value=""/>
                        이용제한 종료일 :
                        <input type="text" name="revoke_stop" value=""/>
                        처리 사유 :
                        <input type="text" name="process_content" value=""/>
           				<span id="admin_name">${admin_name}</span>
                        <button type="button" id="button">등록</button>
                    </li>
                </ul>
            </div>
            <div id="processList">
                <table>
                    <tr class="processList2">
                        <td>처리 내용</td>
                        <td>이용제한 시작일</td>
                        <td>이용제한 종료일</td>
                        <td>처리 사유</td>
                        <td>처리 결과</td>
                        <td>처리 날짜</td>
                        <td>처리 담당자</td>
                    </tr>
                    <tbody id="list"></tbody> <!-- tbody에 리스트를 추가합니다 -->
                </table>
            </div>
        </div>
    </form>
    </div>
    </section>
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
listCall(); // 페이지 로드 시 데이터 호출
$(document).ready(function() {
    // 모달을 표시하는 이벤트 등록
    $('#button').on('click', function() {
        $('#confirmationMessage').text('등록하시겠습니까?');
        $('#confirmationModal').css('display', 'block'); // 모달을 보이도록 설정
    });

    // 확인 버튼 클릭 시 폼 제출
    $('#confirmAction').off('click').on('click', function() {
        // 모달 숨기기
        $('#confirmationModal').css('display', 'none');

         // 폼을 제출하고, 부모 창을 새로고침한 후 현재 창 닫기
        $('form').submit(); // 폼 제출
    });

    // 취소 버튼 클릭 시 모달 닫기
    $('#cancelAction, #closeModal').off('click').on('click', function() {
        $('#confirmationModal').css('display', 'none'); // 모달 숨기기
    });
});
function listCall() {
	var report_idx = $('#report_idx').val();
    $.ajax({
        type: 'GET', // POST 요청
        url: 'process.ajax', // 요청할 URL
        data: {report_idx: report_idx}, // process_idx를 문자열로 전달
        dataType: 'JSON',
        success: function(data) {
        	console.log(data);
            printList(data.list); // 데이터 처리
        },
        error: function(e) {
            console.error('AJAX Error:', e); // 오류 처리
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
function printList(list) {
    var content = '';
    for (var item of list) {
        content += '<tr>';
        content += '<td>' + item.process_result + '</td>'; // 처리 결과
        content += '<td>' + formatDate(item.revoke_start) + '</td>'; // 이용제한 시작일
        content += '<td>' + formatDate(item.revoke_stop) + '</td>'; // 이용제한 종료일
        content += '<td>' + item.process_content + '</td>'; // 처리 사유
        content += '<td>' + (item.report_state == 1 ? '처리완료' : '처리중') + '</td>'; // 보고 결과
        content += '<td>' + formatDate(item.process_date) + '</td>'; // 처리 날짜
        content += '<td>' + item.admin_name + '</td>'; // 처리 담당자
        content += '</tr>';
    }
    $('#list').html(content); // 결과를 <tbody id="list">에 추가
}
</script>
</html>