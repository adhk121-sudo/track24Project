<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link href="css/main.css" rel="stylesheet">
<link rel="stylesheet" href="css/header.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>    

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>결정러 - 선택장애 해결사</title>
</head>

<body>
  <!-- 배경 효과 -->
  <div class="bg-effects">
    <div class="energy-line" style="top: 20%; animation-delay: 0s;"></div>
    <div class="energy-line" style="top: 50%; animation-delay: 1s;"></div>
    <div class="energy-line" style="top: 80%; animation-delay: 2s;"></div>
  </div>

  <!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp" %> 
  </header>

  <main>
    <!-- 히어로 섹션 -->
    <section class="hero-section pose-animation">
      <div class="hero-badge">🦸 선택장애 해결 전대</div>
      <h1 class="hero-title">
        오늘도 <span class="highlight">선택장애</span>를 가진<br/>
        현대인들아, 우리가 알려주마!
      </h1>
      <p class="hero-subtitle">
        음식, 음료, 영화, 책, 음악... 뭘 골라야 할지 모르겠다고?<br/>
        걱정 마! 우리 5인방이 딱 정해줄게! 💪
      </p>
    </section>

    <!-- 캐릭터들 -->
    <!-- 캐릭터들 - 5인방 -->
    <section class="characters-section">
      <!-- 맛레인저 (빨강) -->
      <div class="character-card" data-color="red" onclick="goPage('food')">
        <div class="character-avatar">
          <img src="images/food_ranger.png" alt="맛레인저">
        </div>
        <div class="character-name">맛레인저</div>
        <div class="character-role">음식 담당</div>
      </div>

      <!-- 드링크레인저 (노랑) -->
      <div class="character-card" data-color="yellow" onclick="goPage('drink')">
        <div class="character-avatar">
          <img src="images/drink_ranger.png" alt="드링크레인저">
        </div>
        <div class="character-name">드링크레인저</div>
        <div class="character-role">음료 담당</div>
      </div>

      <!-- 무비레인저 (보라) -->
      <div class="character-card" data-color="purple" onclick="goPage('movie')">
        <div class="character-avatar">
          <img src="images/movie_ranger.png" alt="무비레인저">
        </div>
        <div class="character-name">무비레인저</div>
        <div class="character-role">영화 담당</div>
      </div>

      <!-- 북레인저 (초록) -->
      <div class="character-card" data-color="green" onclick="goPage('book')">
        <div class="character-avatar">
          <img src="images/book_ranger.png" alt="북레인저">
        </div>
        <div class="character-name">북레인저</div>
        <div class="character-role">책 담당</div>
      </div>

      <!-- 뮤직레인저 (파랑) -->
      <div class="character-card" data-color="blue" onclick="goPage('music')">
        <div class="character-avatar">
          <img src="images/music_ranger.png" alt="뮤직레인저">
        </div>
        <div class="character-name">뮤직레인저</div>
        <div class="character-role">음악 담당</div>
      </div>
    </section>

    <!-- 말풍선 -->
    <div class="speech-bubble">
      <p>
        <span class="emoji">🔥</span> 
        "캐릭터를 클릭해서 추천받아!"
        <span class="emoji">🔥</span>
      </p>
    </div>

    <!-- 로그인 배너 - 가운데 정렬 -->
    <div class="mission-banner">
      <div class="mission-text">
        <span class="icon">🎯</span>
        <p>로그인하면 <span>취향 맞춤 추천</span>!</p>
      </div>
      <button class="mission-btn" onclick="goPage('login')">출동!</button>
    </div>
  </main>
</body>
<!-- footer.jsp -->
<footer class="footer">
  <%@ include file="../common/common_footer.jsp" %>
</footer>
</html>