<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 {
    	width: 940px;
    	min-height: 650px;
    	height: auto;
    	display: flex;
    	flex-wrap: wrap;
    	justify-content: space-around;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px;
    	margin-top: 140px;
    	font-family: "Yeon Sung", system-ui;
    	flex-direction: row;
    	border: 2px solid rgb(255, 140, 9);
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
	#inqueryTable{
		color: rgb(255, 140, 9);
		background-color: #20290E;
		border: 1px solid #20290E;
		border-collapse: collapse;
		padding: 3px;
		font-size: 16px;
		font-family: "Yeon Sung", system-ui;
		text-align: center;
	}
	td{
		padding: 5px;
		width: 151px;
		text-align: center;
		border-bottom: 1px solid rgb(255, 140, 9);
	}
	#searchinquery{
		width: 283px;
		padding: 10px;
		border-radius: 20px;
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
    }
    #inqueryUl{
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    }
    .inqueryUl{
    	display: flex;
   	 	flex-direction: column;
    	align-items: center;
    	font-size: 48px;
    	color: #041d03;
    }
    
    button{
		background-color: rgb(255, 140, 9);
		color: #041d03;
		padding: 2px;
		border-radius: 5px;
		font-size: 14;
		font-family: "Yeon Sung", system-ui;
	    margin-right: 178px;
	}
	#inqueryIcon{
		font-size: 48px;
		color: rgb(255, 140, 9);
	}
</style>
</head>
<body>
<jsp:include page="../main/adminMain.jsp" />
<section class="chatBox2">
	<div class="chatitems2">
        <div id="inqueryList">
        	<ul class="inqueryUl">
        		<li>고객 센터 <i class='fas fa-headphones' id="inqueryIcon"></i></li>
        	</ul>
        	<ul id="inqueryUl">
         		<li><input type="radio" name="inquerystate" value="all"/> 전체 보기<li>&nbsp;
            	<li><input type="radio" name="inquerystate" value="false"/> 처리중<li>&nbsp;
            	<li><input type="radio" name="inquerystate" value="true"/>처리완료<li>&nbsp;
            	<li><button type ="button" id="inqueryfiltering">필터 적용</button><li>
        		<li><input type="text" id="searchinquery" class="search-input" value=""/>
           		<i class="fas fa-search" id="searchIcon" style="cursor: pointer; color:rgb(255, 140, 9);"></i><li>
        	</ul>
        </div>
	<div class="inqueryTable">
		<table style="width: 100%; height: 100%;">
			<thead>
				<tr id="inqueryTable">
					<th>문의자ID</th>
					<th>문의 제목</th>
					<th>문의 날짜</th>
					<th>처리상태</th>
					<th>처리자</th>
				</tr>
			</thead>
			<tbody id="list">
	
			</tbody>
			<tr>
				<th colspan="5">
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
var isPaginationInitialized = false; // 초기화 여부 플래그
var currentFilter = ''; // 현재 필터 상태 저장
var currentFilterState = ''; // 현재 필터 상태 값 저장
var currentSearchTerm = ''; // 검색어 저장

// 기본 페이지 호출
pageCall(showPage);

// 기본 페이지 호출 함수 (필터가 없을 때)
function pageCall(page) {
    currentFilter = 'default'; // 필터 상태 업데이트
    $.ajax({
        type: 'GET',
        url: 'inqueryList.do',
        data: {
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
            if (data && Array.isArray(data.list)) {
                drawList(data.list);
                setPagination(data.inquerytotalPages, function(evt, page) {
                    pageCall(page); // 기본 페이지 호출 시
                });
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

// 필터링된 페이지 호출
$('#inqueryfiltering').click(function() {
    var inquerystate = $(':input:radio[name=inquerystate]:checked').val();
    showPage = 1;
    currentFilterState = inquerystate; // 필터 상태 값 저장
    currentFilter = 'filter'; // 필터 상태 업데이트
    isPaginationInitialized = false; // 초기화 상태 리셋
    pageCallfiltering(showPage, inquerystate); // 필터링에 맞는 페이지 호출
});

function pageCallfiltering(page, inquerystate) {
    $.ajax({
        type: 'GET',
        url: 'inqueryFiltering.ajax',
        data: {
            'inquerystate': inquerystate,
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
            if (data && Array.isArray(data.list)) {
                drawList(data.list);
                setPagination(data.inquerytotalPages, function(evt, page) {
                    pageCallfiltering(page, inquerystate); // 필터링된 데이터에 맞는 페이지 호출
                });
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

// 검색 + 필터링 페이지 호출
$('#searchIcon').click(function() {
    var inquery_state = $(':input:radio[name=inquerystate]:checked').val();
    var id_write = $('#searchinquery').val();
    showPage = 1;
    currentSearchTerm = id_write; // 검색어 저장
    currentFilter = 'search'; // 검색 상태 업데이트
    isPaginationInitialized = false; // 초기화 상태 리셋
    pageCallsearch(showPage, inquery_state, id_write); // 검색에 맞는 페이지 호출
});

function pageCallsearch(page, inquery_state, id_write) {
    $.ajax({
        type: 'POST',
        url: 'inquerySearch.ajax',
        data: {
            'id_write': id_write,
            'inquery_state': inquery_state,
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
            if (data && Array.isArray(data.list)) {
                drawList(data.list);
                setPagination(data.inquerytotalPages, function(evt, page) {
                    pageCallsearch(page, inquery_state, id_write); // 검색된 데이터에 맞는 페이지 호출
                });
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

// 페이지네이션 설정
function setPagination(totalPages, onPageClick) {
    if (!isPaginationInitialized) {
        $('.pagination').twbsPagination({
            startPage: showPage,
            totalPages: totalPages,
            visiblePages: 5,
            first: '<<',
            prev: '<',
            next: '>',
            last: '>>',
            onPageClick: function(evt, page) {
                showPage = page; // 클릭된 페이지 저장
                if (currentFilter === 'default') {
                    pageCall(page); // 기본 페이지 호출
                } else if (currentFilter === 'filter') {
                    pageCallfiltering(page, currentFilterState); // 필터링된 페이지 호출
                } else if (currentFilter === 'search') {
                    pageCallsearch(page, currentFilterState, currentSearchTerm); // 검색된 페이지 호출
                }
            }
        });
        isPaginationInitialized = true; // 한 번만 초기화되도록 설정
    }
}

// 리스트 렌더링 함수
function drawList(list) {
    if (!Array.isArray(list)) {
        console.error('The provided list is not an array:', list);
        return;
    }
    var content = '';
    list.forEach(function(item) {
        content += '<tr>';
        content += '<td>' + item.id_write + '</td>';
        content += '<td><a href="inqueryDetail.go?inqueryIdx=' + item.inquery_idx + '">' + item.inquery_subject + '</a></td>';
        content += '<td>' + formatDate(item.inquery_date) + '</td>';
        content += '<td>' + getInqueryStatus(item.inquery_state) + '</td>';
        content += '<td>' + "관리자" + '</td>';
        content += '</tr>';
    });
    $('#list').html(content);
}

// 날짜 포맷 함수
function formatDate(dateString) {
    const date = new Date(dateString);
    const today = new Date(); // 오늘 날짜 객체 생성
    if (date.toDateString() === today.toDateString()) {
        return date.toLocaleTimeString('en-GB'); // 'HH:mm:ss' 형식
    } else {
        return date.toLocaleDateString('en-CA'); // 'YYYY-MM-DD' 형식
    }
}

// 문의 상태 처리 함수
function getInqueryStatus(inqueryState) {
    return inqueryState ? "처리완료" : "처리중";
}



</script>
</html>