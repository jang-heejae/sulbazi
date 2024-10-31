<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="menuHub" style="width: 200px; height: 100px; background-color: #f0f0f0;"></div>
	
<script>
var content = '';
content += '<button onclick="location.href=\'boardList.go\'">멤버리스트</button>';
content += '<button onclick="location.href=\'boardList.go\'">멤버리스트</button>';
content += '<button onclick="location.href=\'memberList.go\'">회원리스트</button>';

someDraw(content);


	function someDraw() {
	    $('#menuHub').append(content);
	}	  
</script>