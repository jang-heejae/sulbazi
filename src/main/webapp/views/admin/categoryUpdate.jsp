<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	body{
		color: white;
	}
	#category{
		position: absolute;
		width: 880px;
		top: 200px;
		left: 520px;
	}
	#categoryInsert{
		position: absolute;
		background-color: #20290E;
		border-radius: 20px;
		width: 350px;
        height: 500px;
		top: 90px;
		left: 30px;
	}
	#categoryDel{
		position: absolute;
		background-color: #20290E;
		border-radius: 20px;
		width: 350px;
        height: 500px;
		top: 90px;
		left: 510px;
	}
	#liveDel{
		display: flex;
		justify-content: space-around;
	}
	#delll{
		margin-left: 150px;
	}
	#liveee{
		margin-left: 40px;
	}
	#btn{
		position: absolute;
		top: 240px;
		left: 395px;
		display: flex;
   		flex-direction: column;
    	flex-wrap: nowrap;
    	align-items: stretch;
	}
	button{
		padding: 5px;
		border-radius: 20px;
	}
	#optDrink{
		position: absolute;
		padding: 10px;
		top: 10px;
	}
	#optMenu{
		position: absolute;
		padding: 10px;
		top: 120px;
	}
	#optMood{
		position: absolute;
		padding: 10px;
		top: 230px;
	}
	#optVisit{
		position: absolute;
		padding: 10px;
		top: 350px;
	}
	#optDrinkDel{
		position: absolute;
		padding: 10px;
		top: 10px;
		width: 330px;
	}
	#optMenuDel{
		position: absolute;
		padding: 10px;
		top: 120px;
		width: 330px;
	}
	#optMoodDel{
		position: absolute;
		padding: 10px;
		top: 230px;
		width: 330px;
	}
	#optVisitDel{
		position: absolute;
		padding: 10px;
		top: 350px;
		width: 330px;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
	<div id="category">
		<h2>카테고리</h2>
		<hr/>
		<br/>
		<div id="liveDel">
			<div id="liveee"><h3>활성화</h3></div>
			<div id="delll"><h3>비활성화</h3></div>
		</div>
		<div id="categoryInsert">
		<br/>
			<div id="optDrink">
				<h4>&nbsp;&nbsp;&nbsp;주종</h4>
				<hr/>
					<div id="cateOptDrink">
					</div>
			</div>
			<div id="optMenu">
				<h4>&nbsp;&nbsp;&nbsp;안주</h4>
				<hr/>
				<div id="cateOptMenu">
				</div>
			</div>
			<div id="optMood">
				<h4>&nbsp;&nbsp;&nbsp;분위기</h4>
				<hr/>
				<div id="cateOptMood">
				</div>
			</div>
			<div id="optVisit">
				<h4>&nbsp;&nbsp;&nbsp;방문목적</h4>
				<hr/>
				<div id="cateOptVisit">
				</div>
			</div>
		</div>
		<div id="btn">
			<button>활성화</button>
			<br/>
			<button>비활성화</button>
			<br/>
			<button onclick="window.open('<c:url value="categoryAdd.go"/>', 'popup', 'width=600,height=400'); return false;">카테고리 추가</button>
		</div>
		<div id="categoryDel">
		<br/>
		<div id="optDrinkDel">
				<h4>&nbsp;&nbsp;&nbsp;주종</h4>
				<hr/>
					<div id="cateOptDrinkDel">
					</div>
			</div>
			<div id="optMenuDel">
				<h4>&nbsp;&nbsp;&nbsp;안주</h4>
				<hr/>
				<div id="cateOptMenuDel">
				</div>
			</div>
			<div id="optMoodDel">
				<h4>&nbsp;&nbsp;&nbsp;분위기</h4>
				<hr/>
				<div id="cateOptMoodDel">
				</div>
			</div>
			<div id="optVisitDel">
				<h4>&nbsp;&nbsp;&nbsp;방문목적</h4>
				<hr/>
				<div id="cateOptVisitDel">
				</div>
			</div>
		</div>
	</div>
</body>
<script>
optListCall();
function optListCall(){
	$.ajax({
		type:'GET',
		url:'categoryList.ajax',
		data:{},
		dataType:'JSON',
		success:function(data){
			optList(data.list);
		},
		error:function(e){
			console.log(e);
		}
	});
}
function optList(list){
	var contentDrink = '';
    var contentMenu = '';
    var contentMood = '';
    var contentVisit = '';
    var contentDrinkDel = '';
    var contentMenuDel = '';
    var contentMoodDel = '';
    var contentVisitDel = '';
	for (var item of list) {
		var option = '<input type="radio" name="category" value="'+item.opt_name+'"/>'+item.opt_name+'&nbsp;&nbsp;&nbsp;';
		if(item.category_idx == '1' && item.category_state == 1){
			contentDrink += option;
		}else if(item.category_idx == '2' && item.category_state == 1){
			contentMenu += option;
		}else if(item.category_idx == '3' && item.category_state == 1){
			contentMood += option;
		}else if(item.category_idx == '4' && item.category_state == 1){
			contentVisit += option;
		}else if(item.category_idx == '1' && item.category_state == 0){
			contentDrinkDel += option;
		}else if(item.category_idx == '2' && item.category_state == 0){
			contentMenuDel += option;
		}else if(item.category_idx == '3' && item.category_state == 0){
			contentMoodDel += option;
		}else if(item.category_idx == '4' && item.category_state == 0){
			contentVisitDel += option;
		}
	}
		$('#cateOptDrink').html(contentDrink);
		$('#cateOptMenu').html(contentMenu);
		$('#cateOptMood').html(contentMood);
		$('#cateOptVisit').html(contentVisit);
		$('#cateOptDrinkDel').html(contentDrinkDel);
		$('#cateOptMenuDel').html(contentMenuDel);
		$('#cateOptMoodDel').html(contentMoodDel);
		$('#cateOptVisitDel').html(contentVisitDel);
}
</script>
</html>