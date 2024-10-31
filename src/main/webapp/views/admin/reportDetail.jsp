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
    	flex-direction: column;
    	align-items: stretch;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
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
	}
	textarea{
		width: 83%;
		padding: 10px;
		border-radius: 10px;
		    margin-bottom: 10px;
		    border-bottom: 2px solid #041d03;
	}
	#textA {
		margin-right: -1366px;
    	margin-left: -581px;
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
	table, td{
		border: none;
		padding: 3px;
		border-collapse: collapse;
		width: 926px;
		text-align: center;
		border-radius: 20px;
	}
	input[name="revoke_start"], input[name="revoke_stop"]{
		width: 79px;
		border-radius: 10px;
	}
	input[name="process_content"]{
		width: 130px;
		border-radius: 10px;
	}
	select{
		border-radius: 10px;
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.processList2 td{
		font-weight: bold;
		font-size: 16px;
	}
	#processDiv input{
		padding: 3px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<section class="chatBox2">
        <div class="chatitems2">
    <div id="reportDiv">
        <input type="hidden" name="report_idx" value="${info.report_idx}"/>
        <h1 style="color:rgb(255, 140, 9);">신고 상세보기</h1>
        <hr/>
    </div>
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
                        <button type="submit">등록</button>
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
<script>

listCall(); // 페이지 로드 시 데이터 호출


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