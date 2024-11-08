<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta charset="UTF-8">
<title>SULBAZI</title>
<link rel="stylesheet" href="resources/common.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<body>
    <c:import url="../main/main.jsp"/>
    <div id="mainSearchBar">
        <ul>
            <li>
                <select id="search_cate" name="search_cate">
                    <option value="menu">메뉴 이름</option>
                    <option value="name">매장 이름</option>
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
                <!-- AJAX 응답으로 채워질 영역 -->
            </div>
            <span class="span">#추천 대화방</span>
            <div id="bestChat" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
                <!-- AJAX 응답으로 채워질 영역 -->
            </div>
            <span class="span">#추천 게시글</span>
            <div id="bestBoard" style="width:100%; height:230px; background-color:#041d03; margin:15px; border: 6px solid rgb(255, 140, 9);">
                <!-- AJAX 응답으로 채워질 영역 -->
            </div>
        </div>
    </section>
</body>
<script>
$(document).ready(function() {
    loadAdminMainContent();

    function loadAdminMainContent() {
        $.ajax({
            type: 'GET',
            url: 'main.ajax', // 데이터를 가져올 URL 설정
            dataType: 'json',
            success: function(data) {
                if (data) {
                    renderStores(data.stores);
                    renderChatrooms(data.chatRooms);
                    renderBoards(data.boards);
                }
            },
            error: function(e) {
                console.error('AJAX 에러:', e);
            }
        });
    }

    function renderStores(storeList) {
        var content = '';
        storeList.forEach(function(store) {
            content += '<div class="store">';
            content += '<img class="storeDetail" src="/photo/' + store.new_filename + '" loading="lazy"';
            content += ' onclick="location.href=\'storeDetail.do?storeidx=' + store.store_idx + '\'"/>';
            content += '<div><span class="store-name">' + store.store_name + '</span>';
            content += '<i class="fas fa-star" style="color: yellow;"></i>';
            content += store.star_average + '&nbsp;(<span>' + store.review_total + '</span>)';
            content += '</div></div>';
        });
        $('#bestStore').html(content);
    }

    function renderChatrooms(chatList) {
        var content = '';
        chatList.forEach(function(chat) {
            content += '<div class="chatList">';
            content += '<div class="chatList2"><span class="chatsub">' + chat.userchat_subject + '</span></div>';
            content += '<div class="userProfile">';
            content += '<img class="userImg" src="/photo/' + chat.user_photo + '" loading="lazy"/>&nbsp;';
            content += '<div class="chatUser">' + chat.user_nickname + '</div>';
            content += '<div class="count">' + chat.current_people + ' / ' + chat.max_people + '</div>';
            content += '</div>';
            content += '<div class="Parti">';
            content += '<div class="Parti2">' + chat.userchat_date + '</div>';
            content += '<div class="chatParti"><button type="button" onclick="location.href=\'userchatroom.go?idx=' + chat.userchat_idx + '\'">참여</button></div>';
            content += '</div></div>';
        });
        $('#bestChat').html(content);
    }

    function renderBoards(boardList) {
        var content = '';
        boardList.forEach(function(board, index) {
            content += '<div class="board">';
            content += '<ul>';
            content += '<li class="' + (index % 2 == 0 ? 'even' : 'odd') + '">';
            content += '<span style="width:10%;">' + board.board_category + '</span>';
            content += '<span style="width:50%; cursor: pointer;" onclick="location.href=\'boardDetail.go?board_idx=' + board.board_idx + '\'">' + board.board_subject + '</span>';
            content += '<span style="color:pink; width:10%;"><i class="far fa-kiss-wink-heart"></i>' + board.like_count + '</span>';
            content += '<span style="color:#041d03; width:10%;"><i class="fas fa-eye"></i>' + board.board_bHit + '</span>';
            content += '<span style="width:10%;">' + board.store_name + '</span>';
            content += '<span style="width:10%;">' + board.board_date + '</span>';
            content += '</li></ul></div>';
        });
        $('#bestBoard').html(content);
    }
});
        
        
        
        
        
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