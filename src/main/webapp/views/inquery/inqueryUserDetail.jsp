<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <meta charset="UTF-8">
    <title>SULBAZI 고객센터</title>
    <style>
        body {
            background-color: #00200e;
            color: #ffffff;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #E79A32;
            padding: 20px;
            border-radius: 10px;
        }
        .section {
            background-color: #00200e;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .header {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color:#000000;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-label {
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #070707;
        }
        .flex-group {
            display: flex;
            gap: 20px;
        }
        .flex-item {
            flex: 1;
        }
        .admin-response {
            background-color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            color: #000000;
        }
        .attached-files img {
            max-width: 100px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">고객센터</div>
        <div class="section">
            <form action="submitInquiry.jsp" method="post">
                <div class="form-group flex-group">
                    <div class="flex-item">
                        <label class="form-label" for="inquiryId">문의 ID</label>
                        <input type="text" id="inquiryId" name="inquiryId" class="form-control" value="burger" readonly>
                    </div>
                    <div class="flex-item">
                        <label class="form-label" for="inquiryDate">문의 일자</label>
                        <input type="text" id="inquiryDate" name="inquiryDate" class="form-control" value="24.10.10" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="inquiryTitle">문의 제목</label>
                    <input type="text" id="inquiryTitle" name="inquiryTitle" class="form-control" value="계정이 이상해요" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label" for="inquiryContent">문의 내용</label>
                    <textarea id="inquiryContent" name="inquiryContent" class="form-control" rows="4" readonly>계정이 이상해요 좀 봐주세요.</textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">첨부 파일</label>
                    <div class="attached-files">
                        <img src="file1.jpg" alt="첨부 파일 1">
                        <img src="file2.jpg" alt="첨부 파일 2">
                    </div>
                </div>
                <div class="form-group flex-group">
                    <div class="flex-item">
                        <label class="form-label">관리자</label>
                        <input type="text" value="admin" class="form-control" readonly>
                    </div>
                    <div class="flex-item">
                        <label class="form-label" for="responseDate">답변 날짜</label>
                        <input type="text" id="responseDate" name="responseDate" class="form-control" value="24.10.11" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">답변 내용</label>
                    <div class="admin-response">확인해보겠습니다.</div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>