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
                <!-- 리뷰  사용자 일경우 신고 수정 삭제 
                 매장일 경우 신고 답글
                 페이징 처리 -->
                 <fieldset>
                    <legend>리뷰</legend>

                </fieldset>
                <!-- 리뷰 작성-->
                <fieldset>
                    <legend>리뷰 작성</legend>
                    
                </fieldset>
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
    	
    	
    </script>
</html>