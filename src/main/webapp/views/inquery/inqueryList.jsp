<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
.stateselect{
    display: flex;
    margin-bottom:0;
}
input{
    margin-left: 10;
    margin: 0;
}
table{
    margin: auto;
    margin-left:auto; 
    margin-right:auto;
    width: 900;
}
table,th, td{
    border: 1px solid rgb(255, 140, 9);
    border-collapse: collapse;
    padding: 5;
}
th{
    background-color: rgb(255, 140, 9);
    font-size:25;
    text-align:center;
}

td {
	color: white;
	text-align:center;
}

div.table{
	border-radius:10;
	padding:10;
}

label{
    height:30;
    width: 100;
    font-size: 16;
}
label.selected{
    background-color: rgb(255, 140, 9);
}
fieldset{
	color: white;
	border-color: rgb(255, 140, 9);
}

div.include {
	display: flex;
	justify-content: center;
	align-items: center;
}
#inqueryfiltering {
    padding: 5px 8px;
    font-size: 12px;
    width:80;
    height:30;
}
#inquerysearch{
    padding: 5px 8px;
    font-size: 11px;
    width:30;
    height:30;
    border-radius: 50px; /* 모서리를 둥글게 */
}

#searchinquery{
	height:30;
	border-radius: 10px; /* 모서리를 둥글게 */
    padding: 8px; /* 여백을 추가해 깔끔하게 */
}

.something{
	display: flex;
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
    
div.inquerypage{
    margin: auto;
   }
    
</style>
</head>
<body>
<div class="include" >
    <c:choose>
    <c:when test="${sessionScope.opt == 'admin_log'}">
        <jsp:include page="../main/adminMain.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'user_log'}">
        <jsp:include page="../main/main.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'store_log'}">
        <jsp:include page="../main/storeMain.jsp" />
    </c:when>
</c:choose>
</div >
<div class="inquerypage">
        <form class="something">
			<form>
    			<div class="stateselect">
                	<fieldset>
                		<input type="radio" name="inquerystate" value="all"/> 전체 보기<br/>
                    	<input type="radio" name="inquerystate" value="false"/> 처리중<br/>
                    	<input type="radio" name="inquerystate" value="true"/>처리완료<br/>
                	</fieldset>
                	<button type ="button" id="inqueryfiltering">필터 적용</button>
            	</div>
        	</form>
    		<div class="search-container">
        		<div class="search-wrapper">
            		<input type="text" class="search-input" id="searchinquery" placeholder="검색어를 입력하세요" value=""/>
            		<button class="search-button" type="button" id="inquerysearch"><div class="searchicon">⌕</div></button>
        		</div>
    		</div>
		</form>
	<div class="table">
		<table>
			<thead>
				<tr>
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
</body>
<script>

var showPage = 1;
var isPaginationInitialized = false; // 초기화 여부 플래그
pageCall(showPage);

function pageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'inqueryList.do',
        data: {
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if (data && Array.isArray(data.list)) {
                drawList(data.list);

                if (!isPaginationInitialized) {
                    // 초기화가 안 되어 있을 때만 페이지네이션 초기화
                    $('.pagination').twbsPagination({
                        startPage: page,
                        totalPages: data.inquerytotalPages,
                        visiblePages: 3,
                        onPageClick: function(evt, page) {
                            console.log('Page:', page);
                            pageCall(page);
                        }
                    });
                    isPaginationInitialized = true; // 초기화 완료 상태로 설정
                }
            } else {
                console.error('Unexpected response format:', data);
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

/* 문의 리스트 필터링 */
$('#inqueryfiltering').click(function() {
    var inquerystate = $(':input:radio[name=inquerystate]:checked').val();
    console.log(inquerystate);
    var page = 1;
    isPaginationInitialized = false; // 초기화 상태 리셋
    pageCallfiltering(page);

    function pageCallfiltering(page) {
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
                console.log(data);
                if (data && Array.isArray(data.list)) {
                    drawList(data.list);

                    if (!isPaginationInitialized) {
                        $('.pagination').twbsPagination({
                            startPage: page,
                            totalPages: data.inquerytotalPages,
                            visiblePages: 3,
                            onPageClick: function(evt, page) {
                                console.log('Page:', page);
                                pageCallfiltering(page);
                            }
                        });
                        isPaginationInitialized = true;
                    }
                } else {
                    console.error('Unexpected response format:', data);
                }
            },
            error: function(e) {
                console.log(e);
            }
        });
    }
});

/* 문의자 필터 + ID 검색 */
$('#inquerysearch').click(function() {
    var inquery_state = $(':input:radio[name=inquerystate]:checked').val();
    var id_write = document.getElementById("searchinquery").value;
    console.log(inquery_state);
    console.log(id_write);
    var page = 1;
    isPaginationInitialized = false; // 초기화 상태 리셋
    pageCallsearch(page);

    function pageCallsearch(page) {
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
                console.log(data);
                if (data && Array.isArray(data.list)) {
                    drawList(data.list);

                    if (!isPaginationInitialized) {
                        $('.pagination').twbsPagination({
                            startPage: page,
                            totalPages: data.inquerytotalPages,
                            visiblePages: 3,
                            onPageClick: function(evt, page) {
                                console.log('Page:', page);
                                pageCallsearch(page);
                            }
                        });
                        isPaginationInitialized = true;
                    }
                } else {
                    console.error('Unexpected response format:', data);
                }
            },
            error: function(e) {
                console.log(e);
            }
        });
    }
});

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

function getInqueryStatus(inqueryState) {
    return inqueryState ? "처리완료" : "처리중";
}

function drawList(list) {
    if (!Array.isArray(list)) {
        console.error('The provided list is not an array:',list);
        return;
    }
	var content = '';
	list.forEach(function(item,idx) {
		content+='<tr>';
		content+='<td>'+item.id_write+'</td>';
		content+='<td><a href="inqueryDetail.go?inqueryIdx=' + item.inquery_idx + '">' + item.inquery_subject + '</a></td>';
		content+='<td>'+formatDate(item.inquery_date)+'</td>';
		content+='<td>'+getInqueryStatus(item.inquery_state)+'</td>';
		content+='<td>'+"관리자"+'</td>';
		content+='</tr>';
	});
	$('#list').html(content);
		
}
</script>
</html>