<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
        body{
            background-color: #041d03;
        }
        .back{
        	overflow-y: auto;
        }
        div.filter{
            background-color: white;
            position: fixed;
            width: 220;
            height: 700;
            left: 363px;
            top: 200;
            border-radius: 15px;
        }
        input{
            font-size: 15px;
            margin-top:-1px; 
            vertical-align:middle;
        }
        legend{
            font-size: 23px;
            font-weight: 800;
        }
        fieldset{
            border-color: white;
            margin: auto;
            margin-bottom: 5;
            margin-top: 5;
            width: 170;
            border-bottom-color: rgb(255, 140, 9);
        }
        #filtering{
            position: absolute;
            right: 10px;
            background-color: rgb(255, 140, 9);
            color: black;
            border-color: rgb(255, 140, 9);
            border-radius: 15px;
            font-weight: 800;
            padding: 5;
            margin-top:5;
        	}
            .search-container {
                display: flex;
                align-items: center;
                width: 500px;
                margin: 20px auto;
                left: 630px;
    			position: absolute;
    			top: 100px;
            }
            .search-select {
                padding: 8px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 15px;
            }
            .search-wrapper {
                position: relative;
                margin-left: 10px;
            }
            .search-input {
                width: 450;
                padding: 8px 40px 8px 8px; /* 오른쪽 여백을 추가해 아이콘과 겹치지 않도록 */
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 15px;
            }
            .search-button {
                position: absolute;
    			background-color : rgb(255, 140, 9);
    			color: black;
    			border-color: rgb(255, 140, 9);
    			border-radius: 15px;
    			font-weight: 500;
    			padding: 5;
                width: 30px;
                height: 30px;
                cursor: pointer;
                margin-left:5; 
            }

</style>
</head>

<body>
	<jsp:include page="../main/main.jsp"/>
    <div class="back">
        <form>
            <div class="filter">
                <fieldset>
                    <legend>주종</legend>
                    <input type="radio" name="alchol" value="1"/> 소주<br/>
                    <input type="radio" name="alchol" value="2"/> 맥주<br/>
                    <input type="radio" name="alchol" value="3"/> 양주<br/>
                    <input type="radio" name="alchol" value="5"/> 와인<br/>
                    <input type="radio" name="alchol" value="4"/> 막걸리<br/>
                    <input type="radio" name="alchol" value="6"/> 하이볼<br/>
                    <input type="radio" name="alchol" value="8"/> 기타
                </fieldset>
        
                <fieldset>
                    <legend>안주</legend>
                    <input type="radio" name="food" value="7"/> 한식<br/>
                    <input type="radio" name="food" value="9"/> 양식<br/>
                    <input type="radio" name="food" value="10"/> 중식<br/>
                    <input type="radio" name="food" value="11"/> 일식<br/>
                    <input type="radio" name="food" value="12"/> 기타<br/>
                </fieldset>
        
                <fieldset>
                    <legend>분위기</legend>
                    <input type="radio" name="mood" value="13"/> 조용한<br/>
                    <input type="radio" name="mood" value="14"/> 시끌벅적한<br/>
                    <input type="radio" name="mood" value="15"/> 고급스러운<br/>
                    <input type="radio" name="mood" value="16"/> 이색적인<br/>
                    <input type="radio" name="mood" value="17"/> 가성비좋은<br/>
                    <input type="radio" name="mood" value="18"/> 기타<br/>
                </fieldset>
        
                <fieldset>
                    <legend>방문목적</legend>
                    <input type="radio" name="visit" value="19"/> 혼술<br/>
                    <input type="radio" name="visit" value="20"/> 데이트<br/>
                    <input type="radio" name="visit" value="21"/> 회식<br/>
                    <input type="radio" name="visit" value="22"/> 모임<br/>
                    <input type="radio" name="visit" value="23"/> 기타<br/>
                </fieldset>
                <button type ="button" id="filtering">필터 적용</button>
            </div>
        </form>
    </div>
	<form>
    	<div class="search-container">
        	<select class="search-select" id="searchCategory">
            	<option value="menu">메뉴</option>
            	<option value="name">매장이름</option>
            	<option value="addr">매장 주소</option>
        	</select>
        	<div class="search-wrapper">
            	<input type="text" class="search-input" id="searchQuery" placeholder="검색어를 입력하세요">
            	<button class="search-button" type="button" id="performSearch"><div class="searchicon">⌕</div></button>
        	</div>
    	</div>
    	
	</form>

</body>
<script>
//필터링
$('#filtering').click(function() {
	var alchol = $('input[name="alchol"]').val();
	var food = $('input[name="food"]').val();
	var mood = $('input[name="mood"]').val();
	var visit = $('input[name="visit"]').val();
	console.log(alchol);
    $.ajax({
        type:'POST',  //method
        url:'filtering.ajax',  //요청 주소
        data:{'alchol' :alchol,
        		'food' : food,
        		 'mood' :mood,
        		 'visit' :visit},   //파라메터
        dataType:'JSON',  //받을 데이터 타입
        success:function(data) {   //성공했을 경우(받을 데이터)
            console.log(data);
        },
        error:function(e) {  //실패했을 경우(실패 내용)
            console.log(e)
        }
    });
})



//검색
$('#performSearch').click(function() {
	var category = document.getElementById("searchCategory").value;
	var keyword = document.getElementById("searchQuery").value;
	console.log(category);
	console.log(keyword);
    $.ajax({
        type:'GET',  //method
        url: category+'search.ajax',  //요청 주소
        data:{'keyword' :keyword},   //파라메터
        dataType:'JSON',  //받을 데이터 타입
        success:function(data) {   //성공했을 경우(받을 데이터)
            console.log(data);
        },
        error:function(e) {  //실패했을 경우(실패 내용)
            console.log(e)
        }
    });
})
</script>
</html>