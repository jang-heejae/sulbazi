<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4ae2258b561b1a937e5d3f2c155e60f9"></script>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
        <style>
/*             body{
                background-color: #20290E;
            } */
            .bodysize{
                background-color: white;
/*                 position: absolute;
                top: 202px
                left: 626px; */
                width: 788px;
                height: 100%;
                border-radius: 8px;
                display: flex;
                flex-direction: column;
                align-items: center;       
            }
            .ativeimage{
                width: 748px;
                height: 320px;
                margin-top: 20px;
            }
            /* p 태그를 왼쪽 정렬하는 스타일 */
            .left-align {
                font-size: 35px;
                align-self: flex-start; /* Flexbox에서 왼쪽 정렬 */
                margin:0 30px;
                width: auto; /* 텍스트 너비를 부모에 맞추지 않고 자동으로 설정 */
            }
            .favorite-btn {
                background-color: #FFA91F;
                align-self: flex-start;
                border: none;
                border-radius: 5px;
                padding: 5px 10px;
                color: white;
                cursor: pointer;
                margin: 10px 30px;
            }
            .linetag{
                background-color: rgb(0, 0, 0);
                width: 95%;
                height: 1px;
            }
            .title-container {
                list-style-type: none;
                display: flex;
                align-items: center;
                width: 100%; /* 부모 요소의 전체 너비 사용 */
                padding: 0 20px; /* 좌우 여백 추가 */
                margin-bottom : 0px;
            }
            .starfront{
                font-size: 35px;
                margin:0 0 0 30px;
            }
            .staravg{
                font-size:35px;
            }
            .promotionfont{
                font-size: 20px;
            }
            .promotion-list{
                margin:0 30px;
                width:95%;
                
            }
            .operating{
                width: 95%;
                height: 100%;
            }
            fieldset{
                background-color: rgba(255, 255, 255, 0);
                width: 100%;
                height: 500px;
            }
             table,tr,td,th{
                border-collapse: collapse;
                padding: 5px 10px;
            }
            .imgview {
                width: 100%;
                height: auto;
            }
            #mainimg{
            	width: 100%;
            	height: 100%;
            }
			fieldset table {
			    width: 100%; /* 테이블 너비를 부모 너비에 맞춤 */
			    table-layout: fixed; /* 고정 레이아웃으로 설정 */
			}
			
			fieldset td {
			    width: 20%; /* 각 <td>의 너비를 적절히 설정 */
			    text-align: center; /* 이미지 중앙 정렬 */
			    word-wrap: break-word; /* 내용이 너무 길 경우 줄 바꿈 */
			}
			img.icon{
				width:25px;
				display:inline ;
			}
			/* 홍보 게시판 */
			table.somw{
				width: 95%;
				margin: 0 20px;
				background-color: F9F0E6;
				border-radius: 15px;
			}
			.address{
				margin: 0 0 30px 0;
				width: 100%;
			}
			.address p{
				margin:0 60px;
			}
			.address-table{
				margin:0 60px;
			}
			.address-table *{
				border:0px;
			}
			.address-table{
				border:0px;
			}
			.mapwhatname{
				margin: 0 0 80px 0 ;
				border-radius: 8px;
				display: flex;
			}
			main{
				display: flex;
				flex-direction: column;
                align-items: center;       
			    position: absolute;
			    top: 192px;
			    left: 50%;
			    transform: translateX(-50%);
			}
			
	section.review-gragory{
		width: 100%;

	}
	
    #review-section {
	    margin: 0 auto; /* 수평 중앙 정렬 */
	    width: 95%;     /* 필요에 따라 너비 설정 */
       
    }
    .profile{
        vertical-align: top;
        padding: 10px;
    }

    .profile-image {
        width: 50px;
        height: 50px;
        border-radius: 50%;
    }
    .like-section {
        display: inline;
    }
    .rating-cell, .likes-cell, .category-cell, .review-content-cell, .action-cell {
        padding: 10px;
    }
    .icon-review {
        width: 20px;
    }
    .report-section {
        margin-left: 20px;
    }
    .action-button {
        margin: 10px 10px 10px 10px;
        padding: 5px 24px;
        border-radius: .25rem;
        border: 4px solid rgba(0, 0, 0, 0);
    }
    
*{
font-family: 'Gowun Dodum', sans-serif;
}


.mypost {
    width: 96%;
    margin : 20px auto 20px auto;
    box-shadow: 0px 0px 3px 0px gray;
    padding: 20px;
    display: none;
    
}
.bloom {
    color:rgb(138, 138, 151);
}
.mybtn {
     
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        margin-top: 10px; 
}
.mybtn > button {
    margin-right: 10px;
    box-shadow: 0px 0px 3px 0px gray;
    border: 1px solid black;
}
  .mybtn > button:hover{
    border: 4px solid #09f;
} 
h3 {
	margin: 20px;
}
/* .review-write:hover{
	border: 4px solid #09f;
} */
/* .review-write{
	margin: 0px 30px;
} */
img.preview{
	width:100px;
	margin:3px;
	cursor: pointer;
}
img.review-photo{
	max-width: 100px;
	max-height: 100px;
}
			
.reply-btn > button {
    box-shadow: 0px 0px 7px 0px gray;
    
}
  .reply-btn > button:hover{
    border: 4px solid #09f;			
}
.reply-show {
	/* opacity: 1;
	transition-duration: 0.75s; */
	/* display: none; */
	
}
 .hide{
	display: none;
}
  :root {
    --lovelish: hsl(0, 0%, 18%);
    --handshake: hsl(40, 100%, 66%);
  }

