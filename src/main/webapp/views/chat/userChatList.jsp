<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>

<!-- <script>
   $(document).ready(function() {
       var showPage = 1; // 기본으로 보여줄 페이지
       pageCall(showPage); // 페이지 호출

       function pageCall(page) {
           console.log('pageCall');
       
           $.ajax({
               type: 'GET',
               url: 'chatlist.ajax', 
               data: {
                   'page': page, // 몇 페이지 보여줄지
                   'cnt': 100 // 페이지당 몇 개의 게시물을 보여줄지
               },
               dataType: 'JSON', 
               success: function(data) {
                   console.log(data);
                   chatlistPrint(data.chatlist);
                   
                   // 페이징 플러그인 처리
                   $('#pagination').twbsPagination({
                       startPage: 1, // 현재 보여지는 페이지
                       totalPages: data.totalPages, // 최대 페이지 수
                       visiblePages: 5, // 보여줄 페이지의 수
                       onPageClick: function(evt, page) {
                           console.log("evt", evt); // 클릭 이벤트의 모든 내용
                           console.log("page", page); // 클릭한 페이지 번호
                           pageCall(page); // 페이지 정보 받아서 수행
                       }
                   });
               },
               error: function(e) {
                   console.log("오류 발생", e);
               }       
           });
       }
   

       function chatlistPrint(chatlist) {
           var content = '';
           
           for (var item of chatlist) {
               content += '<div class="chatroom">';
               content += '    <div class="roomname">';
               content += '        <ul>';
               content += '            <li>' + item.userchat_subject + '</li>';
               content += '            <li>' + item.user_id + '</li>';
               content += '        </ul>';
               content += '    </div>';
               content += '    <div class="roominfo">';
               content += '        <div>';
               content += '            <ul>';
               content += '                <li>' + item.current_people + '/' + item.max_people + '</li>';
               content += '                <li>' + item.userchat_date + '</li>';
               content += '            </ul>';
               content += '        </div>';
               content += '        <div class="gobtn" onclick="location.href=\'/sulbazi/userchatroom.do\'">참여</div>';
               content += '    </div>';
               content += '</div>';
           }
           $('.chatitems').html(content);
       }
   });
</script> -->
<style>
    *{
        margin: 0;
        padding: 0;
    }
    ol, ul, li{
        list-style: none;
    }
    a{
        text-decoration: none;
    }
	.chatBox{
		display: flex;
   		justify-content: space-around;
   		align-items: center;
		width : 100%;
		height: 100%;
	}
	.chatitems{
		position: absolute;
		top: 20%;
	    width: 940px;
	    height: 650px;
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: center;
	    background-color: rgb(255, 140, 9);
	    border-radius: 20px;
	    overflow-y: auto; /* 수직 스크롤 활성화 */
	}
	
	.chatroom{
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
		margin : 5px;
		width: 230px;
		height: 230px;
		background-color : 73734F;
		border-radius: 45px;
	}
    .newroombtn{        
        z-index: 999;
        position: absolute;
        top: 140px;
        left: 1200px;
        width: 100px;
        height: 25px;
        background-color: 73734F;
        text-align: center;
        border-radius: 10px;
    }
    .createroom{
        display: none;
        position: absolute;
        left: 1100px;
        top: 250px;
        z-index: 999;
        background-color: rgb(106, 106, 219);
        width: 300px;
        height: 120px;
    }
    .newroombtn:hover{
        cursor: pointer;
        font-weight: bold;
    }
    .roominp{
        display: flex;
    }
    .roombtn{
        display: flex;
        justify-content: flex-end;
    }
    .roombtn div{
        background-color: aliceblue;
        text-align: center;
        width: 50px;
        height: 25px;
        margin: 0 10px;
    }
    .roombtn div:hover{
        cursor: pointer;
        font-weight: bold;
    }
    .commitbtn{
    	width: 50px;
        height: 25px;
        background-color: aliceblue;
	    border: none;
	    cursor: pointer;
	    text-align: left;
    }
    .roomname{
        background-color: aquamarine;
    }
    .roomname li{
        margin-bottom: 10px;
    }
    .roominfo{
        background-color: burlywood;
        display: flex;
        justify-content: space-between;
        width: 200px;
        align-items: center;
    }
    .gobtn{
        width: 50px;
        height: 50px;
    }
