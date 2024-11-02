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
// 로그인된 사용자 ID와 문의 ID 변수
const my_id = '${sessionScope.loginId}';
const inquery_idx = document.getElementById('inqueryIdx').value;
const inquery_id = document.getElementById('inquiryId').value;

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
            inquirynewanswer(); // 성공 후 AJAX 호출
        })
        .catch(error => console.error("폼 제출 중 오류 발생:", error));
    } else {
        alert('등록이 취소되었습니다');
        event.preventDefault(); // 기본 폼 제출 이벤트 방지
    }
});





//AJAX 호출 함수
function inquirynewanswer() {
    $.ajax({
        type: 'POST',
        url: 'inquiryanswer.ajax',
        data: { 'my_id': my_id, 'inquery_idx': inquery_idx },
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터 객체 생성
            const newAlarm = {
                receiverId: inquery_id,
                chatroomname: alarmresponse.chatroomname,
                alarm: alarmresponse.alarm,
                alarm_idx: alarmresponse.alarm_idx
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
        url: '/notifications/send', // 알림을 전송할 서버 엔드포인트
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
    displayNotification(notification); // 화면에 알림 표시
}



























// AJAX 호출 함수
/*function inquirynewanswer() {
    $.ajax({
        type: 'POST',
        url: 'inquiryanswer.ajax',
        data: { 'my_id': my_id, 'inquery_idx': inquery_idx },
        dataType: 'JSON',
        success: function(alarmresponse) {
            // 알림 데이터를 객체로 정의하여 localStorage에 저장
            console.log(alarmresponse);
            const newAlarm = {
                receiverId: inquery_id,
                chatroomname: alarmresponse.chatroomname,
                alarm: alarmresponse.alarm,
                alarm_idx:alarmresponse.alarm_idx
            };
            addAlarm(newAlarm.receiverId, newAlarm); // addAlarm 함수를 호출하여 알림 추가
        },
        error: function(e) {
            console.error("AJAX 요청 실패:", e);
            console.log("응답 내용:", e.responseText);
        }
    });
}

function addAlarm(receiverId, newAlarm) {
    if (!receiverId || !newAlarm) {
        console.error("유효하지 않은 수신자 ID 또는 알림 데이터입니다.");
        return;
    }

    // 알림에 고유 ID 생성
    newAlarm.id = Date.now();

    // 수신자 ID를 기반으로 로컬 스토리지에서 해당 사용자 알림 목록 가져오기
    const alarmresponse = localStorage.getItem(receiverId);
    let alarms = alarmresponse ? JSON.parse(alarmresponse) : [];

    // 새로운 알림 추가
    alarms.push(newAlarm);
    
    // 수신자 ID로 알림 저장
    localStorage.setItem(receiverId, JSON.stringify(alarms)); // receiverId를 키로 사용해야 함

    console.log("알림이 로컬 스토리지에 저장되었습니다:", newAlarm);

    // 알림 표시 함수 호출 (필요한 경우)
    //displayNotifications(receiverId); // 추가된 알림을 화면에 표시
}
     // 로그인한 사용자에게만 알림 표시 (현재 사용자가 수신자인 경우만)
    if (receiverId === loggedInUserId) {
        displayNotifications(receiverId);
    } 
}*/
</script>
</html>