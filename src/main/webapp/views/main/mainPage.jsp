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
<div id="loginModal" class="modal_madal" style="display: none;">
    <div class="modal-content_madal">
        <span class="close_madal" onclick="$('#loginModal').hide();">&times;</span>
        <p>로그인이 필요한 페이지 입니다.</p>
        <p>로그인 페이지로 이동하시겠습니까?</p>
        <br/>
        <button class="btn_madal" onclick="redirectToLogin()">로그인</button>
    </div>
</div>
<script>
$(document).ready(function() {
    loadAdminMainContent();

    function loadAdminMainContent() {
        $.ajax({
            type: 'GET',
            url: 'main.ajax', // 데이터를 가져올 URL 설정
            dataType: 'JSON',
            success: function(data) {
                if (data) {
                    renderStores(data.stores, data.files);
                    renderChatrooms(data.chatRooms, data.profiles);
                    renderBoards(data.boards, data.storeInfo);
                }
            },
            error: function(e) {
                console.error('AJAX 에러:', e);
            }
        });
    }

    function renderStores(storeList, map) {
        var content = '';
        storeList.forEach(function(store) {
        	var storePhoto = map[store.store_idx];
        	content += '<div class="store" data-href="storeDetail.do?storeidx=' + store.store_idx + '">';
            content += '<img class="storeDetail" src="/photo/' + storePhoto.new_filename + '" alt="store_photo"/>';
            content += '<div><span class="store-name">' + store.store_name + '</span>';
            content += '<img src="resources/img/종원리뷰별.png" style="width:25px; height:25px;"/>';
            content += store.star_average + '(<span>' + store.review_total + '</span>)';
            content += '</div></div>';
        });
        $('#bestStore').html(content);
    }
    
    function renderChatrooms(chatList, profile) {
        var content = '';
        chatList.forEach(function(chat) {
            var userProfile = profile[chat.user_id]; 
            
            content += '<div class="chatList" data-href="userchatlist.go">';
            content += '<div class="chatList2"><span class="chatsub">' + chat.userchat_subject + '</span></div>';
            content += '<div class="userProfile">';
            content += '<img class="userImg" src="/photo/' + userProfile.user_photo + '" alt="user_photo"/>';
            content += '<div class="chatUser">' + userProfile.user_nickname + '</div>';
            content += '<div class="count">' + chat.current_people + ' / ' + chat.max_people + '</div>';
            content += '</div>';
            content += '<div class="Parti">';
            content += '<div class="Parti2">' + chat.userchat_date + '</div>';
            content += '</div></div>';
        });
        $('#bestChat').html(content);
    }

    function renderBoards(boardList, bstore) {
        var content = '';
        boardList.forEach(function(board, index) {
        	var storeIn = bstore[board.store_idx];
        	
        	content += '<div class="board" data-href="boardDetail.go?board_idx=' + board.board_idx + '">';
            content += '<ul>';
            content += '<li class="' + (index % 2 == 0 ? 'even' : 'odd') + '">';
            content += '<span style="width:10%;">' + board.board_category + '</span>';
            content += '<span style="width:50%; cursor: pointer;" onclick="location.href=\'boardDetail.go?board_idx=' + board.board_idx + '\'">' + board.board_subject + '</span>';
            content += '<span class="bIcon" style="color:pink; width:10%;"><img src="resources/img/이종원 좋아요전.png" style="width:25px; height:25px;"/>' + board.like_count + '</span>';
            content += '<span class="bIcon2" style="color:#041d03; width:10%;"><i class="fas fa-eye"></i>' + board.board_bHit + '</span>';
            content += '<span style="width:10%;">' + storeIn.store_name + '</span>';
            content += '<span style="width:10%;">' + board.board_date + '</span>';
            content += '</li></ul></div>';
        });
        $('#bestBoard').html(content);
    }
});

var loginId = '${sessionScope.loginId}';
const isLoggedIn = loginId !== 'null' && loginId !== '';

// .go 링크 클릭 이벤트에 로그인 확인 추가 (동적 요소 포함)
$(document).on('click', '.store, .chatList, .board', function(event) {
        event.preventDefault(); // 기본 링크 이동 막기
        var targetHref = $(this).data('href');

        if (isLoggedIn) {
            // 로그인된 경우 해당 링크로 이동
            window.location.href = targetHref;
        } else {
            // 로그인되지 않은 경우 로그인 모달 표시
            $('#loginModal').show();

            // 모달에서 로그인 버튼 클릭 시 로그인 페이지로 이동
            $('#confirmLoginBtn').off('click').on('click', function() {
                $('#loginModal').hide();
                window.location.href = 'login.go';
            });
        }
    });

    // 모달 닫기 버튼 클릭 시 모달 숨기기
    $('.close_madal').click(function() {
        $('#loginModal').hide();
    });

 $('#searchIcon').click(function() {
	 if (isLoggedIn) {
         // 로그인된 경우 검색 처리
         var category = document.getElementById("search_cate").value;
         var keyword = document.getElementById("mainSearch").value;
         var category1 = encodeURIComponent(category);
         var keyword1 = encodeURIComponent(keyword);
         window.location.href = '/SULBAZI/storeList.go?category=' + category1 + '&keyword=' + keyword1;
     } else {
         // 로그인되지 않은 경우 로그인 모달 표시
         $('#loginModal').show();
     }
}); 
//엔터키 이벤트
$('#mainSearch').keydown(function(event) {
    if (event.key == "Enter") {
    	if (isLoggedIn) {
            // 로그인된 경우 검색 처리
            var category = document.getElementById("search_cate").value;
            var keyword = document.getElementById("mainSearch").value;
            var category1 = encodeURIComponent(category);
            var keyword1 = encodeURIComponent(keyword);
            window.location.href = '/SULBAZI/storeList.go?category=' + category1 + '&keyword=' + keyword1;
        } else {
            // 로그인되지 않은 경우 로그인 모달 표시
            $('#loginModal').show();
        }
    }
}); 
function redirectToLogin() {
    $('#loginModal').hide();
    window.location.href = 'login.go'; // 로그인 페이지로 이동
}
</script>
</html>