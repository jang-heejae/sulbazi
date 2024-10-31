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
	table, th, td{
		border: 1px solid white;
		padding: 3px;
	}
	#reportDiv {
    	width: 918px;
    	position: absolute;
    	top: 128px;
    	left: 489px;
    	color: white;
	}
	#ul{
		position: absolute;
		top: 199px;
    	left: 626px;
    	width: 670px;
	}
	#ul li{
		margin: 10px;
	}
	#process{
		position: absolute;
		top: 560px;
		left: 488px;
	}
	#ul input{
		font-size: large;
		border-radius: 20px;
		padding-left: 8px;
	}
	textarea{
		border-radius: 20px;
		padding: 8px;
	}
	input[name="reporting_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="reporting_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="reported_id"]{
		position: absolute;
		left: 230px;
	}
	input[name="report_content"]{
		position: absolute;
		left: 230px;
	}
	input[name="report_date"]{
		position: absolute;
		left: 230px;
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
	}
	input[name="process_content"]{
		width: 130px;
	}
	#processList{
		height: 229px;
    	width: 920px
	}
	#processDiv{
		background-color: white;
		border-radius: 20px;
		padding: 10px;
		margin-bottom: 10px;
	}
	#proList{
		background-color: white;
		margin-bottom: 10px;
		padding: 5px;
		border-radius: 20px;
	}
	.processList2{
		background-color: white;
	}
	#processDiv2{
		position: absolute;
		left: 489px;
   	 	top: 564px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
    <div id="reportDiv">
        <input type="hidden" name="report_idx" value="${info.report_idx}"/>
        <h1>신고 상세보기</h1>
        <hr/>
    </div>
    <div id="ul">
        <ul>
            <li><h3>신고자 아이디 : <input type="text" name="reporting_id" value="${info.reporting_id}" readonly="readonly"/></h3></li>
            <li><h3>신고자 대상 아이디 : <input type="text" name="reported_id" value="${info.reported_id}" readonly="readonly"/></h3></li>
            <li><h3>신고 사유 : <input type="text" name="report_content" value="${info.report_content}" readonly="readonly"/></h3></li>
            <li><h3>신고 내용 : ${info.report_category}
                <textarea rows="10" cols="80" readonly="readonly">${reported_content}</textarea></h3></li>
            <li>
    			<h3>신고 날짜 : 
        		<input type="text" name="report_date" 
               		value="<fmt:formatDate value='${info.report_date}' pattern='yyyy-MM-dd HH:mm:ss'/>" 
               		readonly="readonly"/>
    			</h3>
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

function printList(list) {
    var content = '';
    for (var item of list) {
        content += '<tr>';
        content += '<td>' + item.process_result + '</td>'; // 처리 결과
        content += '<td>' + item.revoke_start + '</td>'; // 이용제한 시작일
        content += '<td>' + item.revoke_stop + '</td>'; // 이용제한 종료일
        content += '<td>' + item.process_content + '</td>'; // 처리 사유
        content += '<td>' + (item.report_state == 1 ? '처리완료' : '처리중') + '</td>'; // 보고 결과
        content += '<td>' + item.process_date + '</td>'; // 처리 날짜
        content += '<td>' + item.admin_name + '</td>'; // 처리 담당자
        content += '</tr>';
    }
    $('#list').html(content); // 결과를 <tbody id="list">에 추가
}
</script>
</html>