/*   .main-box {
    height: 100vh;
    display: flex;
    margin: auto;
  } */

  .button-box {
   /*  height: 500px;
    max-width: 500px; */
    align-items: center;
    justify-content: center;
    margin: auto;
    /* display: grid; */
  }

  /* Button 1 */
  .button {
    display: flex;
    align-items: center;
    border-radius: 1rem;
    transition: 0.5s;
    font-family: "Montserrat", sans-serif;
    font-size: 1.5rem;
    background-image: linear-gradient(to right,
      #8081cf,
      #847dc9,
      #8778c3,
      #8a74bd,
      #8d70b7,
      #8f6db2,
      #9169ac,
      #9266a7,
      #9362a1,
      #935e9a,
      #935b93,
      #93578d
    );
    color: white;
    animation: blurr 2s;
    animation-iteration-count: infinite;
    outline: none;
    cursor: pointer;
    border: none;
    padding: 0 3rem;
  }

  .imgthing {
    transition: 0.5s;
    width: 40px;
    height: 40px;
    margin-left: auto;
  }

  @keyframes blurr {
    0%,
    100% {
      box-shadow: 0 0 10px var(--handshake);
    }

    50% {
      box-shadow: 0 0 36px var(--handshake);
    }
  }

  @keyframes fade {
    0% {
      opacity: 100%;
    }
    100% {
      opacity: 0%;
    }
  }

  .title {
    font-weight: bold;
    transition: 0.5s;
    margin: 10px 30px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
    font-size: 1.2rem;
  }

  .button:hover .title {
    transform: translateX(-10px);
    animation: fade 0.5s;
    opacity: 0%;
  }

  .button:hover img {
    transform: translateX(-100px);
  }

  .description {
    position: absolute;
    font-weight: bold;
    line-height: 1.5rem;
    font-size: 1rem;
    font-style: italic;
    transition: 0.5s;
    opacity: 0%;
    margin: 10px px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  }

  .button:hover .description {
    transform: translateX(10px);
    opacity: 100%;
  }
    .reply-btn .rething:before {
        content: " ";
        display: inline-block;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: red;
        margin-right: 5px;
        vertical-align: middle;
    }
    .action-Update{
    	display: none;
    }
    
 /* 좋아요 버튼 */
 .btn-like {
  position:relative;
  top: 7px;
  border-radius: 4px;
  background-color: #f4511e;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 28px;
  padding: 0px;
  width: 117px;
  transition: all 0.5s;
  cursor: pointer;
  margin:1px 1px 1px 19px;
}

.btn-like span {
  cursor: pointer;
  display: flow;
  position: relative;
  transition: 0.5s;
}

.btn-like span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.btn-like:hover span {
  padding-right: 25px;
}

.btn-like:hover span:after {
  opacity: 1;
  right: 0;
}
/* 특정 테이블만 바텀에 솔리드 넣기 */
.target-row {
    border-bottom: 1px solid black;
}
/* 메뉴 영역 */
#menuId{
	width: 100%;
	height: 100%;
}
#menuId > button{
	margin: 10px 10px 10px 54px;
}
#menuId > button:hover{
	border: 4px solid #8677db;
	border-radius: 15px;
	
}
/* 영업시간 */
#timeStamp{
	margin-right: 50px;
	float: right;
	opacity: 0.5;
}   

#inoutphoto{
	width: 100%;
	height: 100%;
}
#line{
	width: 100%;
	height: 1px;
	background-color: black;
	display: block;
}
.text-right{
	text-align: right;
}
/* 수정 삭제 버튼 위치 조정 */
#user-check{
	margin: 1px 13px 12px 24px;
}
/* 검색바 */
    .search-container {
        display: flex;
        align-items: center;
        width: 610px;
        margin: 20px auto;
        left: 630px;
        position: absolute;
        top: 100px;
    }
    
        .search-wrapper {
        margin-left: 10px;
    }
    
        .search-input {
        width: 450px;
        padding: 8px 40px 8px 8px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 15px;
    }
    
        .search-button {
        position: absolute;
        background-color: rgb(255, 140, 9);
        border: none;
        border-radius: 20px;
        width: 54px;
        height: 42px;
        transition: background-color 0.3s ease;
        cursor: pointer;
        margin-left: 5px;
    }
    
        .search-button:hover {
        background-color: rgb(255, 120, 0);
    }
    
        .searchicon {
        width: 25px;
    }
    #somesearch{
    	display: flex;
    	position: absolute;
    	margin: 1px 1px 1px 1px;
    	
    }
        .search-select {
        padding: 8px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 15px;
    }
    
    


    



        </style>
    </head>
    
    <body>
<c:choose>
    <c:when test="${sessionScope.opt == 'admin_log'}">
        <jsp:include page="../main/adminMain.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'user_log'}">
        <jsp:include page="../main/main.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'store_log'}">
        <jsp:include page="../main/storeMain.jsp" />
    </c:when>