</style>
</head>
<body>
	<jsp:include page="../main/main.jsp"/>
	<section class="chatBox">
		<form action="userchatroom.do">
	        <div class="newroombtn">방 만들기</div>
	        <div class="createroom">
	            <ul>
	                <li>
	                    대화방 이름:<input type="text" name="userchat_subject" placeholder="방 제목을 입력하세요.">
	                </li>
	                <li class="roominp">
	                     제한 인원:<input type="range" name="current_people" min="1" max="20" value="5" oninput="document.getElementById('value2').innerHTML=this.value;">
	                     <p id="value2">5</p>
	                </li>
	            </ul>
	            <div class="roombtn">
	            	<button type="submit">개설</button>
	                <button class="cancel" type="button">취소</button>
	            </div>
	        </div>
	    </form>  
        <div class="chatitems">
          <c:forEach items="${list}" var="userchat">
            <div class="chatroom">
                <div class="roomname">
                    <ul>
                        <li>${userchat.userchat_subject}</li>
                        <li>${userchat.user_id}</li>
                    </ul>
                </div>
                <div class="roominfo">
                    <div>
                        <ul>
                            <li>${userchat.current_people}/${userchat.max_people}</li>
                            <li>${userchat.userchat_date}</li>
                        </ul>
                    </div>
                    <div class="gobtn" onclick="location.href='userchatroom.do'">참여</div>
                </div>
            </div>
       	</c:forEach>
      </div>
	<!-- <div>
       	<div class="container">
		    <nav aria-label="Page navigation">
		        <ul id="pagination" class="pagination"></ul>
		    </nav>
		</div>
	</div> -->
	</section>
</body>
<script>

		// 채팅방 취소 버튼
	    $('.newroombtn, .cancel').click(function(){      
	        var display = $('.createroom').css('display')
	        if (display == 'none'){
	            $('.createroom').show();
	        }else{
	            $('.createroom').hide();
	        }
	    });
		
/*     $(document).ready(function() {
    	
    	pageCall();; // 채팅 리스트 불러오기

        function pageCall() {
            console.log('loadChatList');

            $.ajax({
                type: 'GET',
                url: 'chatlist.ajax',
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    chatlistPrint(data.chatlist);
                },
                error: function(e) {
                    console.log("오류 발생", e);
                }
            });
        }

        function chatlistPrint(chatlist) {
            var content = '';

            for (var item of chatlist) {
                content += '<div class="chatroom">';
                content += '    <div class="roomname">';
                content += '        <ul>';
                content += '            <li>' + item.userchat_subject + '</li>';
                content += '            <li>' + item.user_id + '</li>';
                content += '        </ul>';
                content += '    </div>';
                content += '    <div class="roominfo">';
                content += '        <div>';
                content += '            <ul>';
                content += '                <li>' + item.current_people + '/' + item.max_people + '</li>';
                content += '                <li>' + item.userchat_date + '</li>';
                content += '            </ul>';
                content += '        </div>';
                content += '        <div class="gobtn" onclick="location.href=\'/sulbazi/userchatroom.do\'">참여</div>';
                content += '    </div>';
                content += '</div>';
            }
            $('.chatitems').html(content);
        }
    }); */
	
    // 페이징 
   /*  var showPage = 1; // 기본으로 보여줄 페이지

	pageCall(showPage);

	function pageCall(page){
		console.log('pageCall');
	
		$.ajax({
		    type: 'GET',
		    url: 'chatlist.ajax', 
		    data:{
		    	'page':page, // 몇페이지 보여줘?
		    	'cnt':6 // 페이지당 몇개의 게시물을 보여줘?
		    },
		    dataType: 'JSON', 
		    success: function(data) {
		        console.log(data);
		        chatlistPrint(data.chatlist);
		        
		        // 페이징 플러그인 처리
		        $('#pagination').twbsPagination({
		        	startPage:1, // 현재 보여지는 페이지
		        	totalPages:data.totalPages, // 최대 페이지 수
		        	visiblePages:5, // 보여줄 페이지의 수
		        	onPageClick:function(evt, page){
		        		console.log("evt",evt); // 클릭 이벤트의 모든 내용
		        		console.log("page",page); // 클릭한 페이지 번호
		        		pageCall(page); // 페이지 정보 받아서 수행
		        	}
		        });
		    },
		    error: function(e) {
		        console.log("오류 발생", e);
		    }       
		});
	}

	function chatlistPrint(chatlist){
		var content = '';
		
		for(var item of chatlist){
			content += '<div class="chatroom">';
	        content += '    <div class="roomname">';
	        content += '        <ul>';
	        content += '            <li>' + item.userchat_subject + '</li>';
	        content += '            <li>' + item.user_id + '</li>';
	        content += '        </ul>';
	        content += '    </div>';
	        content += '    <div class="roominfo">';
	        content += '        <div>';
	        content += '            <ul>';
	        content += '                <li>' + item.current_people + '/' + item.max_people + '</li>';
	        content += '                <li>' + item.userchat_date + '</li>';
	        content += '            </ul>';
	        content += '        </div>';
	        content += '        <div class="gobtn" onclick="location.href=\'/sulbazi/userchatroom.do\'">참여</div>';
	        content += '    </div>';
	        content += '</div>';
		}
		$('.chatitems').html(content);
	} */
    
</script>
</html>