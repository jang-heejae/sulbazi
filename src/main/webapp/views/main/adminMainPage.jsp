<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#mainSearchBar{
		position: absolute;
		top: 120px;
    	left: 718px;
    	width: 514px;
	}
	#mainSearch{
		width: 283px;
		padding: 10px;
		border-radius: 20px;
	}
	#search_cate, option{
		padding: 10px;
		border-radius: 20px;
	}
	#searchIcon {
		left: 393px;
    	top: 8px;
    	position: absolute;
    	cursor: pointer;
	}
	#bestStore{
		position: absolute;
		background-color: #73734F; 
		width: 883px;
    	height: 270px;
		left: 498px;
    	top: 228px;
    	display: flex;
    	flex-direction: row;
    	border-radius: 10px;
    	flex-wrap: nowrap;
    	align-content: stretch;
    	justify-content: space-evenly;
    	align-items: flex-start;
	}
	#bestStore div{
		background-color: rgb(255, 140, 9);
		width: 230px;
    	height: 230px;
    	margin: 10px;
    	border-radius: 10px;
	}
	#bestChat{
		position: absolute;
		background-color: #73734F; 
		width: 883px;
    	height: 270px;
		left: 498px;
    	top: 500px;
    	display: flex;
    	flex-direction: row;
    	border-radius: 10px;
    	flex-wrap: nowrap;
    	align-content: stretch;
    	justify-content: space-evenly;
    	align-items: flex-end;
	}
	#bestChat div{
		background-color: rgb(255, 140, 9);
		width: 230px;
    	height: 230px;
    	margin: 10px;
    	border-radius: 10px;
	}
	#bestBoard{
		position: absolute;
		background-color: #73734F; 
		width: 883px;
    	height: 270px;
		left: 498px;
    	top: 772px;
    	display: flex;
    	flex-direction: row;
    	border-radius: 10px;
    	flex-wrap: nowrap;
    	align-content: stretch;
    	justify-content: space-evenly;
    	align-items: flex-end;
	}
	#bestBoard div{
		background-color: rgb(255, 140, 9);
		width: 862px;;
    	height: 230px;
    	margin: 10px;
    	border-radius: 10px;
	}
	lable{
		font-size: 24;
		color: white;
		font-weight: bold;
	}
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
		<div id="mainSearchBar">
		<ul>
			<li>
				<select id="search_cate" name="search_cate">
                	<option value="search_menu">메뉴</option>
                    <option value="menu_name">메뉴 + 매장 이름</option>
                    <option value="store_address">매장 주소</option>
               	</select>
           		<input type="text" id="mainSearch" name="mainSearch" value=""/>
           		<i class="fas fa-search" id="searchIcon"></i>
           </li>
		</ul>
	</div>
	<div id="bestStore"><label># 추천 술집</label>
		<div>매장1</div>
		<div>매장2</div>
		<div>매장3</div>
		<div>매장4</div>
	</div>
	<div id="bestChat"><label># 추천 대화방</label>
		<div>대화방1</div>
		<div>대화방2</div>
		<div>대화방3</div>
		<div>대화방4</div>
	</div>
	<div id="bestBoard"><label># 최신 게시글</label>
		<div>매장 리스트</div>
	</div>
</body>
<script>

</script>
</html>