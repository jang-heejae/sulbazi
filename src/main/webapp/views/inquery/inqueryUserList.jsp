<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>고객센터</title>
<style>
	body {
        background-color: #26320B;
        color: #F2A100;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        width: 60%;
        background-color: rgb(255, 140, 9);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
        .header {
            text-align: center;
            font-size: 2em;
            margin-bottom: 20px;
            color:#000;

        }
        .back {
            margin-bottom: 20px;
        }
        .customer-service {
            background-color: #041d03;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .customer-service .title {
            font-size: 1.5em;
            margin-bottom: 20px;
            color: #ffffff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #ffffff;
        }
        .form-group input[type="text"], .form-group textarea {
            width: 90%;
            padding: 10px;
            border: 1px solid #ffffff;
            border-radius: 4px;
            margin-bottom: 5px;
        }
        .form-group form{
            right:0;
        }
        .actions {
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .actions .register {
            background-color: #FF6600;
            color: #fff;
        }
        .actions .cancel {
            background-color: #ccc;
            color: #000;
        }
        .table-container {
            margin-top: 20px;
            border-radius: 10px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #FF6600;
            color: white;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
</style>
</head>
<body>
	<form action="userinquerywrite.do" method="post" enctype="multipart/form-data">
    	<div class="container">
        	<div class="header">고객센터</div>
        	<div class="back">
            	<div class="customer-service">
                	<div class="title">내 문의 사항</div>
                	<div class="form-group">
                    	<label>제목</label>
                    	<input type="text" placeholder="제목을 입력하세요" name="inquerysubject" value="">
                	</div>
                	<div class="form-group">
                    	<textarea id="inquiryContent" name="inquerycontent" rows="4" placeholder="내용을 입력하세요" value=""></textarea>
						<input type="file" name="inqueryfiles" multiple="multiple"/>
                	</div>
                	<div>
                    	<button type="button">등록</button>
                	</div>
            	</div>
        	</div>
    	</div>
	</form>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>문의자ID</th>
                        <th>문의제목</th>
                        <th>문의 날짜</th>
                        <th>처리상태</th>
                        <th>처리자</th>
                    </tr>
                </thead>
                <tbody id="list">

                </tbody>
            </table>
        </div>
        <div class="pagination"></div>
</body>
<script>
var loginId = '${sessionScope.loginId}';
var btn = document.getElementsByTagName('button');
btn[0].addEventListener('click', function(event) {
    var result = confirm('등록하시겠습니까?');
    console.log(result);
    if (result == true) {
        alert('등록되었습니다');
        $('form')[0].submit();// 폼을 수동으로 제출합니다.
    } else {
    	addquery();
    }
});
	
addquery(); // 리스트 업데이트 함수 호출
    function addquery() {
        $.ajax({
            type: 'GET',
            url: 'userlistinquery.ajax',
            data: {},
            dataType: 'JSON',
            success: function(data) {
                console.log("데이터 수신 성공:", data);
                if (data && data.list && Array.isArray(data.list)) {
                    drawList(data.list);
                } else {
                    console.log("유효한 리스트가 없습니다.");
                }
            },
            error: function(e) {
                console.log("AJAX 요청 실패:", e);
            }
        });
    }

        function drawList(list) {
            var content = '';
            list.forEach(function(item, idx) {
            	var state ='처리중';
            	if(item.inquery_state == true) {
            		state = '처리 완료';
            	}
                content += '<tr>';
                content += '<td>' + loginId + '</td>';
                content += '<td>' + item.inquery_subject + '</td>';
                content += '<td>' + item.inquery_date + '</td>';
                content += '<td>' + state + '</td>';
                content += '<td>' + '관리자' + '</td>';
                content += '</tr>';
            });
            console.log("갱신된 테이블 내용:", content);
            $('#list').html(content); // 테이블 업데이트
        }
</script>
</body>
</html>