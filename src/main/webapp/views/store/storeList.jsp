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

      .back {
          display: flex;
          flex-direction: column;
          align-items: center;
          background-color: white;
          position: absolute;
          width: 242px;
          height: auto;
          left: 284px;
          top: 201px;
          border-radius: 15px;
          padding: 20px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }
      
      
      div.filter {
          display: flex;
          flex-direction: column;
          width: 100%;
          gap: 20px;
      }
      
              input{
                  font-size: 15px;
                  margin-top:-1px; 
                  vertical-align:middle;
              }
      legend {
          font-size: 16px;
          font-weight: bold;
          color: #333;
          padding: 0 5px;
      }
      fieldset {
          border: 1px solid #ddd;
          border-radius: 10px;
          padding: 10px;
          width: 100%;
      }
      input[type="radio"] {
          margin-right: 5px;
          cursor: pointer;
      }
      input {
          font-size: 14px;
      }
      
      
      #filtering {
          background-color: rgb(255, 140, 9);
          border: none;
          color: white;
          border-radius: 20px;
          font-weight: bold;
          padding: 10px 20px;
          cursor: pointer;
          margin-top: 10px;
          transition: background-color 0.3s ease;
          width: 100%;
      }
      #filtering:hover {
          background-color: rgb(255, 120, 0);
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
          margin-left: 10px;
      }
      .search-input {
          width: 450px;
          padding: 8px 40px 8px 8px;
          font-size: 16px;
          border: 1px solid #ccc;
          border-radius: 15px;
      }
      .search-button {
          position: absolute;
          background-color: rgb(255, 140, 9);
          border: none;
          border-radius: 20px;
          width: 54px;
          height: 42px;
          transition: background-color 0.3s ease;
          cursor: pointer;
          margin-left: 5px;
      }
      
      .search-button:hover {
          background-color: rgb(255, 120, 0);
      }
           
      .searchicon {
          width: 25px;
      }
      .bodysize table, tr, td, th {
          border: 1px solid black;
          border-collapse: collapse;
          width: 100%;
          padding: 5px 10px;
      }
      main {
          display: flex;
          flex-direction: column;
          align-items: center;
          position: absolute;
          top: 203px;
          left: 50%;
          transform: translateX(-50%);
      }
      .mapwhatname {
          margin: 0 0 20px 0;
          border-radius: 8px;
      }
      .bodysize {
          background-color: white;
          width: 788px;
          border-radius: 8px;
          display: flex;
          flex-direction: column;
          align-items: center;
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
      .categories{
          width: 100%;
          height:100%;
      }
      .categories p{
          display:inline-block;
          margin: 0 0;
          color: #BDBDBD;
      }
      h3 {
          cursor: pointer;
      }
      
      h3:hover {
          color: purple;
      }
      .hover-td:hover {
          background-color: #f0f0f0;
      }
         

		.back {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    background-color: white;
		    position: absolute;
		    width: 242px;
		    height: auto;
		    left: 284px;
		    top: 201px;
		    border-radius: 15px;
		    padding: 20px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		
		div.filter {
		    display: flex;
		    flex-direction: column;
		    width: 100%;
		    gap: 20px;
		}
		
		        input{
		            font-size: 15px;
		            margin-top:-1px; 
		            vertical-align:middle;
		        }
		legend {
		    font-size: 16px;
		    font-weight: bold;
		    color: #333;
		    padding: 0 5px;
		}
		fieldset {
		    border: 1px solid #ddd;
		    border-radius: 10px;
		    padding: 10px;
		    width: 100%;
		}
		input[type="radio"] {
		    margin-right: 5px;
		    cursor: pointer;
		}
		input {
		    font-size: 14px;
		}
		
		
		#filtering {
		    background-color: rgb(255, 140, 9);
		    border: none;
		    color: white;
		    border-radius: 20px;
		    font-weight: bold;
		    padding: 10px 20px;
		    cursor: pointer;
		    margin-top: 10px;
		    transition: background-color 0.3s ease;
		    width: 100%;
		}
		#filtering:hover {
		    background-color: rgb(255, 120, 0);
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
		    margin-left: 10px;
		}
		.search-input {
		    width: 450px;
		    padding: 8px 40px 8px 8px;
		    font-size: 16px;
		    border: 1px solid #ccc;
		    border-radius: 15px;
		}
		.search-button {
		    position: absolute;
		    background-color: rgb(255, 140, 9);
		    border: none;
		    border-radius: 20px;
		    width: 54px;
		    height: 42px;
		    transition: background-color 0.3s ease;
		    cursor: pointer;
		    margin-left: 5px;
		}
		
		.search-button:hover {
		    background-color: rgb(255, 120, 0);
		}
		     
		.searchicon {
		    width: 25px;
		}
		.bodysize table, tr, td, th {
		    border: 1px solid black;
		    border-collapse: collapse;
		    width: 100%;
		    padding: 5px 10px;
		}
		main {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    position: absolute;
		    top: 203px;
		    left: 50%;
		    transform: translateX(-50%);
		}
		.mapwhatname {
		    margin: 0 0 20px 0;
		    border-radius: 8px;
		}
		.bodysize {
		    background-color: white;
		    width: 788px;
		    border-radius: 8px;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
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
		.categories{
		    width: 100%;
		    height:100%;
		}
		.categories p{
		    display:inline-block;
		    margin: 0 0;
		    color: #BDBDBD;
		}
		h3 {
		    cursor: pointer;
		}
		
		h3:hover {
		    color: purple;
		}
		.hover-td:hover {
		    background-color: #f0f0f0;
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
               <c:forEach var="option" items="${options}">
                   <c:if test="${option.category_idx == 1}">
                       <input type="radio" name="alchol" value="${option.opt_idx}" /> ${option.opt_name} <br/>
                   </c:if>
               </c:forEach>
           </fieldset>
   
           <fieldset class="filedB">
               <legend>안주</legend>
               <c:forEach var="option" items="${options}">
                   <c:if test="${option.category_idx == 2}">
                       <input type="radio" name="food" value="${option.opt_idx}" /> ${option.opt_name} <br/>
                   </c:if>
               </c:forEach>
           </fieldset>
   
           <fieldset class="filedC">
               <legend>분위기</legend>
               <c:forEach var="option" items="${options}">
                   <c:if test="${option.category_idx == 3}">
                       <input type="radio" name="mood" value="${option.opt_idx}" /> ${option.opt_name} <br/>
                   </c:if>
               </c:forEach>
           </fieldset>
   
           <fieldset class="filedD">
               <legend>방문목적</legend>
               <c:forEach var="option" items="${options}">
                   <c:if test="${option.category_idx == 4}">
                       <input type="radio" name="visit" value="${option.opt_idx}" /> ${option.opt_name} <br/>
                   </c:if>
               </c:forEach>
           </fieldset>
           <button type="button" id="filtering">필터 적용</button>
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
      

		var loginId = '${sessionScope.loginId}';
		
		/* 지도 영역 */
		var container = document.getElementById('map');


      
/*       //매장 테이블 호버시 지도 위치 이동
      function moveMapCenter(lat, lng) {
          var newCenter = new kakao.maps.LatLng(lat, lng);
          map.setCenter(newCenter);
      } */
      
      var map = new kakao.maps.Map(container, options);
      var markers = []; // 마커를 저장할 배열
      
      // 마우스 호버 맵 이동
      // 기본 중심 위치를 저장
      var defaultCenter = map.getCenter();


      
      
      
      
      
      
      
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
            /* console.log(data); */
            if (data.list && data.list.length) {
               drawList(data.list , data.photos , data.categoryOpts , data.storeCategorys)
               drawMarkers(data.list);
               /* console.log(data.list)
               console.log(data.list.length) */
               $('#pagination').twbsPagination({ // 페이징 객체 만들기
                  startPage:1, 
                     totalPages:data.totalpages, 
                     visiblePages:5,
                     onPageClick:function(evt,page){
                        /* console.log('evt',evt); 
                        console.log('page',page);  */
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
/*            var photo = photos.find(function(p) {
               return p.photo_folder_idx === store.store_idx;
           }); */

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
				/* console.log(data); */
				if (data.list && data.list.length) {
					drawList(data.list , data.photos , data.categoryOpts , data.storeCategorys)
					drawMarkers(data.list);
					/* console.log(data.list)
					console.log(data.list.length) */
					$('#pagination').twbsPagination({ // 페이징 객체 만들기
						startPage:1, 
	            		totalPages:data.totalpages, 
	            		visiblePages:5,
	            		onPageClick:function(evt,page){
	            			 /* console.log('evt',evt); 
	            			console.log('이종원 page',page);  */ 
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
/* 	        var photo = photos.find(function(p) {
	            return p.photo_folder_idx === store.store_idx;
	        }); */


           if (Array.isArray(photos)) {
               var photo = photos.find(function(p) {
                   return p.photo_folder_idx === store.store_idx;
               });
           } else {
               console.warn("photos가 배열이 아닙니다.", photos);
               
               
           }
           
            var relatedCategoryOpts = categoryOpts.filter(function(categoryOpt) {
               return storeCategorys.some(function(storeCategory) {
                   return storeCategory.store_idx === store.store_idx && storeCategory.opt_idx === categoryOpt.opt_idx;
               });
           }); 
           

           
           var content ='<tr>'
               content +='<td class="store-img">'
               content +='<img src="/photo/'+photo.new_filename+'" alt="'+store.store_name+'" width="95px" height="95px">'
               content +='</td>'
               content +='<td  class="hover-td" data-lat="'+store.store_latitude+'" data-lng="'+store.store_longitude+'">'
               content += '<h3 class="store-name" data-store-idx="' + store.store_idx +'"  onclick="location.href=\'storeDetail.do?storeidx=' + store.store_idx + '\'">'+ store.store_name + '</h3>';
               
               
               content +='<div class="store-rating">'
               content +='<span>⭐'+ store.star_average +' ('+ store.review_total+')명</span>'
               content +='</div>'
               content +='<div class="categories">'

/*                    for (var i = 0; i < Math.min(relatedCategoryOpts.length, 4); i++) {
                       content += '<p>' + '&nbsp; #'+relatedCategoryOpts[i].opt_name + '</p>';
                   } */
                   relatedCategoryOpts.slice(0, 4).forEach(function(opt) {
                       content += '<p>&nbsp;#' + opt.opt_name + '</p>';
                   });
               
               
               content +='</div>'
               content +='<p>'+store.store_address+'</p>'
               content +='</td>'
               content +='</tr>';
   
   
           // 생성된 HTML을 리스트 컨테이너에 추가
           listContainer.innerHTML += content;
       });
       
      // 모든 .hover-td 클래스에 대해 이벤트 리스너 추가
      document.querySelectorAll('.hover-td').forEach(function(td) {
          td.addEventListener('mouseenter', function() {
              // td의 data 속성에서 위도, 경도 값 가져오기
              var lat = parseFloat(td.getAttribute('data-lat'));
              var lng = parseFloat(td.getAttribute('data-lng'));
              map.setCenter(new kakao.maps.LatLng(lat, lng));
          });
          
/*           td.addEventListener('mouseleave', function() {
              // 지도 중심을 기본 위치로 되돌림
              map.setCenter(defaultCenter);
          }); */
      });
       
       // h3 요소에 마우스 호버 이벤트 추가
       document.querySelectorAll('.store-name').forEach(function(element) {
           var storeIdx = element.getAttribute('data-store-idx');
/*            if (Array.isArray(markers)) {
               var markerObj = markers.find(function(marker) {
                   return marker.someCondition; // 원하는 조건
               });
           } else {
               console.warn("markers가 배열이 아닙니다.", markers);
           } */
            var markerObj = markers.find(function(marker) {
                return marker.storeIdx === storeIdx;
            });
           
           if (markerObj) {
               // 마우스 오버 시 인포윈도우 표시
               element.addEventListener('mouseover', function() {
                   markerObj.infoWindow.open(map, markerObj.marker);
               });

               // 마우스 아웃 시 인포윈도우 닫기
               element.addEventListener('mouseout', function() {
                   markerObj.infoWindow.close();
               });
           }
       });

       
   }
   
   /* 노매장 */
   function showNoStoresMessage() {
       var listContainer = document.getElementById('list');
       listContainer.innerHTML = '
           <tr>
               <td colspan="2" style="text-align: center; padding: 20px;">
                   매장 리스트가 없습니다.
               </td>
           </tr>
       ';
   }
   
   
   
/*    //중복마커 지우기
   var storeIdxSet = new Set(); */
   
   function drawMarkers(storeList) {
       // 기존 마커 제거
          markers.forEach(function(markerObj) {
           markerObj.marker.setMap(null);
       });  
        markers = [];
       
       
       
/*         //중복마커 지우기
          markers.forEach(function(markerObj) {
              markerObj.marker.setMap(null);
          });
          markers = [];
          storeIdxSet.clear(); */
      

       storeList.forEach(function(store) {
           var markerPosition = new kakao.maps.LatLng(store.store_latitude, store.store_longitude);
           
           // 마커 생성 (일반 마커 사용)
            var marker = new kakao.maps.Marker({
               position: markerPosition,
               map: map // 마커를 생성할 때 지도에 바로 추가
           });  
           
/*            //중복마커 지우기
           // store_idx 중복 여부 확인
           if (!storeIdxSet.has(store.store_idx)) {
               var markerPosition = new kakao.maps.LatLng(store.store_latitude, store.store_longitude);
               
               // 마커 생성
               var marker = new kakao.maps.Marker({
                   position: markerPosition,
                   map: map
               }); */

           
           // 인포윈도우의 내용 생성
         var windowText = '';
         windowText += '<div style="padding:5px; font-size:14px; max-width: 150px; white-space: normal; word-wrap: break-word;">';
         windowText += '<p>' + store.store_name + '</p>';
         windowText += '</div>';

         
         
           // 인포윈도우 생성
           var infoWindow = new kakao.maps.InfoWindow({
               content: windowText,
               removable: true
           });
         
           
           // 마커에 마우스 호버 시 인포윈도우 표시
           kakao.maps.event.addListener(marker, 'mouseover', function() {
               infoWindow.open(map, marker);
           });

           // 마커에서 마우스 아웃 시 인포윈도우 닫기
           kakao.maps.event.addListener(marker, 'mouseout', function() {
               infoWindow.close();
           });

           // 마커 클릭 시 상세 페이지로 이동
           kakao.maps.event.addListener(marker, 'click', function() {
               location.href = 'storeDetail.do?storeidx=' + store.store_idx;
           });

           // 마커와 관련된 정보를 배열에 저장
           markers.push({ marker: marker, infoWindow: infoWindow, storeIdx: store.store_idx });
           
/*            //중복 마커 지우기
           storeIdxSet.add(store.store_idx);
           } */
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

	var alchol = $(':input:radio[name=alchol]:checked').val();
	var food = $(':input:radio[name=food]:checked').val();
	var mood = $(':input:radio[name=mood]:checked').val();
	var visit = $(':input:radio[name=visit]:checked').val();
 	console.log(alchol);
	console.log(food);
	console.log(mood);
	console.log(visit); 
	$('#pagination').twbsPagination('destroy');  //기존에 만들어진 페이징을 파괴
	 $('#list').empty();	
	storeListPage(alchol,food,mood,visit,1);
});


function storeListPage(alchol,food,mood,visit,page){
    $.ajax({
        type:'POST',  //method
        url:'filtering.ajax',  //요청 주소
        data:{
        	
        	'alchol' :alchol,
        		'food' : food,
        		 'mood' :mood,
        		 'visit' :visit,
                 'page': page,
                 'cnt': 5
        		 
        		 
        },   //파라메터

        dataType:'JSON',  //받을 데이터 타입
        success: function(data) {
            console.log(data);
            if (data.storeList && data.storeList.length) {
                drawList(data.storeList, data.photos, data.categoryOpts, data.storeCategorys);
                drawMarkers(data.storeList);
                
                $('#pagination').twbsPagination({
                    startPage: 1,
                    totalPages: data.totalPages, 
                    visiblePages: 5,
                    onPageClick: function(evt, page) {
                        searchPageCall(alchol,food,mood,visit,page);
                    }
                });

            } else {
                showNoStoresMessage();
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}



//$('#pagination').twbsPagination('destroy'); //기존에 만들어진 페이징을 파괴

//검색
$('#performSearch').click(function() {

   var category = document.getElementById("searchCategory").value;
   var keyword = document.getElementById("searchQuery").value;
   console.log(category);
   console.log(keyword);
   $('#pagination').twbsPagination('destroy'); //기존에 만들어진 페이징을 파괴
   
   searchPageCall(category,keyword,1)
   

	var category = document.getElementById("searchCategory").value;
	var keyword = document.getElementById("searchQuery").value;
	console.log(category);
	console.log(keyword);
	$('#pagination').twbsPagination('destroy');  //기존에 만들어진 페이징을 파괴
	$('#list').empty();	



	searchPageCall(category,keyword,show);
	
	console.log('show: ' + show);


	
	
});



function searchPageCall(category, keyword, page) {

	
    $.ajax({
        type: 'GET',
        url: category + 'search.ajax',
        data: {
            'keyword': keyword,
            'page': page,
            'cnt': 5
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if (data.searchresult && data.searchresult.length) {
                drawList(data.searchresult, data.photos, data.categoryOpts, data.storeCategorys);
                drawMarkers(data.searchresult);
                
                $('#pagination').twbsPagination({
                    startPage: 1,
                    totalPages: data.totalPages, 
                    visiblePages: 5,
                    onPageClick: function(evt, page) {
                        searchPageCall(category,keyword,page);
/*                         console.log("evt,page : " + evt,page)
                        console.log("여기가 오륜가? : " + category +" : "+ keyword +" : "+ page) */
                    }
                });

            } else {
                showNoStoresMessage();
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}







</script>
</html>