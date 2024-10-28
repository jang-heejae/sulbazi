<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<body>
    <body>
    <h2>비밀번호 변경</h2>
    <form action="changepw.do" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="findtype" value="${findtype}"/>
        <input type="hidden" name="identifier" value="${identifier}"/>
        
        <div>
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" required/>
        </div>
        
        <div>
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required/>
        </div>
        
        <div id="errorMessage" style="color: red; display: none;">
            비밀번호가 틀렸습니다.
        </div>
        
        <button type="submit" >비밀번호 변경</button>
    </form>
    
    <script>
        function validateForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorMessage = document.getElementById('errorMessage');
            
            if (newPassword !== confirmPassword) {
                errorMessage.style.display = 'block';  // 오류 메시지 보이기
                return false;  // 폼 제출 중단
            }
            alert("비밀번호가 변경되었습니다.");  // 성공 메시지
            return true;  // 폼 제출 허용
        }
    </script>
</body>
</body>
<script>

</script>
</html>