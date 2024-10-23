<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SULBAZI</title>
    <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Irish+Grover&display=swap');
    *{
        margin: 0;
        padding: 0;
    }
    ol, ul, li{
        list-style: none;
    }
    a{
        text-decoration: none;
        color: white;
    }
    body{
        background-color: #041d03;
    }
    .navbar{
        z-index: 99;
        position: absolute;
        left: 360px;
        justify-items: center;
        width: 1200px;
        height: 120px;
        background-color: #041d03;
        color: rgb(255, 140, 9);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .icon{
        display: flex;
    }
    .logo_text a{
        font-family: "Irish Grover", system-ui;
        font-weight: 400;
        font-style: normal;
        margin-left: 160px;
        color: rgb(255, 140, 9);
        font-size: 70px;
        font-weight: bolder;
    }
    .icon li{
        padding: 10px;
    }
    .fullbox{
        display: flex;
    }
    .full{
        z-index: 999;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list1 li, .list2 li{
        padding: 20px;
    }
    .full2{
        z-index: 999;
        position: absolute;
        left: 1620px;
        display: flex;
        width: 300px;
        height: 100vh;
        flex-direction: column;
        justify-content: flex-end;
        align-items: center;
        background-color: rgb(255, 140, 9);
        display: none;
    }
    .list2{
        position: absolute;
        top: 200px;
    }
    .logout{
        position: absolute;
        left: 25px;
        bottom: 25px;
    }
    i{
        font-size: 25px;
    }

    .sub_, .sub_1{
        position: absolute;
        width: 200px;
        height: 310px;
        background-color: rgb(255, 140, 9);
        border-radius: 10px;
        display: none;
    }
    .sub_txt, .sub_txt1{
        font-size: 20px;
        color: white;
        display: flex;
        justify-content: center;
        margin-top: 5px;
    }
    .sub, .sub1{
        margin: 10px;
        width: 180px;
        height: 80px;
        background-color: aliceblue;
        display: flex;
        justify-content: space-around;
        border-radius: 10px;
    }
</style>
<body>
    <header>
        <nav class="navbar">
            <div class="main_menu"><i class="fa-solid fa-bars"></i></div>
            <div class="logo_text">
                <a href="./#">SULBAZI</a>
            </div>
            <div>
                <ul class="icon">
                    <li><a href="login.go">로그인</a></li>
                    <li>
                        <i class="fa-regular fa-message"></i>
                        <div class="sub_1">
                            <div class="sub_txt1">대화중인 대화방</div>
                            <div class="sub1">알림1</div>
                            <div class="sub1">알림2</div>
                        </div>
                    </li>
                    <li>
                        <i class="fa-regular fa-bell"></i>
                        <div class="sub_">
                            <div class="sub_txt">3개 알림</div>
                            <div class="sub">알림1</div>
                            <div class="sub">알림2</div>
                            <div class="sub">알림3</div>
                        </div>
                    </li>
                    <li class="mypage"><i class="fa-regular fa-user"></i></li>
                </ul>
            </div>
        </nav>
        <div class="fullbox">
            <div class="full">
                <ul class="list1">
                    <li><a href="localChatRoom.go">지역 대화방</a></li>
                    <li><a href="./userchatlist.go">개인 대화방</a></li>
                    <li><a href="storeList.go">매장 리스트</a></li>
                    <li><a href="boardList.go">게시판</a></li>
                </ul>
            </div>
            <div class="full2">
                <ul class="list2">
                    <li><a href="storeMyPage.go">나의 정보</a></li>
                    <li><a href="storeReview.go">나의 매장 리뷰</a></li>
                    <li><a href="storeBoard.go">나의 게시글</a></li>
                    <li><a href="storeMenu.go">매장 메뉴 등록</a></li>
                </ul>
                <div class="logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <a href="logout.go">로그아웃</a>
                </div>
            </div>
        </div>  
    </header>
</body>
<script>
    $('.main_menu').click(function(){      
        var displayfull = $('.full').css('display');
        if (displayfull == 'none'){
            $('.full2, .sub_, .sub_1').hide();
            $('.full').css('display','flex');
        }else{
            $('.full').hide();
        }
    });
    $('.mypage').click(function(){      
        var displayfull2 = $('.full2').css('display');
        if (displayfull2 == 'none'){
            $('.full, .sub_, .sub_1').hide();
            $('.full2').css('display','flex');
        }else{
            $('.full2').hide();
        }
    });
    $('.fa-message').click(function(){      
        var displaysub_1 = $('.sub_1').css('display');
        if (displaysub_1 == 'none'){
            $('.full, .full2, .sub_').hide();
            $('.sub_1').show();
        }else{
            $('.sub_1').hide();
        }
    });
    $('.fa-bell').click(function(){      
        var displaysub1 = $('.sub_').css('display');
        if (displaysub1 == 'none'){
            $('.full, .full2, .sub_1').hide();
            $('.sub_').show();
        }else{
            $('.sub_').hide();
        }
    });
</script>

</html>