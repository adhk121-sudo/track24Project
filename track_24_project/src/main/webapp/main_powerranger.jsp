<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<html>
<head>
<link href="css/main.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <!-- 배경 효과 -->
  <div class="bg-effects">
    <div class="energy-line" style="top: 20%; animation-delay: 0s;"></div>
    <div class="energy-line" style="top: 50%; animation-delay: 1s;"></div>
    <div class="energy-line" style="top: 80%; animation-delay: 2s;"></div>
  </div>

  <nav class="navbar">
    <div class="nav-inner">
      <div class="logo">⚡ 결정러</div>
      <div class="nav-actions">
        <button class="nav-login" onclick="location.href='login.html'">로그인</button>
        <button class="nav-signup" onclick="location.href='signup_step1.html'">회원가입</button>
      </div>
    </div>
  </nav>

  <main>
    <!-- 히어로 섹션 -->
    <section class="hero-section pose-animation">
      <div class="hero-badge">🦸 선택장애 해결 전대</div>
      <h1 class="hero-title">
        오늘도 <span class="highlight">선택장애</span>를 가진<br/>
        현대인들아, 우리가 알려주마!
      </h1>
      <p class="hero-subtitle">
        음식, 영화, 책, 음악... 뭘 골라야 할지 모르겠다고?<br/>
        걱정 마! 우리 4인방이 딱 정해줄게! 💪
      </p>
    </section>

    <!-- 캐릭터들 -->
    <section class="characters-section">
      <div class="character-card" onclick="location.href='recommend_question.html?category=food'">
        <div class="character-avatar">🍜</div>
        <div class="character-name">맛레인저</div>
        <div class="character-role">음식 담당</div>
      </div>
      <div class="character-card" onclick="location.href='recommend_question.html?category=movie'">
        <div class="character-avatar">🎬</div>
        <div class="character-name">무비레인저</div>
        <div class="character-role">영화 담당</div>
      </div>
      <div class="character-card" onclick="location.href='recommend_question.html?category=book'">
        <div class="character-avatar">📚</div>
        <div class="character-name">북레인저</div>
        <div class="character-role">책 담당</div>
      </div>
      <div class="character-card" onclick="location.href='recommend_question.html?category=music'">
        <div class="character-avatar">🎵</div>
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
      <button class="mission-btn" onclick="location.href='login.html'">출동!</button>
    </div>
  </main>
</body>
</html>