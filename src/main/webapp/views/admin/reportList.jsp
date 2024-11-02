<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
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
    	justify-content: space-between;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
	}
	input[type="radio"] {
        appearance: none; /* 기본 스타일 제거 */
        width: 15px;
        height: 15px;
        background-color: #041d03; /* 원하는 배경색 */
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
	#reportTable{
		background-color: rgb(255, 140, 9);
		border: 1px solid rgb(255, 140, 9);
		border-collapse: collapse;
		padding: 3px;
		font-family: "Irish Grover", system-ui;
		font-weight: bold;
	}
	td{
		padding: 5px;
		width: 151px;
		text-align: center;
		border-bottom: 2px solid white;
	}
	#reportList{
	    margin-bottom: 25px
	}
	.pagination {
    	display: flex; /* Flexbox로 설정 */
    	justify-content: center; /* 중앙 정렬 */
    	margin-top: 10px; /* 테이블과의 간격 */
	}

	.pagination li {
    	list-style: none; /* 기본 리스트 스타일 제거 */
    	margin: 0 5px; /* 버튼 간격 조정 */
	}

	.pagination a {
		font-family: "Irish Grover", system-ui;
		font-size: 20px;
    	color: #041d03; /* 버튼 글자색 */
    	background-color: #73734F; /* 버튼 배경색 */
    	padding: 5px 10px; /* 버튼 안쪽 여백 */
    	text-decoration: none; /* 밑줄 제거 */
    	border-radius: 5px; /* 둥근 모서리 */
    	border: 1px solid #73734F; /* 버튼 테두리 색 */
	}

	.pagination .active a {
    	background-color: #73734F; /* 현재 페이지 강조 색 */
    	color: rgb(255, 140, 9); /* 현재 페이지 글자색 */
	}
	.page-item.active .page-link {
    	z-index: 1;
    	color: rgb(255, 140, 9);
    	background-color: #73734F;
    	border-color: #73734F;
	}
	.page-item.disabled .page-link {
    	color: #fff;;
    	pointer-events: none;
    	cursor: auto;
    	background-color: #73734F;
    	border-color: #73734F;
	}
	.page-item.disabled .page-link {
    	color: rgb(255, 140, 9);
    	pointer-events: none;
    	cursor: auto;
    	background-color: #73734F;
    	border-color: #73734F;
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<section class="chatBox2">
        <div class="chatitems2">
	<div id="reportList">
		<h3>신고 목록</h3>
		<hr/>
		<input type="radio" name="report_state" value="all" checked/>전체 보기&nbsp;&nbsp;
		<input type="radio" name="report_state" value="0"/>처리 중&nbsp;&nbsp;
		<input type="radio" name="report_state" value="1"/>처리 완료
		<br/>
		<input type="radio" name="report_category" value="all" checked/> 전체 보기&nbsp;&nbsp;
		<input type="radio" name="report_category" value="리뷰"/>리뷰&nbsp;&nbsp;
		<input type="radio" name="report_category" value="개인 메시지"/>개인 메시지&nbsp;&nbsp;
		<input type="radio" name="report_category" value="지역 메시지"/>지역 메시지
	</div>
	<div id="reportDiv">
	<table>
		<thead>
			<tr id="reportTable">
				<td>신고자 아이디</td>
				<td>신고 대상 아이디</td>
				<td>접수 분류</td>
				<td>신고 내용</td>
				<td>신고 일자</td>
				<td>처리 상태</td>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
		<tr>
			<th colspan="6">
				<div class="container">
    				<nav aria-label="Page navigation">
        			<ul class="pagination" id="pagination"></ul>
    				</nav>
				</div>
			</th>
		</tr>
	</table>
	</div>
	</div>
	</section>
</body>
<script>
var showPage = 1;
pageCall(showPage);

 function pageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'reportList.ajax',
        data: {
            page: page,
            cnt: 15
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data); 
            if (data.list && data.totalPages) {
                listPrint(data.list);
                $('.pagination').twbsPagination({
                    startPage: page,
                    totalPages: data.totalPages,
                    visiblePages: 5,
                    first: '<<',     
                    prev: '<',       
                    next: '>',       
                    last: '>>', 
                    onPageClick: function(evt, page) {
                        console.log('Page:', page);
                        pageCall(page); 
                    }
                });
            } else {
                console.error('twbsPagination is not available');
            }
    },
    error: function(e) {
        console.error('AJAX Error:', e);
    }
});
} 
$(document).ready(function() {
    // 초기 목록 로드
   	pageCall(showPage);

    // 라디오 버튼 클릭 시 목록 업데이트
    $('input[name="report_state"], input[name="report_category"]').change(function() {
        report_filter();
    });
});

// 목록 업데이트 함수
function report_filter() {
    var reportState = $('input[name="report_state"]:checked').val() || "all";
    var reportCategory = $('input[name="report_category"]:checked').val() || "all";
    console.log("Selected report state: " + reportState);
    console.log("Selected report category: " + reportCategory);
    $.ajax({
        type: 'GET',
        url: 'report_filter.ajax',
        data: {
            reportState: reportState,
            reportCategory: reportCategory
        },
        dataType: 'JSON',
        success: function(data) {
        	listPrint(data.list);
        },
        error: function(e) {
            console.error('AJAX Error:', e);
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
function listPrint(list) {
    var content = '';
    for (var item of list) {
        content += '<tr>';
        content += '<td>' + item.reporting_id + '</td>';
        content += '<td>' + item.reported_id + '</td>';
        content += '<td>' + item.report_category + '</td>';
        content += '<td><a href="reportDetail.go?report_idx=' + item.report_idx + '">' + item.report_content + '</a></td>';
        content += '<td>' + formatDate(item.report_date) + '</td>';
        content += '<td>' + (item.report_state == 1 ? '처리완료' : '처리중') + '</td>';
        content += '</tr>';
    }
    $('#list').html(content); 
}

</script>
</html>