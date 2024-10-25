<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>위도 경도 검색</title>
    <style>
        #map {
            width: 100%; 
            height: 350px;
        }
        #result {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>주소로 위도와 경도 검색</h1>
    <form id="addressForm" action="kakaoapi" method="post">
        <input type="text" id="address" name="address" placeholder="주소를 입력하세요" required>
        <button type="button" id="searchBtn">검색</button>
    </form>
    <p style="margin-top:-12px">
        <em class="link">
            <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
                혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
            </a>
        </em>
    </p>
    <div id="map"></div>
    <div id="result"></div>

    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=d1b7cd884610b0da5809195298922af8"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption); 

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 버튼 클릭 시 검색
        document.getElementById('searchBtn').onclick = function() {
            var address = document.getElementById('address').value;

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch(address, function(result, status) {
                // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    
                    // 지도에 마커를 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">위치</div>'
                    });
                    infowindow.open(map, marker);

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);

                    // 위도와 경도를 결과 div에 표시합니다
                    document.getElementById('result').innerHTML = 
                        "위도: " + result[0].y + ", 경도: " + result[0].x;
                } else {
                    alert("주소를 찾을 수 없습니다. 다시 입력해 주세요.");
                }
            });
        };
    </script>
</body>
</html>