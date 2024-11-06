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
            max-height: 580px;
            margin: 150 auto;
            background-color: rgb(255, 140, 9);
            padding: 20px;
            border-radius: 10px;
            overflow-y: auto;
        }
         .container::-webkit-scrollbar { 
    		display: none;          /* Chrome, Safari에서 스크롤바 숨김 */
		}
        .section {
            background-color: #00200e;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
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
            height:93;
        }
		img {
    		max-width: 100%;
    		height: auto;   
    		max-height: 200px; 
		}
    </style>
</head>
<body>
<div style="display: flex; justify-content: center; align-items: center;">
    <c:choose>
    <c:when test="${sessionScope.opt == 'admin_log'}">
        <jsp:include page="../main/adminMain.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'user_log'}">
        <jsp:include page="../main/main.jsp" />
    </c:when>
    <c:when test="${sessionScope.opt == 'store_log'}">
        <jsp:include page="../main/storeMain.jsp" />
    </c:when>
</c:choose>
</div>
    <div class="container">
        <div class="header">고객센터<i class='fas fa-headphones' style='font-size:48px'></i></div>
        <div class="section">
            <form>
                <div class="form-group flex-group">
                    <div class="flex-item">
                        <label class="form-label" for="inquiryId">문의 ID</label>
                        <input type="text" id="inquiryId" name="inquiryId" class="form-control" value="${userinquerydetail.id_write}" readonly>
                    </div>
                    <div class="flex-item">
                        <label class="form-label" for="inquiryDate">문의 일자</label>
                        <input type="text" id="inquiryDate" name="inquiryDate" class="form-control" value="${userinquerydetail.inquery_date}"readonly>
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
			<form action="adminanswer.do" method="post">
    			<div class="admin-response">
    				 <input type="hidden" name="inqueryIdx" id="inqueryIdx" value="${userinquerydetail.inquery_idx}">
        			<textarea id="answer" name="answer" rows="5" style="width: 750px; max-width:750px; font-size:16;"></textarea>
    			</div>
    			<button type="submit" id="submitAnswer" style="margin-top: 5; font-size:16; padding: 5;">답변 등록</button>
			</form>
        </div>
    </div>
    

</body>
<script>




// 로그인된 사용자 ID와 문의 ID 변수
const my_id = '${sessionScope.loginId}';
const inquery_idx = document.getElementById('inqueryIdx').value;
const id_write = document.getElementById('inquiryId').value;

const form = document.querySelector("form[action='adminanswer.do']");
const btn = document.getElementById('submitAnswer');

// 폼 제출 처리
btn.addEventListener('click', function(event) {
    const result = confirm('등록하시겠습니까?');
    if (result) {
        alert('등록되었습니다');
        event.preventDefault(); // 기본 폼 제출 이벤트 방지

        const formData = new FormData(form);

        // Fetch API로 폼 제출
        fetch(form.action, {
            method: 'POST',
            body: formData,
        })
        .then(response => {
            if (!response.ok) throw new Error('네트워크 응답이 좋지 않습니다.');

            // 데이터 반환이 필요 없는 경우
            // JSON으로 응답을 처리하지 않고 그냥 response를 반환하도록 수정
            return response.text(); // 텍스트 응답으로 변경
        })
        .then(text => {
            console.log("폼 제출 성공:", text); // 서버에서 반환한 응답을 로그에 출력
            inquirynewanswer(id_write,inquery_idx); // 성공 후 AJAX 호출
            location.reload();
        })
        .catch(error => console.error("폼 제출 중 오류 발생:", error));
    } else {
        alert('등록이 취소되었습니다');
        event.preventDefault(); // 기본 폼 제출 이벤트 방지
    }
});





//AJAX 호출 함수
function inquirynewanswer(id_write,inquery_idx) {
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/inquiryanswer.ajax',
        data: { 'id_write': id_write,  //수신자 id
        		'inquery_idx': inquery_idx }, //문의 idx
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: id_write, //수신자 id
                chatroomname: alarmresponse.chatroomname,  //문의 제목
                alarm: alarmresponse.alarm, //알림 내용
                alarm_idx: alarmresponse.alarm_idx //알림 idx
            };
            sendNotification(newAlarm); // 알림 전송 함수 호출
            saveNotification(newAlarm); // 알림 저장 함수 호출
        },
        error: function(e) {
            console.error("AJAX 요청 실패:", e);
            console.log("응답 내용:", e.responseText);
        }
    });
}

// 서버에 알림 전송 함수
function sendNotification(newAlarm) {
    const receiverId = newAlarm.receiverId;

    // AJAX POST 요청을 통해 서버에 알림 전송
    $.ajax({
        type: 'POST',
        url: '/SULBAZI/notifications/send', // 알림을 전송할 서버 엔드포인트
        data: JSON.stringify(newAlarm),
        contentType: 'application/json',
        success: function(response) {
            console.log("알림이 성공적으로 전송되었습니다:", response);
        },
        error: function(e) {
            console.error("알림 전송 실패:", e);
        }
    });
}



function saveNotification(notification) {
    notificationsList.push(notification); // 새로운 알림을 배열에 추가
    console.log("저장된 알림:", notificationsList); // 디버깅: 저장된 알림 확인
    //displayNotification(notification); // 화면에 알림 표시
}

</script>
</html>