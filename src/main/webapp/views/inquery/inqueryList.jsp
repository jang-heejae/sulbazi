<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.stateselect{
    display: flex;
    margin-bottom:0;
}
input{
    margin-left: 10;
    width: 0;
}
table{
    margin: auto;
    margin-left:auto; 
    margin-right:auto;
}
table,th, td{
    border: 1px solid rgb(255, 140, 9);
    border-collapse: collapse;
}
th{
    background-color: rgb(255, 140, 9);
}
label{
    height:30;
    width: 100;
    font-size: 16;
}
label.selected1{
    background-color: rgb(255, 140, 9);
}
</style>
</head>
<body>
    <div class="stateselect">
        <label class="selected1"><input class="custom-radio" type="radio" name="inquerystate"  value="false"/> 처리 중<br/></label>
        <label class="selected2"><input class="custom-radio" type="radio" name="inquerystate"  value="true"/> 처리 완료<br/></label>
    </div>
	<table>
		<thead>
			<tr>
				<th>문의자ID</th>
				<th>문의 제목</th>
				<th>문의 날짜</th>
				<th>처리상태</th>
				<th>처리자</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${inquerylist}" var="inquery">
			<tr>
				<td>${inquery.id_write}</td>
				<td><a href="inquerydetail.go?idx=${inquery.inquery_idx}">${inquery.inquery_subject}</a></td>
				<td>${inquery.inquery_date}</td>
				<td>${inquery.inquery_state}</td>
				<td><%-- ${inquery.reg_date} --%>관리자</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
<script>

</script>
</html>