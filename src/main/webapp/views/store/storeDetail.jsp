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
                height: 5000px;
                border-radius: 8px;
                
                display: flex;
                flex-direction: column;
                align-items: center;       
            }
            .ativeimage{
                background-color: aqua;
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
                background-color: #FFA91F;
                width: 95%;
                height: 500px;
            }
            fieldset{
            	border:1px solid black;
                background-color: rgba(255, 255, 255, 0);
                width: 100%;
                height: 500px;
            }
             table,tr,td,th{
                border:1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
            }
            #imgview {
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
			table.somw{
				width: 95%;
				margin: 0 20px;
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
    	width:100%;
        border-collapse: collapse;
       
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
        margin-left: 10px;
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
.review-write:hover{
	border: 4px solid #09f;
}
.review-write{
	margin: 0px 30px;
}
img.preview{
	width:100px;
	margin:3px;
	cursor: pointer;
}
img.review-photo{
	max-width: 100px;
	max-height: 100px;
}
			
			

            
        </style>
    </head>
    
    <body>
    <jsp:include page="../main/main.jsp"/>
        <main>
            <!-- 지도 영역 -->
            <div class="mapwhatname" id="map" style="width:789px;height:320px;"></div>
        
        
            <div class="bodysize">            	
               	<div class="ativeimage">
               		<img src="/photo/${file.new_filename}" alt="Store Photo" id="mainimg" />
               	</div>
                <br/>
                <p class="left-align"><strong>${store.store_name}</strong></p>
                <button class="favorite-btn" onclick="bookmark(${store.store_idx})">즐겨찾기</button>
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
	                    			<img class="icon" src="resources/img/img.png"/>
	                    			<a href="#" style="display: inline-block; color: black;">${board.board_subject}</a>
	                    		</td>
	                    		<td>${board.board_date}</td>
	                    	</tr>
	                    </table>    
                </div>
                <!-- 영업시간 영역-->
                <div class="operating">
                    <fieldset>
                        <legend>영업시간</legend>
                        <p>${store.store_time}</p>
                    </fieldset>
                </div>
                <!-- 메뉴정보 페이징 처리-->
                <fieldset>
                    <legend>메뉴</legend>
				    <button onclick="location.href='menu.do?storeidx=${store.store_idx}'">안주</button>
				    <button onclick="location.href='menu2.do?storeidx=${store.store_idx}'">술종류</button>
                </fieldset>			
                <!-- 사진 내외부 사진-->
                <fieldset>
                    <legend>사진 내외부</legend>
					<table>
						<tr>
	                    	<c:forEach var="file" items="${files}" varStatus="status">
								<td><img src="/photo/${file.new_filename}" alt="Store Photo" id="imgview" /></td>
							</c:forEach>
						</tr>
					</table>
                </fieldset>
                <section class="review-gragory">
                 <!-- 리뷰 작성-->
		             <article>
			            <h3>리뷰 작성</h3><button type="button" class="review-write btn btn-dark">리뷰 쓰기</button>
			      		<%-- <button onclick="openWindowTab(${store.store_idx})">리뷰가기</button> --%>
						<form enctype="multipart/form-data">
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
									<input type="file" name="files" multiple="multiple" onchange="readFile(this)">
									<div id="img_list"></div>
						            <button type="button" class="btn review-write btn-dark" onclick="writeDo()">등록</button>
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

    </body>
    <script>
    	
    
    /* 지도 영역 */
		var container = document.getElementById('map');
    	var storeLatitude = '${store.store_latitude}'
    	var storeLongitude = '${store.store_longitude}'
   		 
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
    	var loginId = '${sessionScope.loginId}';   

    	function bookmark(storeidx){
    		console.log(storeidx)
    	    $.ajax({
    	        type: 'POST',
    	        url: 'bookmark.ajax',
    	        data: {'loginId':loginId , 'storeidx':storeidx},
    	        dataType:'JSON',
    	        success: function(data) {
    	            if (data.bookmark>0) {
    	            	console.log(data.bookmark);
    	            	$('.favorite-btn').css('background-color', '#28256C');
    	            	$('.favorite-btn').text('즐겨찾기 완료'); 
					}else{
						$('.favorite-btn').css('background-color', '#FFA91F');
						$('.favorite-btn').text('즐겨찾기');
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
 			console.log("이종원 리뷰"+storeIdx)
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
    	
 		function drawList(reviews){
 			var listContainer = document.getElementById('review-section');
 			listContainer.innerHTML = '';
 			
 			reviews.forEach(function(review,idx){
 			   console.log("reviews img:", review.review_photos);
 				var reviewDate = review.review_date.split('T')[0];
 			    if (review.review_photos) {
 			        const photoArray = review.review_photos.split(',');  // 쉼표를 기준으로 문자열 분리
 			       review.photos = photoArray;
 			    }
 			    
 			var content = '<tr>'
 			 	content += '<td colspan="3" class = "profile">'
 			 	content +='<img src="/photo/'+review.user_photo+'" alt="user" class="profile-image">'
 			 	content +='<strong>&nbsp;'+review.user_nickname+'</strong>&nbsp;'
 			 	content +='<div class="like-section">'
 			 	content +='<img src="resources/img/이종원 좋아요전.png" alt="좋아요" class="icon-review">&nbsp;'+review.user_likecount+'</div>'
 			 	content +='</td></tr>'
 			 	content +='<tr><td class="rating-cell">'
 			 	content +='<img src="resources/img/종원리뷰별.png" alt="별점" class="icon-review">'+review.starpoint+' </td>'
 			 	content +='<td class="likes-cell">'
 			 	content +='<img src="resources/img/종원리뷰좋아요전.png" alt="좋아요" class="icon-review"> '+review.like_count+' </td>'
 			 	content +='<td class="category-cell">'+review.opt_names+'</td></tr>'
 			 	content += '<tr class="review-imgs hide"><td colspan="3" class="photo-cell">';
 			    if (review.photos && review.photos.length > 0 ) {
 			    	
 			    	review.photos.forEach(function(photo) {
 			            content += '<img  src="/photo/' + photo + '" alt="review photo" class="review-photo">';
 			        });
 			    }else{
 			    	content += '<p>이미지가 없습니다</p>'
 			    }
 			    	
		        content += '</td></tr>';
 			 	content +='<tr> <td colspan="3" class="review-content-cell">'
 			 	content += review.review_content+' </td></tr>'
 			 	content +='<tr><td colspan="3" class="action-cell">'+reviewDate
 			 	content +='<span class="report-section"><img src="resources/img/yellow.png" alt="좋아요" class="icon-review"></span>'
 			 	content +='<button class="action-button replyDown">답글</button>'
 			 	content +='<button class="action-button">수정</button>'
 			 	content +='<button class="action-button">신고</button>'
 			 	content +='<button class="action-button">삭제</button>'
 			 	content +='</td></tr>'
 			 	content +='<tr class="reply-show"><td colspan="3" class="text-area">'
 			 	content +=review.comm_content
 			 	content +='</td></tr>'
 			 	content +='<tr class="reply-show"><td colspan="3">'
 			 	content +='<button class="action-button replyUp">닫기</button>'
 			 	content +='<button class="action-button" onclick="reply('+review.review_idx+')">확인</button>'
 			 	content +='</td></tr>'
 			

 		   
 			 		
 		        
 		    
 		            
 		        
 		    
 			 	listContainer.innerHTML += content;
 			});
 		}
 		//리뷰 나오기 버튼 클릭시 해당영역 나오기
 		$('.review-write').click(function() {
 		    $('.mypost').slideDown(1000); 
 		});

 		// 리뷰 숨기기 버튼 클릭 시, 해당 영역을 부드럽게 사라지게 하기
 		$('.review-close').click(function() {
 		    $('.mypost').slideUp(2000); 
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
			}else
				alert("별점, 방문목적, 분위기를 선택해 주세요!!");
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
		
 	   //답글 영역 이벤트 
 		$('.replyDown').click(function() {
 		    $('.reply-show').slideDown(500); 
 		});

 		$('.replyUp').click(function() {
 		    $('.reply-show').slideUp(500); 
 		});
 		
 	   
 	   
 	   
 	   
 	   //답글 디비 넣기
 	   function reply(review_idx){
		    var commContent = document.getElementById("text-area").value; 

 		   
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
 	   }
 		
 		
    </script>
</html>