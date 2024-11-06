<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="js/jquery.twbsPagination.js" type="text/javascript"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap');
body {

	background-color: #041d03;
	
}

    table {
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid black;
        padding: 10px;
        text-align: left;
    }   
    #imgview {
        width: 150px;
        height: 150px;
    }
    td > p{
    	color: white;
    }
    .bodySize{
    	display: flex;
        flex-direction: column;
        align-items: center;
    	
    }
    h1{
    	
    	color: white;
    }
.custombutton {
  width: 130px;
  height: 75px;
  color: #fff;
  border-radius: 5px;
  padding: 10px 25px;
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  outline: none;
}
.back-button{
  background: linear-gradient(0deg, rgb(162 127 81) 0%, rgb(154 99 0) 100%);
  border: none;
}
.back-button:hover {
	background: linear-gradient(0deg, rgb(255 215 19) 0%, rgb(175 168 0) 100%);
}
.bodySize {
font-family: "Yeon Sung", system-ui;
}


 

    

</style>

</head>
<body>

	<div class="bodySize">
	    <h1>안주 목록</h1>

<%-- 	    <button class="custombutton back-button" onclick="location.href='storeDetail.do?storeidx=${store}'">상세보기로 돌아가기</button>
 --%>	  <!--   <button id="custombutton" >상세보기로 돌아가기</button> -->
	    <table>
	        <tbody>
	            <c:if test="${files.size() > 0 && storeMenu.size() > 0}">
	                <!-- 두 리스트가 같은 크기일 때만 처리 -->
					<c:forEach var="file" items="${files}" varStatus="status">
					    <!-- 같은 인덱스의 storeMenu 항목을 사용 -->
						<tr>
						    <!-- 이미지 표시 -->
						    <td><img src="/photo/${file.new_filename}" alt="Store Photo" id="imgview" /></td>
						    <!-- 메뉴 이름 및 가격 -->
						    <td><p>${storeMenu[status.index].menu_name}</p></td>
						    <td><p>${storeMenu[status.index].menu_price}</p></td>
						</tr>
					</c:forEach>
	            </c:if>
	        </tbody>
	    </table>
	    
	</div>    
</body>


<script>

</script>
</html>
