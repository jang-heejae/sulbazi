<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page session="true" %>
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
		img {
    		max-width: 100%;
    		height: auto;   
    		max-height: 200px; 
		}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">고객센터</div>
        <div class="section">
            <form>
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
                    				</div>
                				</c:when>
            				</c:choose>
        				</c:if>
    				</c:forEach>
				</c:forEach>
            </form>
			<form action="adminanswer.do" method="post">
    			<div class="admin-response">
    				 <input type="hidden" name="inqueryIdx" id="inqueryIdx" value="${userinquerydetail.inquery_idx}">
        			<textarea id="answer" name="answer" rows="3" style="width: 722px; max-width:722px;"></textarea>
    			</div>
    			<button type="submit" id="submitAnswer" style="margin-top: 5;">답변 등록</button>
			</form>
        </div>
    </div>
    

</body>
<script>
var my_id = '${sessionScope.loginId}';
var inquery_idx = document.getElementById('inqueryIdx').value;
var inquery_id = 
var btn = document.getElementById('submitAnswer');
var form = document.querySelector("form[action='adminanswer.do']");

btn.addEventListener('click', function(event) {
    var result = confirm('등록하시겠습니까?');
    if (result == true) {
        alert('등록되었습니다');
        event.preventDefault(); // 기본 제출 방지

        // 폼 데이터 수집
        var formData = new FormData(form); 

        // Fetch API로 폼 제출
        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('네트워크 응답이 좋지 않습니다.');
            }
            return response.json(); // JSON으로 응답 받기
        })
        .then(data => {
            console.log("폼 제출 성공:", data);
            // AJAX 호출
            inquirynewanswer(); // 성공 후 AJAX 호출
        })
        .catch((error) => {
            console.error("폼 제출 중 오류 발생:", error);
        });
    } else {
        alert('등록이 취소되었습니다');
        event.preventDefault(); // 등록 취소 시 폼 제출 방지
    }
});

// AJAX 호출 함수
function inquirynewanswer() {
    $.ajax({
        type: 'POST',
        url: 'inquiryanswer.ajax',
        data: {'my_id': my_id, 'inquery_idx': inquery_idx},
        dataType: 'JSON',
        success: function(alarmresponse) {
            const newAlarm = alarmresponse;
            addAlarm(newAlarm); // 알림 추가
        },
        error: function(e) {
            console.log("AJAX 요청 실패:", e);
            console.log("응답 내용:", e.responseText); // 응답 내용 출력
        }
    });
}
</script>
</html>