</c:choose>


	<form id="somesearch">
       <div class="search-container">
           <select class="search-select" id="searchCategory">
               <option value="menu">메뉴</option>
               <option value="name">매장이름</option>
               <option value="addr">매장 주소</option>
           </select>
           <div class="search-wrapper">
               <input type="text" class="search-input" id="searchQuery" placeholder="검색어를 입력하세요">
               <button id="performSearch" class="search-button" type="button" >
                  <img class="searchicon" alt="serchicon" src="resources/img/serchicon.png">
               </button>
           </div>
       </div>
   </form>
   
        <main>
        

            <!-- 지도 영역 -->
            <div class="mapwhatname" id="map" style="width:789px;height:320px;"></div>
        
        
            <div class="bodysize">            	
               	<div class="ativeimage">
               		<img src="photo/${file.new_filename}" alt="Store Photo" id="mainimg" />
               	</div>
                <br/>
                <p class="left-align"><strong>${store.store_name}</strong></p>
                <button class="favorite-btn hide" onclick="bookmark()">즐겨찾기</button>
                <div class="linetag"></div>
                <br/>
                <ul class="title-container">
                    <li class="starfront">평균 별점⭐</li>
                    <li class="staravg">${store.star_average}</li>
                </ul>
                <div class="address">
                		<!-- 주소 -->
                    <p>🚩${store.store_address}</p>
                    <br/>
                    <p></p>
                    <table class="address-table">
                    	<tbody>
                    		<tr>
                    			<!-- 매장 연락처 -->
                    			<td colspan="2">${store.store_phone}</td>
                    		</tr>
                    		<!-- 매장 주력 테마  -->
                    		<c:forEach var="storeOverview" items="${storeOverviews}" varStatus="status">
                    			<c:choose>
                    				<c:when test="${storeOverview.category_idx == 3}">
			                    		<tr>
			                    			<td>💗분위기</td>
			                    			<td>:&nbsp;${storeOverview.opt_name}</td>
			                    		</tr>
		                    		</c:when>
                    				<c:when test="${storeOverview.category_idx == 4}">
			                    		<tr>
			                    			<td>💗방문목적</td>
			                    			<td>:&nbsp;${storeOverview.opt_name}</td>
			                    		</tr>
		                    		</c:when>
                    				<c:when test="${storeOverview.category_idx == 1}">
			                    		<tr>
			                    			<td>💗주종</td>
			                    			<td>:&nbsp;${storeOverview.opt_name}</td>
			                    		</tr>
		                    		</c:when>
                    				<c:when test="${storeOverview.category_idx == 2}">
			                    		<tr>
			                    			<td>💗안주</td>
			                    			<td>:&nbsp;${storeOverview.opt_name}</td>
			                    		</tr>
		                    		</c:when>
	                    		</c:choose>
							</c:forEach>
                    	</tbody>
                    </table>
                </div>
                <div class="promotion-list">
	                    <p class="promotionfont"><strong>홍보</strong></p>
	                    <table class="somw">
	                    	<tr>
	                    		<td>${board.board_category}</td>
	                    		<td>
	                    			<!-- <img class="icon" src="resources/img/img.png"/> -->
	                    			<a href="boardDetail.go?board_idx=${board.board_idx}" style="display: inline-block; color: purple;;">${board.board_subject}</a>
	                    		</td>
	                    		<td>${board.board_date}</td>
	                    	</tr>
	                    </table>    
                </div>
                <!-- 영업시간 영역-->
                <div class="operating">
                        <h3>영업시간</h3>
                        <p id="timeStamp">${store.store_time}</p>
                </div>
                <!-- 메뉴정보 페이징 처리-->
                <div id="menuId">
                    <h3>메뉴</h3>
				    <button class="btn-light action-button" onclick="location.href='menu.do?storeidx=${store.store_idx}'">안주</button>
				    <button class="btn-light action-button" onclick="location.href='menu2.do?storeidx=${store.store_idx}'">술종류</button>
                </div>			
                <!-- 사진 내외부 사진-->
                <div id="inoutphoto">
                    <h3>사진 내외부</h3>
					<table>
						<tr>
	                    	<c:forEach var="file" items="${files}" varStatus="status">
								<td><img src="photo/${file.new_filename}" alt="Store Photo" id="imgview"  class="imgview"/></td>
							</c:forEach>
						</tr>
					</table>
                </div>
                <section class="review-gragory">
                 <!-- 리뷰 작성-->
		             <article>
			            <h3 class="reTextReview">리뷰 작성</h3>
    <div class="main-box container hide">
      <div class="button-box container">
        <button class="button review-btn">
          <p class="title">리뷰</p>
          <img class="imgthing"
            src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Hand%20gestures/Handshake.png"
            alt="Handshake"
          />
          <p class="description">즐거운 리뷰<br />쓰러 가기</p>
        </button>
      </div>
    </div>
			      		<%-- <button onclick="openWindowTab(${store.store_idx})">리뷰가기</button> --%>
						<form enctype="multipart/form-data" id="myForm">
						    <div class="mypost">
						        <div class="input-group mb-3">
						            <label class="input-group-text" for="inputGroupSelect01">별점</label>
						            <select class="form-select" id="ratingSelect">
						              <option value="0" selected>--선택하기--</option>
						              <option value="1">⭐</option>
						              <option value="2">⭐⭐</option>
						              <option value="3">⭐⭐⭐</option>
						              <option value="4">⭐⭐⭐⭐</option>
						              <option value="5">⭐⭐⭐⭐⭐</option>
						            </select>
						        </div>
						        <div class="input-group mb-3">
						            <label class="input-group-text" for="inputGroupSelect01">방문목적</label>
						            <select class="form-select" id="purposeSelect">
						           		<option value="0" selected>--선택하기--</option>
						               <c:forEach var="option" items="${options}">
						                   <c:if test="${option.category_idx == 3}">
						                       <option value="${option.opt_idx}">${option.opt_name}</option>
						                   </c:if>
						               </c:forEach>
						            </select>
						        </div>
						        <div class="input-group mb-3">
						            <label class="input-group-text" for="inputGroupSelect01">분위기</label>
						            <select class="form-select" id="moodSelect">
						            	<option value="0" selected>--선택하기--</option>
						               <c:forEach var="option" items="${options}">
						                   <c:if test="${option.category_idx == 4}">
						                       <option value="${option.opt_idx}">${option.opt_name}</option>
						                   </c:if>
						               </c:forEach>
						            </select>
						        </div>
						            <div class="bloom">
						                <div class="form-floating">
						                        <textarea class="form-control" placeholder="--내용--" id="text-area" style="height: 100px"></textarea>
						                </div>
						            </div>
						
						        <div class="mybtn">
									<input id="fileId" type="file" name="files" multiple="multiple" onchange="readFile(this)">
									<div id="img_list"></div>
									
									<div id="photo_list"><table id="qwewe"></table></div>
									
									<input class="hide" id="requestReviewIdx">
						            <button type="button" class="btn btn-dark action-write" onclick="writeDo()">등록</button>
						            <button type="button" class="btn btn-dark action-Update" onclick="reviewReWrite(this)">수정하기</button>
						            <button type="button" class="btn review-close btn-light">닫기</button>
						        </div>
						    </div>
						</form>
		             </article>
		                <!-- 리뷰  사용자 일경우 신고 수정 삭제 
		                 매장일 경우 신고 답글 -->
	                 <article class="table-article">
	                 	<table id="review-section">
                 	
	                 	</table>
	                 </article>
                </section>

            </div>
        </main>
