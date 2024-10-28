<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<script src="resources/jquery.twbsPagination.js"></script>
<style>
        body{
            background-color: #041d03;
        }
        .back{
        	display: flex;
        	flex-direction: column;
            align-items: center;  
        	
        	/* overflow-y: auto; */
        	
        }
        div.filter{
       		display: flex;
		    flex-direction: column;
		    align-items: center;
            background-color: white;
            position: fixed;
            width: 220px;
            height: 700px;
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
            font-size: 18px;
            font-weight: 800;
            margin: 0px;
        }
        fieldset{
            border-color: white;
            margin: 0px 20px 0px 20px;
            width: 80%;
            height: 22%;
            border-bottom-color: rgb(255, 140, 9);
        }
        input[type="radio"] {
		    width: 16px; /* 너비 */
		    height: 16px; /* 높이 */
		    margin: 2px; /* 간격 조절 */
		    vertical-align: middle; /* 텍스트와 수직 중앙 정렬 */
		}

        #filtering{
            /* position: absolute; */
            right: 10px;
            background-color: rgb(255, 140, 9);
            /* color: black; */
            border-color: rgb(255, 140, 9);
            border-radius: 15px;
            font-weight: 800;
            padding: 5px;
            margin-top:-7px;
        	}
            .search-container {
                display: flex;
                align-items: center;
                width: 610px;
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
                /* position: relative; */
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
    			/* color: black; */
    			border-color: rgb(255, 140, 9);
    			border-radius: 20px;
    			/* font-weight: 500; */
    			/* padding: 5; */
                width: 54px;
                height: 37px;
                cursor: pointer;
                margin-left:5; 
            }
            .searchicon{
            	width: 25px;
            }
			.bodysize table,tr,td,th{
                border:1px solid black;
                border-collapse: collapse;
                width:100%;
                padding: 5px 10px;
            }
			main{
				display: flex;
				flex-direction: column;
                align-items: center;       
			    position: absolute;
			    top: 203px;
			    left: 50%;
			    transform: translateX(-50%);
			}
			.mapwhatname{
				margin: 0 0 20px 0 ;
				border-radius: 8px;
			}
			.bodysize{
				background-color: white;
				width: 788px;
				border-radius: 8px;
                display: flex;
                flex-direction: column;
                align-items: center; 
			}
			.filedA{
				height: 194px;
			}
			.filedB{
				height: 145px;
			}
			.filedC{
				height: 168px;
			}
			.container{
			    display: flex;
			    justify-content: center; 
			    align-items: center; 
			    width: 100%; 
    		}
    		.store-img{
    			width: 100px;
    			
    		}
			

</style>
</head>

<body>
	<jsp:include page="../main/main.jsp"/>
    <div class="back">
        <form>
            <div class="filter">
                <fieldset class="filedA">
                    <legend>주종</legend>
                    <input type="radio" name="alchol" value="1"/> 소주<br/>
                    <input type="radio" name="alchol" value="2"/> 맥주<br/>
                    <input type="radio" name="alchol" value="3"/> 양주<br/>
                    <input type="radio" name="alchol" value="5"/> 와인<br/>
                    <input type="radio" name="alchol" value="4"/> 막걸리<br/>
                    <input type="radio" name="alchol" value="6"/> 하이볼<br/>
                    <input type="radio" name="alchol" value="8"/> 기타
                </fieldset>
        
                <fieldset class="filedB">
                    <legend>안주</legend>
                    <input type="radio" name="food" value="7"/> 한식<br/>
                    <input type="radio" name="food" value="9"/> 양식<br/>
                    <input type="radio" name="food" value="10"/> 중식<br/>
                    <input type="radio" name="food" value="11"/> 일식<br/>
                    <input type="radio" name="food" value="12"/> 기타<br/>
                </fieldset>
        
                <fieldset class="filedC">
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
            	<button id="performSearch" class="search-button" type="button" >
            		<img class="searchicon" alt="serchicon" src="resources/img/serchicon.png">
            	</button>
        	</div>
    	</div>
	</form>
	
	<main>
	         	   <!-- 지도 영역 -->
	    <div class="mapwhatname" id="map" style="width:789px;height:320px;"></div>
	    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4ae2258b561b1a937e5d3f2c155e60f9"></script>
	    <!-- 매장리스트 -->
	    <div class="bodysize">
			<table class="list-table">
				<tbody id="list" >
	
				</tbody>
				<tr>
					<th colspan="2">
						<div class="container">
				    		<nav aria-label="Page navigation">
				        		<ul class="pagination" id="pagination"></ul>
				    		</nav>
						</div>
					</th>
				</tr>
			</table>
		</div>
	</main>
	

