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
            max-height: 800px;
            margin:250 auto;
            background-color: rgb(255, 140, 9);
            padding: 20px;
            border-radius: 10px;
            overflow-y: auto;
             -ms-overflow-style: none;
            margin-bottom: 100;
        }
        
        .container::-webkit-scrollbar { 
    		display: none;          /* Chrome, Safari에서 스크롤바 숨김 */
		}
        .section {
            background-color: #00200e;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            overflow-y: auto;
        }
        .header {
            text-align: center;
            font-size: 45px;
            font-weight: bold;
            color:#000000;
            padding-botton: 30;
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
            height:80;
        }
		img {
    		max-width: 100%; /* 이미지의 최대 너비를 부모 요소의 100%로 설정 */
    		height: auto;   
    		max-height: 200px; 
		}
		
div.include {
	display: flex;
	justify-content: center;
	align-items: center;
}

    </style>
</head>
<body>
<div class="include">
    <jsp:include page="../main/main.jsp"/>
</div >
    <div class="container">
        <div class="header">고객센터 <i class='fas fa-headphones' style='font-size:48px'></i></div>
        <div class="section">
            <form action="submitInquiry.jsp" method="post">
                <div class="form-group flex-group">
                    <div class="flex-item">
                        <label class="form-label" for="inquiryId">문의 ID</label>
                        <input type="text" id="inquiryId" name="inquiryId" class="form-control" value="${userinquerydetail.id_write}" readonly>
                    </div>
                    <div class="flex-item">
                        <label class="form-label" for="inquiryDate">문의 일자</label>
                        <input type="text" id="inquiryDate" name="inquiryDate" class="form-control" value="${userinquerydetail.inquery_date}" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="inquiryTitle">문의 제목</label>
                    <input type="text" id="inquiryTitle" name="inquiryTitle" class="form-control" value="${userinquerydetail.inquery_subject}" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label" for="inquiryContent">문의 내용</label>
                    <textarea id="inquiryContent" name="inquiryContent" class="form-control" rows="4" readonly>${userinquerydetail.inquery_content}</textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">첨부 파일</label>
                    <div>
						<c:forEach items="${userinquerydetailphoto}" var="inqueryfile">
							<img src="/photo/${inqueryfile.new_filename}"><br/>
						</c:forEach>
                    </div>
                 </div>
				<c:forEach var="inqueryanswer" items="${answer}">
    				<c:set var="matchedAdminName" value="" />
    				<c:forEach var="answerad" items="${answeradmin}">
        				<c:if test="${inqueryanswer.admin_id == answerad.admin_id}">
            				<c:set var="matchedAdminName" value="${answerad.admin_name}" />
            				<c:set var="isMatched" value="true" />
            				<c:choose>
                				<c:when test="${isMatched == 'true'}">
                    				<div class="form-group flex-group">
                        				<div class="flex-item">
                            				<label class="form-label">관리자</label>
                            				<input type="text" value="${matchedAdminName}" class="form-control" readonly>
                        				</div>
                        				<div class="flex-item">
                            				<label class="form-label" for="responseDate">답변 날짜</label>
                            				<input type="text" id="responseDate" name="responseDate" class="form-control" value="${inqueryanswer.answer_date}" readonly>
                        				</div>
                    				</div>
                    				<div class="form-group">
                        				<label class="form-label">답변 내용</label>
                        				<div class="admin-response">${inqueryanswer.answer_content}</div>
                        				<br><hr/>
                    				</div>
                				</c:when>
            				</c:choose>
        				</c:if>
    				</c:forEach>
				</c:forEach>
            </form>
        </div>
    </div>
</body>
</html>