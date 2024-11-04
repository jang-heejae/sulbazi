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
            border: 1px solid #ccc;
            padding: 15px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .close-button {
            cursor: pointer;
            color: red;
            float: right;
        }
    </style>
</head>
<body>
	<div class="user-details">
        <span class="close-button" onclick="window.close();">✖</span>
        <h2>User Details</h2>
        <p>Nickname: <strong>${info.user_nickname}</strong></p>
    </div>
</body>
<script>
	$(document).ready(function() {
	    var userNickname = new URLSearchParams(window.location.search).get('user_nickname');
	    if (userNickname) {
	        $.ajax({
	            url: 'userDetail.ajax',
	            type: 'GET',
	            data: { user_nickname: userNickname },
	            success: function(data) {
	                var userInfo = '<p>Nickname: <strong>' + data.user_nickname + '</strong></p>';
	                userInfo += '<p>Email: <strong>' + data.user_gender + '</strong></p>';
	                $('#userInfo').html(userInfo);
	            },
	            error: function() {
	                $('#userInfo').html('<p>회원 정보를 가져오는 데 실패했습니다.</p>');
	            }
	        });
	    }
	});
</script>
</html>