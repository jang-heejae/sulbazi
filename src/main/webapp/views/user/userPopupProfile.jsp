<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .user-details {
        	position: relative;
            border: 1px solid #ccc;
            padding: 15px;
            background-color: rgb(255, 140, 9);
            color: white;
            border-radius: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px; /* 원하는 너비로 조정 */
            height: auto; /* 높이는 자동으로 조정 */
            
        }
        .close-button {
            cursor: pointer;
            color: red;
            float: right;
        }
        table {
            width: 100%; /* 테이블 너비를 100%로 설정 */
        }
        td {
            vertical-align: top; /* 세로 정렬을 위쪽으로 설정 */
            padding: 5px 10px; /* 여백 추가 */
            text-align: center;
        }
        .user-photo {
        	position:absolute;
        	top: 15px;
        	left: 97px;
            display: block; /* 블록 요소로 만들어 수평 중앙 정렬 */
            margin: 0 auto; /* 수평 중앙 정렬 */
            width: 130px; /* 사진 너비 */
            height: 130px; /* 사진 높이 */
            border-radius: 50%; /* 원형으로 만들기 */
            object-fit: cover; /* 이미지 비율 유지 */
        }
        .photo-container {
            text-align: center; /* 사진을 가운데 정렬 */
        }
        .whitebox {
        	text-align: center;
        	background-color: white;
        	margin: 15% 5%;
        	border-radius: 15px;      	
        }
        button{
        	background-color: #041d03;
        	color: white;
        	width: 10 auto;
        	margin: 1%;
        	height: 40px;
        	border-radius: 15px;
        	border: none;
        	font-weight: bolder;
        	padding-left: 20px;
        	padding-right: 20px;
        }
        .nickname{
        	font-size: 25px;
        }
        .genderboy, .gendergirl, .like{
        	font-size: 20px;
        }
        .category{
        	font-size: 16px;
        }
        .girl{
        	font-weight: bolder;
        	font-size: 22px;
        }
        .down{
        	width: 90px;
        	font-size: 20px;
        }
        .jongwonIcon{
        	width: 25px;
        	height: 25px;
        	margin: 0 0 0 0;
        	position: relative;
        	top: 2px;
        	left: -10px;
        }
#userLike{
    cursor: pointer;
}


        
    </style>
</head>
<body>
	<div class="user-details">
        <div class="whitebox">
        <table class="profile-table">
            <tbody>
                <tr>
                    <td><button class="nickname">${info.user_nickname}</button></td>  
                </tr>
                <tr>
                    <td>
	                    <c:choose>
				            <c:when test="${info.user_gender == '남'}">
				            	<button class="genderboy"><span class="boy">♂</span>&nbsp;${info.user_gender}</button> 
				            </c:when>
				            <c:when test="${info.user_gender == '여'}">
				            	<button class="gendergirl"><span class="girl">♀</span>&nbsp;${info.user_gender}</button> 
				            </c:when>
				         </c:choose>
				         <button class="like" id="userLike" onclick="clickLike()">
				         	<img class="jongwonIcon" src="resources/img/이종원 좋아요전.png">좋아요
				         </button> 
                    </td>
                </tr>
                <tr>
                    <td>
                        <c:forEach var="category" items="${category}">
                            <button class="category">#${category.opt_name}</button>
                        </c:forEach>
                    </td>
                </tr>
            </tbody>
        </table>
                        <img src="/photo/${info.user_photo}" alt="User Photo" class="user-photo">
        </div>
        <span class="close-button" onclick="window.close();"><button class="down">닫기</button></span>
    </div>
</body>
<script>
//좋아요 눌럿는지 처음 체크

$(document).ready(function() {
	userCheck();
});
	var loginId = '${sessionScope.loginId}';
	var userId = '${info.user_id}';
	console.log('로그인아이디 : '+loginId);
	console.log('유저아이디 : '+userId);

	
	function userCheck(){
		console.log('유저아이디 : '+userId);
		$.ajax({
				type:'GET', 
				url: '/SULBAZI/userLikeFind.ajax',
				data:{
					'userId':userId,
					'loginId':loginId
				},
				dataType:'JSON',
				success:function(data){
					if (data.success >0) {
						doLike()
					}else{
						dontLike()
					}
				},
				error:function(e){
					console.log(e);
					alert("좋아요불러오기 실패하셨습니다. 다시 확인해 주세요.");
				}
			});
	
	}		
 	  
	
	
	function doLike(){
		$('#userLike').empty();
		var content ='';
			content +='<img class="jongwonIcon" src="resources/img/이종원 좋아요후.png">좋아요';
		$('#userLike').html(content);
	};
	function dontLike(){
		$('#userLike').empty();
		var content ='';
			content +='<img class="jongwonIcon" src="resources/img/이종원 좋아요전.png">좋아요';
		$('#userLike').html(content);
	};
	
	
	function clickLike(){
		if(loginId != userId){
		$.ajax({
			type:'GET', 
			url: '/SULBAZI/insertLike.ajax',
			data:{
				'userId':userId,
				'loginId':loginId
			},
			dataType:'JSON',
			success:function(data){
				if (data.success >=1) {
					dontLike();
				}else{
					doLike();
				}
			},
			error:function(e){
				console.log(e);
				alert("좋아요를 실패하셨습니다. 다시 확인해 주세요.");
			}
		});
		}else{
			alert('자신에게 좋아요 다메요');
		}
	}
	
	
	
	

</script>
</html>