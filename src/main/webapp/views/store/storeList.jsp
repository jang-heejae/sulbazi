<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>SULBAZI</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="resources/jquery.twbsPagination.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
<style>
    body {
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
        left: 352px;
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

    input {
        font-size: 14px;
        margin-top: -1px;
        vertical-align: middle;
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
        left: 54%;
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

    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
    }

    .store-img {
        width: 100px;
    }

    .categories {
        width: 100%;
        height: 100%;
    }

    .categories p {
        display: inline-block;
        margin: 0;
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
    .filtering-thing{
    	color: blue;
    }
    .hide{
    	display: none;
    }
</style>
</head>

<body>
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
           <p class="hide filtering-thing">필터링은 필수 체크 입니다 확인해 주세요.</p>
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

var map = new kakao.maps.Map(container, options);
var markers = []; // 마커를 저장할 배열

// 기본 중심 위치를 저장
var defaultCenter = map.getCenter();

/* 리스트 페이징  */




function pageCall(page) {
    var center = map.getCenter(); // 지도 중심 좌표 가져오기
    var centerLat = center.getLat();
    var centerLng = center.getLng();
    var latDiff = 0.0045;
    var lngDiff = 0.0045;

    $.ajax({
        type: 'GET',
        url: 'list.ajax',
        data: {
            'page': page,
            'cnt': 5,
            'minLat': centerLat - latDiff,
            'maxLat': centerLat + latDiff,
            'minLng': centerLng - lngDiff,
            'maxLng': centerLng + lngDiff
        },
        dataType: 'JSON',
        success: function(data) {
            if (data.list && data.list.length) {
                drawList(data.list, data.photos, data.categoryOpts, data.storeCategorys);
                drawMarkers(data.list);
                $('#pagination').twbsPagination({
                    startPage: 1,
                    totalPages: data.totalPages,
                    visiblePages: 5,
                    onPageClick: function(evt, page) {
                        pageCall(page);
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

// 매장 리스트를 표시하는 함수
function drawList(storeList, photos, categoryOpts, storeCategorys) {
    var listContainer = document.getElementById('list');
    listContainer.innerHTML = '';

    storeList.forEach(function(store) {
        var photo = Array.isArray(photos) ? photos.find(function(p) {
            return p.photo_folder_idx === store.store_idx;
        }) : null;

        var relatedCategoryOpts = categoryOpts.filter(function(categoryOpt) {
            return storeCategorys.some(function(storeCategory) {
                return storeCategory.store_idx === store.store_idx && storeCategory.opt_idx === categoryOpt.opt_idx;
            });
        });

        var content = '<tr>';
        content += '<td class="store-img">';
        content += '<img src="photo/' + (photo ? photo.new_filename : '') + '" alt="' + store.store_name + '" width="95px" height="95px">';
        content += '</td>';
        content += '<td class="hover-td" data-lat="' + store.store_latitude + '" data-lng="' + store.store_longitude + '">';
        content += '<h3 class="store-name" data-store-idx="' + store.store_idx + '" onclick="location.href=\'storeDetail.do?storeidx=' + store.store_idx + '\'">' + store.store_name + '</h3>';
        content += '<div class="store-rating">';
        content += '<span>⭐' + store.star_average + ' (' + store.review_total + ')명</span>';
        content += '</div>';
        content += '<div class="categories">';
        relatedCategoryOpts.slice(0, 4).forEach(function(opt) {
            content += '<p>&nbsp;#' + opt.opt_name + '</p>';
        });
        content += '</div>';
        content += '<p>' + store.store_address + '</p>';
        content += '</td>';
        content += '</tr>';

        listContainer.innerHTML += content;
    });

    document.querySelectorAll('.hover-td').forEach(function(td) {
        td.addEventListener('mouseenter', function() {
            var lat = parseFloat(td.getAttribute('data-lat'));
            var lng = parseFloat(td.getAttribute('data-lng'));
            map.setCenter(new kakao.maps.LatLng(lat, lng));
        });
    });

    document.querySelectorAll('.store-name').forEach(function(element) {
        var storeIdx = element.getAttribute('data-store-idx');
        var markerObj = markers.find(function(marker) {
            return marker.storeIdx === storeIdx;
        });

        if (markerObj) {
            element.addEventListener('mouseover', function() {
                markerObj.infoWindow.open(map, markerObj.marker);
            });

            element.addEventListener('mouseout', function() {
                markerObj.infoWindow.close();
            });
        }
    });
}

function showNoStoresMessage() {
    var listContainer = document.getElementById('list');
    listContainer.innerHTML = '<tr><td colspan="2" style="text-align: center; padding: 20px;">매장 리스트가 없습니다.</td></tr>';
}

function drawMarkers(storeList) {
    markers.forEach(function(markerObj) {
        markerObj.marker.setMap(null);
    });
    markers = [];

    storeList.forEach(function(store) {
        var markerPosition = new kakao.maps.LatLng(store.store_latitude, store.store_longitude);
        var marker = new kakao.maps.Marker({
            position: markerPosition,
            map: map
        });

        var windowText = '<div style="padding:5px; font-size:14px; max-width: 150px; white-space: normal; word-wrap: break-word;"><p>' + store.store_name + '</p></div>';
        var infoWindow = new kakao.maps.InfoWindow({
            content: windowText,
            removable: true
        });

        kakao.maps.event.addListener(marker, 'mouseover', function() {
            infoWindow.open(map, marker);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function() {
            infoWindow.close();
        });

        kakao.maps.event.addListener(marker, 'click', function() {
            location.href = 'storeDetail.do?storeidx=' + store.store_idx;
        });

        markers.push({ marker: marker, infoWindow: infoWindow, storeIdx: store.store_idx });
    });
}

$('#filtering').click(function() {
    var alchol = $(':input:radio[name=alchol]:checked').val();
    var food = $(':input:radio[name=food]:checked').val();
    var mood = $(':input:radio[name=mood]:checked').val();
    var visit = $(':input:radio[name=visit]:checked').val();
    
 	console.log("알콜: "+alchol);
 	console.log("알콜: "+food);
 	console.log("알콜: "+mood);
 	console.log("알콜: "+visit);
 	
 	// 체크했는지 확인하는 작업
 	  if (!alchol || !food || !mood || !visit) {
 		  $('.filtering-thing').removeClass('hide');
          alert('필터링확인 다시 부탁드립니다');
      }else{
    	  $('.filtering-thing').addClass('hide');
	    //페이징 존재여부
	    if ($.fn.twbsPagination) {
	        $('#pagination').twbsPagination('destroy');
	    }
	    $('#list').empty();
	    storeListPage(alchol, food, mood, visit, 1);
    	  
      }

    
});

function storeListPage(alchol, food, mood, visit, page) {
    $.ajax({
        type: 'POST',
        url: 'filtering.ajax',
        data: {
            'alchol': alchol,
            'food': food,
            'mood': mood,
            'visit': visit,
            'page': page,
            'cnt': 5
        },
        dataType: 'JSON',
        success: function(data) {
            if (data.storeList && data.storeList.length) {
                drawList(data.storeList, data.photos, data.categoryOpts, data.storeCategorys);
                drawMarkers(data.storeList);
                $('#pagination').twbsPagination({
                    startPage: 1,
                    totalPages: data.totalPages,
                    visiblePages: 5,
                    onPageClick: function(evt, page) {
                        storeListPage(alchol, food, mood, visit, page);
                    }
                });
            } else {
                showNoStoresMessage();
            }
        },
        error: function(e) {
            console.log(e);
            showNoStoresMessage();
        }
    });
}
//검색창 버튼 이벤트

$('#performSearch').click(function() {
    var category = document.getElementById("searchCategory").value;
    var keyword = document.getElementById("searchQuery").value;
    $('#pagination').twbsPagination('destroy');
    $('#list').empty();
    searchPageCall(category, keyword, 1);
});
//엔터키 이벤트
$('#searchQuery').keydown(function(event) {
    if (event.key === "Enter") {
        event.preventDefault(); // 기본 엔터키 제출 동작 막기
        var category = document.getElementById("searchCategory").value;
        var keyword = document.getElementById("searchQuery").value;
        $('#pagination').twbsPagination('destroy');
        $('#list').empty();
        searchPageCall(category, keyword, 1);
    }
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
            if (data.searchresult && data.searchresult.length) {
                drawList(data.searchresult, data.photos, data.categoryOpts, data.storeCategorys);
                drawMarkers(data.searchresult);
                $('#pagination').twbsPagination({
                    startPage: 1,
                    totalPages: data.totalPages,
                    visiblePages: 5,
                    onPageClick: function(evt, page) {
                        searchPageCall(category, keyword, page);
                    }
                });
            } else {
                showNoStoresMessage();
            }
        },
        error: function(e) {
            console.log(e);
            showNoStoresMessage();
        }
    });
}

window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);

    const category = urlParams.get('category');
    const keyword = urlParams.get('keyword');    
    
    if (!category && !keyword) {
    	var show = 1;
    	pageCall(show);
    }
    

    if (category) {
        document.getElementById('searchCategory').value = category;
    }

    if (keyword) {
        document.getElementById('searchQuery').value = keyword;
        
        searchPageCall(category, keyword, 1);
        
        

/*         // 특정 버튼을 1초 뒤에 자동으로 클릭하도록 설정
        setTimeout(function() {
            document.getElementById('performSearch').click();
        }, 1000); // 1000ms = 1초 */
        
    
    }
};




</script>
</html>
