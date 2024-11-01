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
    	justify-content: center;
    	align-items: center;
    	align-content: center;
    	background-color: #041d03;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 200px; 
	}
	.store{
		background-color: white;
		width: 210px;
		height: 210px;
	    display: flex;
   		flex-direction: column;
    	align-items: center;
    	justify-content: space-evenly;
	}
	#bestStore, #bestChat{
	    flex-direction: row;
    	justify-content: space-around;
    	align-items: center;
    	display: flex;
	}
	.storeDetail{
		display: inline;
		width: 190px;
		height: 140px;
		margin-top:  -9px;
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
	<section class="chatBox2">
        <div class="chatitems2"> 
			<div id="bestStore" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
				<c:forEach var="store" items="${info}">
					<div class="store">
           				<img class="storeDetail" src="/photo/${map[store.store_idx].new_filename}"/>
						<div>${store.store_name}
						<i class="fas fa-star" style="color: yellow;"></i>
						${store.star_average}&nbsp;(<span class="span">${store.review_total}</span>)
						</div>
					</div>
				</c:forEach>
			</div>
		<div id="bestChat" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
			<div class="store">
				<div style="background-color: gray; width: 190px; height: 140px; margin-top:  -9px;"></div>
				<div></div>
			</div>
			<div class="store">
				<div style="background-color: gray; width: 190px; height: 140px; margin-top:  -9px;"></div>
				<div></div>
			</div>
			<div class="store">
				<div style="background-color: gray; width: 190px; height: 140px; margin-top:  -9px;"></div>
				<div></div>
			</div>
			<div class="store">
				<div style="background-color: gray; width: 190px; height: 140px; margin-top:  -9px;"></div>
				<div></div>
			</div>
		</div>
		<div id="bestBoard" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);"><label># 최신 게시글</label>
			<div>게시글 리스트</div>
		</div>
		</div>
	</section>
</body>
<script>

</script>
</html>