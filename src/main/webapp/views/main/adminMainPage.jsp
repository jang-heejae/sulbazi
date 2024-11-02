<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
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
    	font-family: "Yeon Sung", system-ui;
	}
	.store{
		background-color: #73734F;
		width: 210px;
		height: 210px;
	    display: flex;
   		flex-direction: column;
    	align-items: center;
    	justify-content: space-evenly;
	}
	.chatList{
		background-color: rgb(255, 140, 9);
		border-radius: 30px;
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
	.chatList2{
		background-color: rgb(255, 140, 9);
		width: 185px;
   		height: 112px;
    	margin-top: -26px;
	}
	.chatUser{
		width: 119px;
    	height: 32px;
		background-color: rgb(255, 140, 9);
		display: flex;
    	flex-direction: column;
    	justify-content: center;
	}
	.userImg{
		border-radius: 50px;
		width: 35px;
		height: 35px;
	}
	.userProfile{
	    width: 91%;
    	display: flex;
    	align-items: center;
    	justify-content: space-between;
    	flex-direction: row;
    	margin: -34px;
	}
	.chatParti{
		width: 50px;
		height: 30px;
	}
	.Parti{
		margin-bottom: -33px;
		width: 87%;
    	display: flex;
    	flex-direction: row;
    	justify-content: space-between;
	}
	.count{
		width: 66px;
		height: 30px;
		background-color: rgb(255, 140, 9);
		display: flex;
    	flex-direction: column;
    	justify-content: center;
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.parti2{
		display: flex;
    	flex-direction: column;
    	justify-content: center;
	}
	.board ul{
		width: 100%;
	}
	.board li{
		width: 98%;
    	height: 20%;
    	margin: 9px;
		border-radius: 10px;
		display: flex;
    	flex-direction: row;
    	justify-content: space-around;
    	align-items: center;
    	text-align: center;
	}
	.even{
		background-color: #73734F;
	}
	.odd{
		background-color: rgb(255, 140, 9);
	}
	.span{
		color: rgb(255, 140, 9);
		font-size: 40px;
		font-weight: bold;
	}
	.store-name {
    	white-space: nowrap;
    	overflow: hidden;
    	text-overflow: ellipsis;
    	max-width: 54%;
    	display: inline-block;
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
        <span class="span">#추천 술집</span>
			<div id="bestStore" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
				<c:forEach var="store" items="${info}">
					<div class="store">
           				<img class="storeDetail" src="/photo/${files[store.store_idx].new_filename}"
           				onclick="location.href='storeDetail.do?storeidx=${store.store_idx}'"/>
						<div><span class="store-name">${store.store_name}</span>
						<i class="fas fa-star" style="color: yellow;"></i>
						${store.star_average}&nbsp;(<span>${store.review_total}</span>)
						</div>
					</div>
				</c:forEach>
			</div>
			<span class="span">#추천 대화방</span>
		<div id="bestChat" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
			<c:forEach var="chat" items="${chatRoom}">
				<div class="chatList">
					<div class="chatList2">${chat.userchat_subject}</div>
					<div class="userProfile">
						<img class="userImg" src="/photo/${profiles[chat.user_id].user_photo}"/>
						<div class="chatUser">${profiles[chat.user_id].user_nickname}</div>
						<div class="count">${chat.current_people} / ${chat.max_people}</div>
					</div>
					<div class="Parti">
						<div class="Parti2">${chat.userchat_date}</div>
						<div class="chatParti"><button type="button" onclick="location.href='userchatroom.go?idx=${chat.userchat_idx}'">참여</button></div>
					</div>
				</div>
			</c:forEach>
		</div>
		<span class="span">#추천 게시글</span>
		<div id="bestBoard" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
			<c:forEach var="board" items="${boards}" varStatus="status">
				<div class="board">
					<ul>
						<li class="${status.index % 2 == 0 ? 'even' : 'odd'}">
							<span style="width:10%;">${board.board_category}</span>
							<span style="width:50%;" onclick="location.href='boardDetail.go?board_idx=${board.board_idx}'">
								${board.board_subject}</span>
							<span style="color:pink; width:10%;"><i class="far fa-kiss-wink-heart"></i>
								${board.like_count}</span>
							<span style="color:#041d03; width:10%;"><i class="fas fa-eye"></i>
								${board.board_bHit}</span>
							<span style="width:10%;">${storeInfo[board.store_idx].store_name}</span>
							<span style="width:10%;">${board.board_date}</span>
						</li>
					</ul>
				</div>			
			</c:forEach>
		</div>
	</div>
</section>
</body>
<script>

</script>
</html>