<!-- 모달용 -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">신고하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
<input type="text" class="hide" id="reportedId">

<input type="text" class="hide" id="reportingId">

<input type="text" class="hide" id="reportCategory">

<input type="text" class="hide" id="reportedIdx">

      	<textarea class="form-control" maxlength="30" id="reportReason" name="reason" rows="3" required></textarea>
      </div>
      <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary action-button" onclick="submitReport()">신고하기</button>
      </div>
    </div>
  </div>
</div>

    </body>
    <script>
	var loginId = '${sessionScope.loginId}'; 
	var storeId = '${store.store_id}';
	var opt = '${sessionScope.opt}';
	
	if (opt == 'user_log') {
		$('.main-box').removeClass('hide');	
	}
		
		
	
	
	
	
    /* 지도 영역 */
		var container = document.getElementById('map');
    	var storeLatitude = '${store.store_latitude}';
    	var storeLongitude = '${store.store_longitude}';
   		 
		var options = {
			center: new kakao.maps.LatLng(storeLatitude, storeLongitude),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(storeLatitude, storeLongitude); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		marker.setMap(map);
		
    /* 북마크 영역 */
  
    	
    	if (loginId) {
			$('.favorite-btn').removeClass('hide');
		}
    	
    	
    	
    	firstMark();
    	
    	function firstMark(){
    		var	storeIdx = '${store.store_idx}';
    	    $.ajax({
    	        type: 'POST',
    	        url: 'firstMark.ajax',
    	        data: {'loginId':loginId , 'storeIdx':storeIdx},
    	        dataType:'JSON',
    	        success: function(data) {
    	            if (data.success<1) {
						$('.favorite-btn').css('background-color', '#FFA91F');
						$('.favorite-btn').text('즐겨찾기');
					}else{
    	            	$('.favorite-btn').css('background-color', '#28256C');
    	            	$('.favorite-btn').text('즐겨찾기 완료'); 
					}

    	        },
    	        error: function(error) {
    	            console.error('Error:', error);
    	        }
    	    });
    		
    	};

    	function bookmark(){
    		var	storeIdx = '${store.store_idx}';
    		//유저 아이디는 로그인 아이디로 해결
    		console.log(storeIdx);
    	    $.ajax({
    	        type: 'POST',
    	        url: 'bookmark.ajax',
    	        data: {'loginId':loginId , 'storeIdx':storeIdx},
    	        dataType:'JSON',
    	        success: function(data) {
    	            if (data.success >= 1) {
						$('.favorite-btn').css('background-color', '#FFA91F');
						$('.favorite-btn').text('즐겨찾기');
					}else{
    	            	$('.favorite-btn').css('background-color', '#28256C');
    	            	$('.favorite-btn').text('즐겨찾기 완료'); 
					}

    	        },
    	        error: function(error) {
    	            console.error('Error:', error);
    	        }
    	    });
    	}
    	
    	
    	
    	
    	
    	
    	//리뷰 글쓰기  아쟉 
/* function openWindowTab(storeIdx) {
    window.open(
        'review.go?storeidx=' + storeIdx, 
        '_blank', 
        'width=800,height=600,top=100,left=200,resizable=no'
    );
} */
    	// 리뷰 섹션 아쟉스
    	var storeIdx = '${store.store_idx}';
    	reviewShow(storeIdx);

 		function reviewShow(storeIdx){
// 			console.log("이종원 리뷰"+storeIdx)
 			$.ajax({
 				type:'POST', 
 				url: 'reviewAllUser.ajax',
 				data:{
 					'storeIdx':storeIdx
 				},
 				dataType:'json',
 				success:function(data){
 					if (data.reviews && data.reviews.length) {
						drawList(data.reviews);
						
					}else{
						 errorDraw(); 
					}
 					
 				},
 				error:function(e){
 					console.log(e);	
 					errorDraw();
 				}
 			}); 
 			
 		};
    	
 		var reviewDataList = [];
 		function drawList(reviews){
 			var listContainer = document.getElementById('review-section');
 			listContainer.innerHTML = '';
 			reviewDataList = [];
 			
 			var storeName = '${store.store_name}';
 			
 			reviews.forEach(function(review,idx){
 				var userIds = review.like_user_ids ? review.like_user_ids.split(',') : []; 
 				reviewDataList.push(review); 
 			   console.log("reviews img:", review.review_photos);
 				var reviewDate = review.review_date.split('T')[0];
 			    if (review.review_photos) {
 			        const photoArray = review.review_photos.split(',');  // 쉼표를 기준으로 문자열 분리
 			       review.photos = photoArray;
 			    }
 			    
  			    
 			var content = '<tr>';
 			 	content += '<td colspan="3" class = "profile">';
 			 	content +='<img src="/photo/'+review.user_photo+'" alt="user" class="profile-image">';
 			 	content +='<strong>&nbsp;'+review.user_nickname+'</strong>&nbsp;';
 			 	content +='<div class="like-section">';
 			 	content +='<img src="resources/img/이종원 좋아요전.png" alt="좋아요" class="icon-review">&nbsp;'+review.user_likecount+'</div>';
 			 	content +='</td></tr>';
 			 	content +='<tr><td class="rating-cell">';
 			 	content +='<img src="resources/img/종원리뷰별.png" alt="별점" class="icon-review">'+review.starpoint+' </td>';
 			 	content +='<td class="likes-cell">';
 			 	
 			 	
 			 	if (Array.isArray(userIds) && userIds.length > 0) {
 			 	    if (userIds.includes(loginId)) {
 			 	        // 좋아요가 눌린 상태
 			 	        content += '<img src="resources/img/종원리뷰좋아요후.png" alt="좋아요" class="icon-review"> ' + review.like_count + ' </td>';
 			 	    } else {
 			 	        // 좋아요가 눌리지 않은 상태
 			 	        content += '<img src="resources/img/종원리뷰좋아요전.png" alt="좋아요" class="icon-review"> ' + review.like_count + ' </td>';
 			 	    }
 			 	} else {
 			 	    // userIds가 비어 있을 때
 			 	    content += '<img src="resources/img/종원리뷰좋아요전.png" alt="좋아요" class="icon-review"> ' + review.like_count + ' </td>';
 			 	}

 			 	
 			 	content +='<td class="category-cell">'+review.opt_names+'</td></tr>'
 			 	
 			    if (review.photos && review.photos.length > 0 ) {
 			    	content += '<tr class="review-imgs"><td colspan="3" class="photo-cell">';
 			    	review.photos.forEach(function(photo) {
 			            content += '<img  src="photo/' + photo + '" alt="review photo" class="review-photo">';
 			        });
 			    	content += '</td></tr>';
 			    }
 			 	
		        
 			 	content +='<tr> <td colspan="3" class="review-content-cell">';
 			 	content += review.review_content;
 			 	if (review.comm_content != null) {
 			 	content +='</br><p class="thing">ㄴ'+storeName +': '+review.comm_content+'</p>';
				}
 			 	content +='</td></tr class="target-row">';
 			 	content +='<tr><td colspan="3" class="action-cell reply-btn text-right">'+reviewDate;
 			 	content +='<span class="report-section"><img src="resources/img/yellow.png" alt="좋아요" class="icon-review"></span>';
 			 	
 			 	//좋아요 버튼
 			 	if (loginId != review.user_id && opt != 'store_log' && opt != 'admin_log') {
 			 		//loginId != review.user_id && !['store_log', 'admin_log'].includes(opt) 이것도 같은거
			 	content +='<button class="btn-like" onclick="likebtn(this,'+review.review_idx+')"><span>좋아요 </span></button>';
				}
			 	

 			 	
			 	if (review.comm_content != null) {
 			 	content +='<button class="action-button btn-light rething store-user hide" onclick="replyDown(this)">답글?</button>';
				}else {
 			 	content +='<button class="action-button btn-light store-user hide" onclick="replyDown(this)">답글</button>';
				}
			 	if (review.user_id == loginId) {
 			 	content += '<button id="user-check" class="action-button btn-light" onclick="reviewUpdate(this,' + idx + ',' + review.review_idx + ')">수정</button>';
 			    } 
 			 	content += '<button id="user-check" class="action-button btn-light hide" onclick="reviewUpdate(this,' + idx + ',' + review.review_idx + ')">수정</button>';
 			 	
 			 	
 			 	/* 신고하기 버튼  */
 			 	if (review.user_id != loginId) {
					
 			 	content += '<button type="button" class="btn btn-warning action-button" data-toggle="modal" ';
 			 	content += 'data-target="#exampleModalCenter" data-reported-id="' + review.user_id + '" ';
 			 	content += 'data-reporting-id="' + loginId + '" data-report-category="리뷰" data-reported-idx="' + review.review_idx + '">신고하기</button>';
				}

			 	if (review.user_id == loginId) {
 			 	content += '<button id="user-check" class="action-button btn-light tttt" onclick="reviewDel(this,' + review.review_idx + ')">삭제</button>';
			 	}
 			 	content += '<button id="user-check" class="action-button btn-light hide tttt" onclick="reviewDel(this,' + review.review_idx + ')">삭제</button>';
 			 	
 			 	
 			 	content += '<div id="line"></div></td></tr>';
 			 	
 			 	
 			 	//답글영역
content += '<tr class="hide reply-show">';
content += '<td colspan="3" >';
content += '<textarea class="form-control reply-text" placeholder="답글 입력은 한 번만 가능합니다. 신중히 작성해주세요. 수정은 가능합니다." style="max-height: 80px"></textarea>';
content += '</td>';
content += '</tr>';

				
				content += '<tr class="reply-show hide"><td class="reply-btn" colspan="3">';
				content += '<button class="action-button btn-dark" onclick="replyUp(this)">닫기</button>';
				content += '<button class="action-button btn-dark" onclick="reply(this,' + review.review_idx + ')">확인</button>';
				content += '<button class="action-button btn-dark" onclick="replyUpdate(this,' + review.review_idx + ')">수정하기</button>';
				content += '<button class="action-button btn-dark" onclick="replyDel(this,\'' + review.review_idx + '\')">삭제하기</button>';
				content += '</td></tr>';  
		

 			

 		    

 		        
 		    
 			 	listContainer.innerHTML += content;
 			});
 			$('.thing').removeClass('hide');
			 	if (loginId == storeId) {
 			 	    $('.store-user').removeClass('hide');
				}
			 	
			 	
			 	
			 	
			 	
			 	
 		} //drawlist 끝 영역
 		
 		//리뷰 나오기 버튼 클릭시 해당영역 나오기
 		$('.button').click(function() {
 		    $('.mypost').slideDown(1000); 
 		});

 		// 리뷰 숨기기 버튼 클릭 시, 해당 영역을 부드럽게 사라지게 하기
 		$('.review-close').click(function(button) {
 		    $('.mypost').slideUp(2000); 
 		    $('.action-Update').slideUp(0);
 		    $('.action-write').slideDown(0);
 		   $('#review-section').slideDown(0);
 		  $('.reTextReview').text('리뷰 작성');
 	      $('#myForm')[0].reset();
 	     $('#img_list').empty();
 	      $('#qwewe').empty(); 
	        // textarea 초기화
 	    /*  	        document.getElementById('text-area').value = '';

 	     	        // select 요소 초기화
 	     	        document.getElementById('ratingSelect').selectedIndex = 0;
 	     	        document.getElementById('purposeSelect').selectedIndex = 0;
 	     	        document.getElementById('moodSelect').selectedIndex = 0;
 	     	       $('#img_list').empty(); */
 		    
 		});
 		
 		


 		//글쓰기 이벤트
 		function writeDo() {

 		    var ratingValue = document.getElementById("ratingSelect").value; 
 		    var purposeValue = document.getElementById("purposeSelect").value;  
 		    var moodValue = document.getElementById("moodSelect").value;  
 		    var reviewContent = document.getElementById("text-area").value; 
 		    
 		   var form = new FormData($('form')[0]);
 		  form.append('loginId', loginId);
 		  form.append('storeIdx', storeIdx);
 		  form.append('ratingValue', ratingValue);
 		  form.append('purposeValue', purposeValue);
 		  form.append('moodValue', moodValue);
 		  form.append('reviewContent', reviewContent);
 		  
 		    
	 		if (ratingValue != 0 && purposeValue != 0 && moodValue != 0 && reviewContent.trim() !== "" ) {
	 			$.ajax({
	 				type:'POST', 
	 				url: 'storeReviewWrite.ajax',
	 				processData:false,
	 				contentType: false,
	 				enctype:'multipart/form-data',
	 				data:form,
	 				dataType:'JSON',
	 				success:function(data){
						if (data.success) {
							reviewShow(storeIdx)
							$('.mypost').slideUp(2000); 
							$('#myForm')[0].reset();
							$('#img_list').empty();
							
						}else{
							errorReviewWrite();
							
						}
	 					
	 				},
	 				error:function(e){
	 					console.log(e);
	 					errorReviewWrite();
	 					alert("글쓰기를 실패하셨습니다. 다시 확인해 주세요.");
	 				}
	 			}); 
			}else{
				alert("별점, 방문목적, 분위기를 선택해 주세요!!");
				
			}
 		}
 		
  	   // 이미지 프리뷰
 		function readFile(input){
 			console.log( "온체인지 파일: "+input.files);
 			var reader;
 			$('#img_list').empty();
 			
 			for (var file of input.files) {
 				reader = new FileReader();
 				reader.readAsDataURL(file);
 				reader.onload = function(e){
 					$('#img_list').append('<img class = "preview" src="'+e.target.result+'"/>');
 				}
 			}
 			
 		}
  	   
  	   // 수정 할때 사진 폼
/*  		function readPhoto(input){
 			console.log( "온체인지 파일: "+input.files);
 			var reader;
 			
 			for (var file of input.files) {
 				reader = new FileReader();
 				reader.readAsDataURL(file);
 				reader.onload = function(e){
 					$('#img_list').append('<img class = "preview" src="'+e.target.result+'"/>');
 				}
 			}
 			
 		} */
 	   /* 노리뷰 */
 	   function errorDraw() {
 	       var listContainer = document.getElementById('review-section');
 	       
 	       var content = '<tr><td style="text-align: center; padding: 20px;">';
 	       		content +='리뷰가 없습니다 </td></tr>';
 	       	listContainer.innerHTML += content;
 	   }
 	   /* 글쓰기 오류 */
 	   function errorReviewWrite() {
 	       var listContainer = document.getElementById('review-section');
 	       
 	       var content = '<tr><td style="text-align: center; padding: 20px;">';
 	       		content +='글쓰기 오류 </td></tr>';
 	       	listContainer.innerHTML = content;
 	   }
		

 		
/*   	   //답글 영역 이벤트 
function replyDown(button) {
    // 클릭된 버튼 기준으로 가장 가까운 <tr>을 찾고, 그 다음에 오는 .reply-show 클래스를 가진 두 개의 <tr> 요소를 슬라이드 다운
    $(button).closest('tr').nextAll('.reply-show').slice(0, 2).slideDown(1000);
}

function replyUp(button) {
    // 클릭된 버튼 기준으로 가장 가까운 <tr>을 찾고, 그 <tr>과 위쪽에 있는 reply-show 클래스 두 개의 <tr> 요소를 슬라이드 업
    var $currentRow = $(button).closest('tr');
    var $targetRows = $currentRow.add($currentRow.prevAll('.reply-show').slice(0, 1));
    $targetRows.slideUp(1000);
} */
//답글 클래스 추가로 위아래 변경
/* function replyDown(button) {
    // 클릭된 버튼 기준으로 가장 가까운 <tr>을 찾고, 그 다음에 오는 .reply-show 클래스를 가진 두 개의 <tr> 요소의 숨김 클래스를 제거하고 슬라이드 다운
	$('.reply-show').slideDown(1000); 
}

function replyUp(button) {
    // 클릭된 버튼 기준으로 가장 가까운 <tr>을 찾고, 해당 <tr>과 그 위쪽에 있는 reply-show 클래스를 가진 두 개의 <tr> 요소에 숨김 클래스를 추가하고 슬라이드 업
    $('.reply-show').slideUp(1000);
} */

//답글 위아래 이벤트
function replyDown(button) {
	//가장 까운 tbody 자식중 reply-show 클래스 찾기
    $(button).closest('tbody').find('.reply-show').slideDown(0);
    $(button).closest('tbody').find('.thing').addClass('hide');
}

function replyUp(button) {
    $(button).closest('tbody').find('.reply-show').slideUp(0);
    $(button).closest('tbody').find('.thing').removeClass('hide');
}

 	   
 	   //답글 디비 넣기
 	   function reply(button,review_idx){
		   /*  var commContent = document.getElementById("reply-text").value;  */
		    var commContent = $(button).closest('tr').prev().find('.reply-text').val();
 		   console.log(commContent);
 		  var badThing = $(button).closest('tbody').find('.rething').length > 0;
 		  if (!badThing) {	
				$.ajax({
	 				type:'POST', 
	 				url: 'storeReviewReply.ajax',
	 				data:{
	 					'comm_content':commContent ,
	 					'review_idx':review_idx,
	 					'store_idx':storeIdx
	 				},
	 				dataType:'JSON',
	 				success:function(data){
						if (data.success) {
							reviewShow(storeIdx)
							
						}else{
							errorReviewWrite();
							
						}
	 					
	 				},
	 				error:function(e){
	 					console.log(e);
	 					errorReviewWrite();
	 					alert("글쓰기를 실패하셨습니다. 다시 확인해 주세요.");
	 				}
	 			}); 
	 	   }else{
	 		   alert('기존에 쓰신글이 있습니다 수정,삭제 밖에 불가능하십니다.');
	 	   }
 	  }
 	   //답글 리뷰 수정하기
 	   function replyUpdate(button,review_idx){
 		  var commContent = $(button).closest('tr').prev().find('.reply-text').val();
	 		$.ajax({
					type:'POST', 
					url: 'storeReviewReplyUpdate.ajax',
					data:{
						'comm_content':commContent ,
						'review_idx':review_idx
						
					},
					dataType:'JSON',
					success:function(data){
					if (data.success) {
						
						reviewShow(storeIdx)
						
						
					}else{
						errorReviewWrite();
						
					}
						
					},
					error:function(e){
						console.log(e);
						errorReviewWrite();
						alert("답글 수정실패 다시 확인해 주세요.");
					}
				}); 
 	 
 	   }
 	   //리뷰 답글 삭제
 	   function replyDel(button,review_idx){
	 		$.ajax({
					type:'POST', 
					url: 'storeReviewReplyDel.ajax',
					data:{
						'review_idx':review_idx
						
					},
					dataType:'JSON',
					success:function(data){
					if (data.success) {
						reviewShow(storeIdx)
					}else{
						alert("답글 삭제 실패했습니다 다시확인해 주세요.");
					}
					},
					error:function(e){
						console.log(e);
						errorReviewWrite();
						alert("답글 삭제 실패했습니다 다시확인해 주세요.");
					}
				}); 
 	 
 	   }
 	   //리뷰 수정 하기 눌렀을시 나오는 영역전개
 	   function reviewUpdate(button,idx,review_idx){
 		  /* var review_idx = reviewDataList[idx].review_idx; */
			$('.mypost').slideDown(0);
			$(button).closest('#review-section').slideUp(0);
			$('.reTextReview').text('수정하기');
			$('.action-write').slideUp(0);
			$('.action-Update').slideDown(0);
			$('#requestReviewIdx').val(review_idx);
			/* $('#purposeSelect').text(review.review_)
			$('#moodSelect').val(''); */
			$('#ratingSelect').val(reviewDataList[idx].starpoint);
			$('#text-area').val(reviewDataList[idx].review_content);

			
			
			photoDel(reviewDataList[idx],idx);

			

			
 	   }
 	   
 	   //제발 수정
 	  function photoDel(reviewListIdx, idx) {
 		    var photoList = document.getElementById('qwewe');
 		    photoList.innerHTML = '';  // 기존 내용을 초기화합니다.

 		    // 사진이 있을 경우 반복하여 추가
 		    if (reviewListIdx.photos && reviewListIdx.photos.length > 0) {
 		        var content = '';  // 전체 HTML을 누적할 변수입니다.

 		        reviewListIdx.photos.forEach(function(photo, index) {
 		            content += '<tr class = "reviewSomePhoto">';
 		            content += '<td>';  // `<td>` 추가로 잘못된 구조를 방지합니다.
 		            content += '<img src="photo/' + photo + '" alt="review photo" class="update-photo review-photo">';
 		            content += '<button type="button" onclick="photoCheck(this, \'' + photo + '\', ' + idx + ')" class="photo-check">사진 삭제</button>';
 		            content += '</td>';
 		            content += '</tr>';
 		        });

 		        photoList.innerHTML = content;  // 최종적으로 한 번에 HTML을 추가합니다.
 		    }
 		}
 	   
 	   
 	   //수정하기 에서 사진 삭제 버튼 눌렀을시 실행되는 메서드
 	   
 	   
 	  function photoCheck(button,photo,idx){
 		  console.log("이종원 함수 확인용 : "+reviewDataList[idx]);
 		  console.log("idx: "+idx);
 		    var parentTd = button.closest('.reviewSomePhoto');
 		    if (parentTd) {
 		        parentTd.remove();
 		    }
 		  
 		 var reviewIdx=  reviewDataList[idx].review_idx
 	  	    $.ajax({
		        type: 'POST',
		        url: 'reviewPhotoDel.ajax',
		        data: {
		        	'photo':photo,
		        	'reviewIdx':reviewIdx
		        	
		        },
		        dataType:'JSON',
		        success: function(data) {
		            if (data.success) {
		            	/* reviewDataList = [];  */
		            	reviewShow(storeIdx);
		                /* removePhotoFromUI(button); */
		                // reviewDataList 업데이트 (배열에서 해당 사진 제거)

		            	/* photoDel(reviewDataList[idx],idx); */
					}else{
						alert('선택하신 사진은 없는 사진입니다.')
					}
	
	
		        },
		        error: function(error) {
		            console.error('Error:', error);
		        }
		    }); 
 		/* reviewDataList = []; */
 	  }
 	   

 	    
 	   //리뷰 업데이트 함수
 	   function reviewReWrite(button){
		    var ratingValue = document.getElementById("ratingSelect").value; 
 		    var purposeValue = document.getElementById("purposeSelect").value;  
 		    var moodValue = document.getElementById("moodSelect").value;  
 		    var reviewContent = document.getElementById("text-area").value; 
 		    var reviewIdx = document.getElementById("requestReviewIdx").value; 
 		    
 		   console.log("이종원 reviewidx: " + reviewIdx);
 		   
 		   var form = new FormData($('form')[0]);
 		  form.append('loginId', loginId);
 		  form.append('storeIdx', storeIdx);
 		  form.append('ratingValue', ratingValue);
 		  form.append('purposeValue', purposeValue);
 		  form.append('moodValue', moodValue);
 		  form.append('reviewContent', reviewContent);
 		  form.append('reviewIdx', reviewIdx);
 		  
 		    
	 		if (ratingValue != 0 && purposeValue != 0 && moodValue != 0 && reviewContent.trim() !== "" ) {
	 			$.ajax({
	 				type:'POST', 
	 				url: 'reviewUpdate.ajax',
	 				processData:false,
	 				contentType: false,
	 				enctype:'multipart/form-data',
	 				data:form,
	 				dataType:'JSON',
	 				success:function(data){
						if (data.success) {
							$('#review-section').slideDown(0);
							$('.mypost').slideUp(2000);
							$('.reTextReview').text('리뷰 작성');
							$('.action-write').slideDown(0);
							$('.action-Update').slideUp(0)
							$('#myForm')[0].reset();
							$('#img_list').empty();
							$('#qwewe').empty(); 
							reviewShow(storeIdx)

							/* $('#img_list').empty(); */
							
						}else{
							errorReviewWrite();
							alert("리뷰 수정 실패하셨습니다. 다시 확인해 주세요.");
						}
	 					
	 				},
	 				error:function(e){
	 					console.log(e);
	 					errorReviewWrite();
	 					alert("리뷰 수정 실패하셨습니다. 다시 확인해 주세요.");
	 				}
	 			}); 
			}else{
				alert("별점, 방문목적, 분위기를 선택해 주세요!!");
				
			}
	 		
 	   } 
 	   
 	   
 	   //모달창에 특정 데이터 넘기기
 	    		 
  $('#exampleModalCenter').on('show.bs.modal', function (event) {
	    var button = $(event.relatedTarget);
	    var reportedId = button.data('reported-id');
	    var reportingId = button.data('reporting-id');
	    var reportCategory = button.data('report-category');
	    var reportedIdx = button.data('reported-idx');

	    var modal = $(this);
	    modal.find('#reportedId').val(reportedId);
	    modal.find('#reportingId').val(reportingId);
	    modal.find('#reportCategory').val(reportCategory);
	    modal.find('#reportedIdx').val(reportedIdx);
  });
 	   
  $('#exampleModalCenter').on('hidden.bs.modal', function () {
	    // 입력된 텍스트 초기화
	    $(this).find('textarea').val('');
	    // 숨겨진 필드 초기화
	    $(this).find('input[type="hidden"]').val('');
	});
 	   
 	  function submitReport(){
 		  
 		    var reportedId = $('#reportedId').val();
 		    var reportingId = $('#reportingId').val();
 		    var reportCategory = $('#reportCategory').val();
 		    var reportedIdx = $('#reportedIdx').val();
 		    var reportReason = $('#reportReason').val();
 		    
 		 console.log("종원 신고 할때 내용: "+reportedId)
 		 console.log("종원 신고 할때 내용: "+reportingId)
 		 console.log("종원 신고 할때 내용: "+reportCategory)
 		 console.log("종원 신고 할때 내용: "+reportedIdx)
 		 console.log("종원 신고 할때 내용: "+reportReason)

          
          $.ajax({
              type: 'POST',
              url: 'reportReview.ajax',
              data: {
                  "reportedId": reportedId,
                  "reportingId": reportingId,
                  "reportCategory": reportCategory,
                  "reportedIdx": reportedIdx,
                  "reportReason": reportReason
                },
              dataType: 'json',
              success: function(data) {
                  if (data.success) {
                      alert('신고가 접수되었습니다.');
                      $('#exampleModalCenter').modal('hide');
                      $('#exampleModalCenter')
                  } else {
                      alert('신고 처리에 실패했습니다. 다시 시도해주세요.');
                  }
              },
              error: function() {
                  alert('신고 접수 중 오류가 발생했습니다. 다시 시도해주세요.');
              }
          });
 	  }
 	  
 	  //리뷰 삭제
 	  function reviewDel(button,reviewIdx){
 		  
          $.ajax({
              type: 'POST',
              url: 'reviewDel.ajax',
              data: {
                  "reviewIdx": reviewIdx
                },
              dataType: 'json',
              success: function(data) {
                  if (data.success) {
                      alert('삭제 되었습니다.');
                      reviewShow(storeIdx);
                  } else {
                      alert('삭제 에 실패했습니다. 다시 시도해주세요.');
                  }
              },
              error: function() {
                  alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
              }
          });
 	  }
	//리뷰 좋아요
 	  function likebtn(button,reviewIdx){
 		 $(button).css('background-color', '#F781BE');
          $.ajax({
              type: 'POST',
              url: 'reviewLike.ajax',
              data: {
                  "reviewIdx": reviewIdx,
                  "loginId":loginId
                },
              dataType: 'json',
              success: function(data) {
            	  
                  if (data.success) {
                      reviewShow(storeIdx);
                	  
                  } else {
                      alert('좋아요 취소 했습니다.');
                      reviewShow(storeIdx);
                  }
              },
              error: function() {
                  alert('좋아요 중 오류가 발생했습니다. 다시 시도해주세요.');
              }
          });
 	  }
 	   

 		
    </script>
</html>