</body>
<script>
		var loginId = '${sessionScope.loginId}';
		
		/* 지도 영역 */
		var container = document.getElementById('map');

		    
		var options = {
		    center: new kakao.maps.LatLng(37.534779, 126.994553),
		    level: 3
		};
		
		var map = new kakao.maps.Map(container, options);
		var markers = []; // 마커를 저장할 배열
		
		/* 리스트 페이징  */
		var show = 1;
		
		pageCall(show);

	function pageCall(page) {
		
	    var center = map.getCenter(); // 지도 중심 좌표 가져오기
	    var centerLat = center.getLat();
	    var centerLng = center.getLng();
	    var latDiff = 0.0045;
	    var lngDiff = 0.0045;
	    
	    
		$.ajax({
			type:'GET',
			url:'list.ajax',
			data:{
				'page':page,
				'cnt':5,
	            'minLat': centerLat - latDiff,
	            'maxLat': centerLat + latDiff,
	            'minLng': centerLng - lngDiff,
	            'maxLng': centerLng + lngDiff
			},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				if (data.list && data.list.length) {
					drawList(data.list , data.photos , data.categoryOpts, data.storeCategorys)
					drawMarkers(data.list);
					console.log(data.list)
					console.log(data.list.length)
					$('#pagination').twbsPagination({ // 페이징 객체 만들기
						startPage:1, 
	            		totalPages:data.totalpages, 
	            		visiblePages:5,
	            		onPageClick:function(evt,page){
	            			console.log('evt',evt); 
	            			console.log('page',page); 
	            			pageCall(page);
	            		}
					});
					
				}else {
					showNoStoresMessage();
				}
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	// 매장 리스트를 표시하는 함수
	function drawList(storeList,photos,categoryOpts,storeCategorys) {
	    var listContainer = document.getElementById('list');
	    listContainer.innerHTML = '';
	
	    storeList.forEach(function(store, idx) {
	        // 각 store에 대한 HTML 구조를 생성
	        /* var photo = photos[idx]; */
	        var photo = photos.find(function(p) {
	        	/* p는 포토 리스트의 photo 들이다 */
	            return p.photo_folder_idx === store.store_idx;
	        });
	        
	        var storeCategory = storeCategorys.find(function(sc){
	        	return sc.store_idx === store.store_idx;
	        });
	        
	        var categoryOpt = categoryOpts.find(function(co){
	        	return co.opt_idx === storeCategory.opt_idx;
	        });
	        
	        
	        
	        var content ='<tr>'
	            content +='<td class="store-img">'
	            content +='<img src="/photo/'+photo.new_filename+'" alt="'+store.store_name+'" width="95px" height="95px">'
	            content +='</td>'
	            content +='<td>'
	            content +='<h3>'+store.store_name+'</h3>'
	            content +='<div class="store-rating">'
	            content +='<span>⭐'+ store.star_average +' ('+ store.review_total+')명</span>'
	            content +='</div>'
	            content +='<div class="categories">'
/* 	            content += '<p>' + categoryOpt.opt_name + '</p>'; */
	            content +='</div>'
	            content +='<p>'+store.store_address+'</p>'
	            content +='</td>'
	            content +='</tr>';
	
	        // 각 store의 categories를 순회하여 추가
/* 	        store.categories.forEach(function(category) {
	            if (category.category_idx == 1) {
	                content += `# ${category.opt_name} <br/>`;
	            } else if (category.category_idx == 2) {
	                content += `# ${category.opt_name} <br/>`;
	            } else if (category.category_idx == 3) {
	                content += `# ${category.opt_name} <br/>`;
	            } else if (category.category_idx == 4) {
	                content += `# ${category.opt_name} <br/>`;
	            }
	        }); */
	
	
	        // 생성된 HTML을 리스트 컨테이너에 추가
	        listContainer.innerHTML += content;
	    });
	}
	
	/* 노매장 */
	function showNoStoresMessage() {
	    var listContainer = document.getElementById('list');
	    listContainer.innerHTML = `
	        <tr>
	            <td colspan="2" style="text-align: center; padding: 20px;">
	                매장 리스트가 없습니다.
	            </td>
	        </tr>
	    `;
	}

	// 지도에 마커를 표시하는 함수
	function drawMarkers(storeList) {
	    // 기존 마커 제거
	    markers.forEach(function(marker) {
	        marker.setMap(null);
	    });
	    markers = [];

	    storeList.forEach(function(store) {
	        var markerPosition = new kakao.maps.LatLng(store.latitude, store.longitude);
	        var marker = new kakao.maps.Marker({
	            position: markerPosition
	        });

	        marker.setMap(map);
	        markers.push(marker);
	    });
	}
	



//필터링
$('#filtering').click(function() {
	var alchol = $(':input:radio[name=alchol]:checked').val();
	var food = $(':input:radio[name=food]:checked').val();
	var mood = $(':input:radio[name=mood]:checked').val();
	var visit = $(':input:radio[name=visit]:checked').val();
	console.log(alchol);
	console.log(food);
	console.log(mood);
	console.log(visit);
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