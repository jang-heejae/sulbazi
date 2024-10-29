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
    		<div class="stateselect">
                <fieldset>
                    <input type="radio" name="menu_category" value="안주"/> 안주 <br/>
                    <input type="radio" name="menu_category" value="주류"/> 주류<br/>
                </fieldset>
                <button type ="button" id="menufiltering">필터 적용</button>
            </div>
		</form>
	<table>
		<thead>
			<tr>
				<th>메뉴 사진</th>
				<th>메뉴 이름</th>
				<th rowspan="2">가격</th>
			</tr>
		</thead>
		<tbody id="list">
				<tr>
				<c:forEach var="menuphoto" items="${menuphoto}">
					<td>${menuphoto.new_filename}</td>
				</c:forEach>
				<c:forEach var="menu" items="${menulist}">
					<td>${menu.menu_name}</td>
					<td>${menu.menu_price}</td>
					<td><a>수정</a></td>
					<td><a>삭제</a></td>
				</c:forEach>
				</tr>
		</tbody>
	</table>
</body>
<script>
/* $.ajax({
	type:'GET',
	url:'menuList.do',
	data:{},
	dataType:'JSON',
	success: function(data) {
	    console.log(data);
	    // data.inquerylist가 배열인지 확인 후 drawList 호출
	    if (data && Array.isArray(data.menulist)) {
	        drawList(data.menulist);
	    } else {
	        console.error('Unexpected response format:', data);
	    }
	},error:function(e){
		console.log(e);
	}	
});


/* 메뉴 필터링 */
$('#menufiltering').click(function() {
	var menu_category = $(':input:radio[name=menu_category]:checked').val();
	console.log(menu_category);
    $.ajax({
        type:'GET',  //method
        url:'menuFiltering.ajax',  //요청 주소
        data:{'menu_category': menu_category},   //파라메터
        dataType:'JSON',  //받을 데이터 타입
    	success: function(data) {
    	    console.log(data);
    	    // data.inquerylist가 배열인지 확인 후 drawList 호출
    	    if (data && Array.isArray(data.menulist)) {
    	        drawList(data.menulist);
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
		content+='<td>'+item.menu_name+'</td>';
		content+='<td>' + item.menu_price + '</td>';
		content+='<td><a href="menuUpdate.do?menu_idx=' + item.menu_idx + '">'+수정+'</a></td>';
		content+='<td><a href="menuDelete.do?menu_idx=' + item.menu_idx + '">'+삭제+'</a></td>';
		content+='</tr>';
	});
	$('#list').html(content);	
}
</script>
</html>