<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="js/jquery.twbsPagination.js" type="text/javascript"></script>
        <style>
            body{
                background-color: #20290E;
            }
            .bodysize{
                background-color: white;
                position: absolute;
                top: 202px
                left: 626px;
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
                /* justify-content: flex-start; */
                align-items: center;
                width: 100%; /* 부모 요소의 전체 너비 사용 */
                padding: 0 20px; /* 좌우 여백 추가 */
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
                align-self: flex-start;
            }
            .operating{
                background-color: #FFA91F;
                width: 95%;
                height: 500px;
            }
            fieldset{
            	border:1px solid black;
                background-color: rgba(255, 255, 255, 0);
                width: 95%;
                height: 500px;
                margin: 10px;
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

            
        </style>
    </head>
    
    <body>
    <jsp:include page="../main/main.jsp"/>
        <main>
            <div class="bodysize">
               	<div class="ativeimage">
               		<img src="/photo/${file.new_filename}" alt="Store Photo" id="mainimg" />
               	</div>
                <br/>
                <p class="left-align"><strong>${store.store_name}</strong></p>
                <button class="favorite-btn" onclick="bookmark(${storeidx})">즐겨찾기</button>
                <div class="linetag"></div>
                <br/>
                <ul class="title-container">
                    <li class="starfront">평균 별점⭐</li>
                    <li class="staravg">${store.star_average}</li>
                </ul>
                <div class="address">
                    <p>주소,전화번호,분위기,방문목적,주종,안주 영역</p>
                    <p>${store.store_address}</p>
                    <p>${store.store_phone}</p>
                </div>
                <div class="promotion-list">
	                    <p class="promotionfont"><strong>홍보</strong></p>
	                    <table class="somw">
	                    	<tr>
	                    		<td>${board.board_category}</td>
	                    		<td>
	                    			<img class="icon" src="img/img.png"/>
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
				    <button onclick="location.href='menu.do?idx=${store.store_idx}'">안주</button>
				    <button onclick="location.href='menu2.do?idx=${store.store_idx}'">술종류</button>
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
    	var loginId = '${sessionScope.loginId}';    
    	function bookmark(storeidx){
    	    $.ajax({
    	        type: 'POST',
    	        url: 'bookmark.ajax',
    	        data: {'loginId':loginId , 'storeidx':storeidx},
    	        dataType:'JSON',
    	        success: function(data) {
    	            if (data.bookmark>0) {
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