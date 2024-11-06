<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>고객센터</title>
<style>
/* 	body {
        background-color: #26320B;
        color: #F2A100;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    } */
    .container {
    	margin: auto;
    	margin-top:200;
        width: 800;
        background-color: rgb(255, 140, 9);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
        .header {
            text-align: center;
            font-size: 3em;
            margin-bottom: 20px;
            color:#000;
            font-weight: bold;

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
            font-size: 36px;
            margin-bottom: 20px;
            color: #ffffff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
/*             display: block; */
            margin-bottom: 10px;
            color: #ffffff;
        }
        .form-group textarea {
            width: 90%;
            padding: 10px;
            border: 1px solid #ffffff;
            border-radius: 4px;
            margin-bottom: 5px;
        }
        
        .form-group input[type="text"] {
            width: 83%;
            padding: 10px;
            border: 1px solid #ffffff;
            border-radius: 4px;
            margin-bottom: 5px;
        }


		 .form-group input[type="file"] {
            width: 93%;
            padding: 10px;
            border: 1px solid #0a1c06;
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
            padding: 12px 23px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 20px; 
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
            max-height: 300px;
            background-color: #0a1c06;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
             -ms-overflow-style: none;
        }
        
        .table-container::-webkit-scrollbar { 
    		display: none;          /* Chrome, Safari에서 스크롤바 숨김 */
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
            border-color:#0a1c06;
            color: white;
        }
        th {
            background-color: #FF6600;
            color: white;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        div.include {
			display: flex;
			justify-content: center;
			align-items: center;
		}
		
		label{
			font-size: 24;
		}
		.white-link {
		    color: white;
		}
		div.include {
			display: flex;
			justify-content: center;
			align-items: center;
		}
</style>
</head>
<body>
<jsp:include page="../main/main.jsp"/>

	<form action="userinqueryWrite.do" method="post" enctype="multipart/form-data">
    	<div class="container">
        	<div class="header">고객센터<i class='fas fa-headphones' style='font-size:48px'></i></div>
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
    	</div>
	</form>
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
            url: 'inqueryuserList.ajax',
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
            var state = '처리중';
            if (item.inquery_state == true) {
                state = '처리 완료';
            }
/* 
            // answeradmin 배열이 있는 경우, 첫 번째 관리자 이름을 가져옵니다.
            var adminName = '';
            if (item.answeradmin && item.answeradmin.length > 0) {
                adminName = item.answeradmin[0].admin_name;
            }

            console.log(adminName); */
            content += '<tr>';
            content += '<td>' + loginId + '</td>';
            content += '<td><a href="inqueryuserDetail.go?inqueryIdx=' + item.inquery_idx + '" class="white-link">' + item.inquery_subject + '</a></td>'; // 상세보기 링크 추가
            content += '<td><a href="inqueryuserDetail.go?inqueryIdx=' + item.inquery_idx + '" class="white-link">' + item.inquery_date + '</td>';
            content += '<td><a href="inqueryuserDetail.go?inqueryIdx=' + item.inquery_idx + '" class="white-link">' + state + '</td>';
            content += '<td>' + item.admin_name + '</td>'; // 관리자 이름 출력
            content += '</tr>';
        });
        console.log("갱신된 테이블 내용:", content);
        $('#list').html(content); // 테이블 업데이트
    }
</script>
</body>
</html>