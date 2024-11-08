<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>SULBAZI</title>
<link rel="stylesheet" href="resources/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#mainSearchBar{
		position: absolute;
		top: 120px;
    	left: 718px;
    	width: 514px;
	} 
	#mainSearch{
		width: 322px;
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
</style>
</head>
<body>
	<c:import url="../main/adminMain.jsp"/>
		<div id="mainSearchBar">
		<ul>
			<li>
				<select id="search_cate" name="search_cate">
                	<option value="menu">메뉴</option>
                    <option value="name">매장이름</option>
                    <option value="addr">매장 주소</option>
               	</select>
           		<input type="text" id="mainSearch" name="mainSearch" value=""/>
           		<i class="fas fa-search" id="searchIcon" style="color:rgb(255, 140, 9);"></i>
           </li>
		</ul>
	</div>
	<section class="chatBox2">
        <div class="chatitems2"> 
        <span class="span">#추천 술집</span>
			<div id="bestStore" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
				<c:forEach var="store" items="${info}">
					<div class="store">
           				<img class="storeDetail" src="/photo/${files[store.store_idx].new_filename}" loading="lazy"
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
					<div class="chatList2"><span class="chatsub">${chat.userchat_subject}</span></div>
					<div class="userProfile">
						<img class="userImg" src="/photo/${profiles[chat.user_id].user_photo}" loading="lazy"/>&nbsp;
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
							<span style="width:50%; cursor: pointer;" onclick="location.href='boardDetail.go?board_idx=${board.board_idx}'">
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

// 매장 서치 이동해보자
$('#searchIcon').click(function() {
    var category = document.getElementById("search_cate").value;
    var keyword = document.getElementById("mainSearch").value;
    var category1 = encodeURIComponent(category);
    var keyword1 = encodeURIComponent(keyword);
    window.location.href = '/SULBAZI/storeList.go?category=' + category1 + '&keyword=' + keyword1;
}); 
//엔터키 이벤트
$('#mainSearch').keydown(function(event) {
    if (event.key == "Enter") {
    	event.preventDefault()
        var category = document.getElementById("search_cate").value;
        var keyword = document.getElementById("mainSearch").value;
        var category1 = encodeURIComponent(category);
        var keyword1 = encodeURIComponent(keyword);
        window.location.href = '/SULBAZI/storeList.go?category=' + category1 + '&keyword=' + keyword1;
    }
});	

</script>
</html>