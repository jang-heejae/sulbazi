<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주소 검색</title>
</head>
<body>
    <h1>주소로 검색</h1>
    <form id="addressForm" action="kakaoapi" method="post">
        <input type="text" id="address" name="address" placeholder="주소를 입력하세요" required>
        <input type="hidden" id="latitude" name="latitude">
        <input type="hidden" id="longitude" name="longitude">
        <button type="button" id="searchBtn">검색</button>
    </form>

    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=d1b7cd884610b0da5809195298922af8"></script>
    <script>
        var geocoder = new kakao.maps.services.Geocoder();

        document.getElementById('searchBtn').onclick = function() {
            var address = document.getElementById('address').value;

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var latitude = result[0].y;
                    var longitude = result[0].x;

                    console.log("위도: " + latitude + ", 경도: " + longitude);
                    // 위도와 경도를 hidden 필드에 설정
                    document.getElementById('latitude').value = latitude;
                    document.getElementById('longitude').value = longitude;

                    // 폼 제출
                    document.getElementById('addressForm').submit();
                } else {
                    alert("주소를 찾을 수 없습니다. 다시 입력해 주세요.");
                }
            });
        };
    </script>
</body>
</html>