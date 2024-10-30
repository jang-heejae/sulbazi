<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <title>주소 검색</title>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=4ae2258b561b1a937e5d3f2c155e60f9&libraries=services"></script>
    <script>
        function getCoordinates() {
            const address = document.getElementById('addressInput').value.trim(); 
            const geocoder = new kakao.maps.services.Geocoder();

            const callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    console.log("Result:", result);  // 전체 결과를 출력하여 구조 확인
                    const latitude = result[0].y; // y 값을 latitude 변수에
                    const longitude = result[0].x; 
                    sendCoordinatesToServer(latitude, longitude);
                    console.log('Latitude: ${latitude}, Longitude: ${longitude}');
                } else {
                    console.error("주소를 찾을 수 없습니다.");
                }
            };

            geocoder.addressSearch(address, callback);
        }
        function sendCoordinatesToServer(latitude, longitude) {
            $.ajax({
                url: 'test.ajax',
                type: 'POST', // 요청 방법
                data: {
                    lat: latitude,
                    lon: longitude
                },
                success: function(response) {
                    console.log("서버 응답:", response); // 서버의 응답 처리
                },
                error: function(xhr, status, error) {
                    console.error("서버 요청 실패:", error); // 오류 처리
                }
            });
        }
    </script>
</head>
<body>
    <h1>주소 검색</h1>
    <input type="text" id="addressInput" placeholder="주소를 입력하세요" />
    <button onclick="getCoordinates()">위도/경도 검색</button>
</body>
</html>