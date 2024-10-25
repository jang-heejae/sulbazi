<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
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
}
table,th, td{
    border: 1px solid rgb(255, 140, 9);
    border-collapse: collapse;
}
th{
    background-color: rgb(255, 140, 9);
}
label{
    height:30;
    width: 100;
    font-size: 16;
}
label.selected{
    background-color: rgb(255, 140, 9);
}
</style>
</head>
<body>
        <form>
			<form>
    			<div class="stateselect">
                	<fieldset>
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
	</table>
</body>
<script>
$.ajax({
	type:'GET',
	url:'inqueryList.do',
	data:{},
	dataType:'JSON',
	success: function(data) {
	    console.log(data);
	    // data.inquerylist가 배열인지 확인 후 drawList 호출
	    if (data && Array.isArray(data.inquerylist)) {
	        drawList(data.inquerylist);
	    } else {
	        console.error('Unexpected response format:', data);
	    }
	},error:function(e){
		console.log(e);
	}	
});


/* 문의 리스트 필터링 */
$('#inqueryfiltering').click(function() {
	var inquerystate = $(':input:radio[name=inquerystate]:checked').val();
	console.log(inquerystate);
    $.ajax({
        type:'GET',  //method
        url:'inqueryFiltering.ajax',  //요청 주소
        data:{'inquerystate': inquerystate},   //파라메터
        dataType:'JSON',  //받을 데이터 타입
    	success: function(data) {
    	    console.log(data);
    	    // data.inquerylist가 배열인지 확인 후 drawList 호출
    	    if (data && Array.isArray(data.inquerylist)) {
    	        drawList(data.inquerylist);
    	    } else {
    	        console.error('Unexpected response format:', data);
    	    }
    	},
        error:function(e) {  //실패했을 경우(실패 내용)
            console.log(e)
        }
    });
})

//문의자 id 검색
$('#inquerysearch').click(function() {
	var inquery_state = $(':input:radio[name=inquerystate]:checked').val();
	var id_write = document.getElementById("searchinquery").value;
	console.log(inquery_state);
	console.log(id_write);
    $.ajax({
        type:'POST',  //method
        url: 'inquerySearch.ajax',  //요청 주소
        data:{'id_write' :id_write,
        		'inquery_state':inquery_state},   //파라메터
        dataType:'JSON',  //받을 데이터 타입
    	success: function(data) {
    	    console.log(data);
    	    // data.inquerylist가 배열인지 확인 후 drawList 호출
    	    if (data && Array.isArray(data.inquerylist)) {
    	        drawList(data.inquerylist);
    	    } else {
    	        console.error('Unexpected response format:', data);
    	    }
    	},
        error:function(e) {  //실패했을 경우(실패 내용)
            console.log(e)
        }
    });
})


function drawList(list) {
    if (!Array.isArray(list)) {
        console.error('The provided list is not an array:',list);
        return;
    }
	var content = '';
	list.forEach(function(item,idx) {
		content+='<tr>';
		content+='<td>'+item.id_write+'</td>';
		content+='<td>'+item.inquery_subject+'</td>';
		content+='<td>'+item.inquery_date+'</td>';
		content+='<td>'+item.inquery_state+'</td>';
		content+='<td>'+"관리자"+'</td>';
		content+='</tr>';
	});
	$('#list').html(content);
		
}
</script>
</html>