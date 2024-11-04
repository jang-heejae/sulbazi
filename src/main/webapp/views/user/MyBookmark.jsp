<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
	.chatBox2 {
    	display: flex;
    	justify-content: center;
    	align-items: flex-start; /* 시작점에서부터 정렬 */
    	width: 100%;
    	height: auto; /* 높이를 자동으로 조절하여 자식 요소에 따라 늘어남 */
	}
	.chatitems2 { 
    	width: 940px;
    	min-height: 650px; /* 초기 최소 높이 설정 */
    	height: auto; /* 내용에 따라 높이 자동 조절 */
    	display: flex;
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    	align-content: center;
    	background-color: #73734F;
    	border-radius: 20px;
    	padding: 20px; /* 내부 여백 추가 */
    	margin-top: 140px; 
    	font-family: "Yeon Sung", system-ui;
	}
    .userNickname{
   		font-size: 96px;
   		margin-left: 31px;
   	 	margin-bottom: 12px;
   	 	color: rgb(255, 140, 9);
   	 	-webkit-text-stroke: 2px #20290E;
    }
    #userLike{
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    }
	.likeIcon{
    	width: 50px;
    	height: 50px;
    	object-fit: cover;
    	margin-right: 17px;
	}
	.profile-image {
    	width: 250px;
    	height: 250px;
    	border-radius: 50%; /* 동그란 모양으로 만들기 */
    	object-fit: cover; /* 이미지의 비율을 유지하면서 크기를 맞춤 */
	}
	button{
		background-color: #20290E;
		color: white;
		padding: 5px;
		border-radius: 5px;
		font-size: 14;
		font-weight: bold;
	}
	.userProfile2{
		display: flex;
    width: 100%;
    height: 100%;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
	}
	.userProfile1{
		display: flex;
    width: 45%;
    height: 45%;
    flex-direction: column;
    align-items: center;
	}
	.storeDetail{
		display: inline;
		width: 120px;
    	height: 100px;
		margin-top:  -9px;
		border-radius: 30px;
	}
	.bookmark3{
	    background-color: #20290E;
		border: 2px solid rgb(255, 140, 9);
		color: white;
    	border-radius: 30px;
    	width: 100%;
    	height: 128px;
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    	justify-content: space-evenly;
	}
	.bookmark3 div{
	    height: 82%;
    	width: 58%;
	}
</style>
</head>
<body>
<c:import url="../main/main.jsp"/>
	<section class="chatBox2">
       	<div class="chatitems2">
 	        <div class="userProfile2" style="width:100%; height:100%;">
 	        <div class="userProfile1" style="width:45%; height:45%;">
				<div id="userProfile">
					<div class="userNickname">${info.user_nickname}</div>
					<div>
						<c:forEach items="${files}" var="file">
							<img class="profile-image" alt="${file.user_photo}" src="/photo/${file.user_photo}"/>
						</c:forEach>
					</div>
				</div>
				<div class="userLike">
					<div id="userLike" style="margin: 18px;">
						<img class="likeIcon" src="resources/img/userLike.png"/>
						<ul> 
							<li>${info.user_likecount}</li>
						</ul>
					</div>
				</div>
				</div>
			<div class="bookmark" style="width:45%; height:45%;">
				<div class="bookmark2" style="width:100%; height:20%;">
					<c:forEach var="store" items="${storeInfo}">
        				<div class="bookmark3">
            				<img class="storeDetail" src="/photo/${storePhoto[store.store_idx].new_filename}"
                 			onclick="location.href='storeDetail.do?storeidx=${store.store_idx}'"/>
            				<div>
            					<ul>
            						<li onclick="location.href='storeDetail.do?storeidx=${store.store_idx}'" style="cursor: pointer;">${store.store_name}</li>
            						<li>
            							<img src="resources/img/종원리뷰별.png" style="width:25px; height:25px;"/>
               				 			${store.star_average}&nbsp;(<span>${store.review_total}</span>)
            						</li>
            						<li>
            							<c:forEach var="optName" items="${storeOpt[store.store_idx]}">
                							<span style="color:gray;">#${optName}</span>
            							</c:forEach>
            						</li>
            						<li>${store.store_address}</li>
            					</ul>
            				</div>
        				</div>
    				</c:forEach>
				</div>
			</div>	
			</div>
       	</div>
    </section>
</body>
<script>

</script>
</html>