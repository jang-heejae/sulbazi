<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

.reviewarea{
    background-color: #041d03;
    width:1300px;
    height:700px;
    display: flex;
    margin:auto;
    border-radius: 10px;
    margin-top: 200px;
}
.review{
    background-color: rgb(255, 140, 9);
    width:600px;
    height:540px;
    margin: auto;
    border-radius: 10px;
}

.reply{
    background-color: rgb(255, 140, 9);
    width:600px;
    height:540px;
    margin: auto;
    border-radius: 10px;
}
</style>
</head>
<body>
<jsp:include page="../main/storeMain.jsp"/>
	<div class="reviewarea">
        <div class="review">
        	
        </div>
        <div class="reply">
        
        </div>
    </div>
</body>
<script>

</script>
</html>