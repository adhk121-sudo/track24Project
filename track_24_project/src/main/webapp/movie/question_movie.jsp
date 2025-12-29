<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>무비레인저 추천 | 결정러</title>
  <link href="../css/question.css" rel="stylesheet">
</head>
<body class="theme-movie">

  <!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp" %> 
  </header>

  <div class="main-wrap">
    <!-- 진행 바 -->
    <div class="progress-bar">
      <div class="progress-dot active" data-step="1"></div>
      <div class="progress-dot" data-step="2"></div>
      <div class="progress-dot" data-step="3"></div>
      <div class="progress-dot" data-step="4"></div>
    </div>
    
    <!-- 질문 카드 (폼으로 감싸기) -->
	<form name="movieForm" id="questionForm">
    <!-- 질문 카드 -->
    <div class="question-card">
      <!-- 질문 1: 기분 -->
      <div class="question-panel active" data-step="1">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">
              <img src="../images/movie_ranger.png" alt="무비레인저">
            </div>
          </div>
          <div class="question-area">
            <div class="question-label">Q1. 기분</div>
            <div class="question-text">오늘 기분이 어때? 😊</div>
            <div class="question-sub">기분에 따라 어울리는 영화가 달라!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="happy">
              <span class="emoji">😄</span>
              <span class="text">기분 좋아!</span>
              <span class="desc">신나는 영화 보고 싶어</span>
            </div>
            <div class="option-btn" data-value="bored">
              <span class="emoji">😑</span>
              <span class="text">심심해...</span>
              <span class="desc">뭔가 자극적인 거</span>
            </div>
            <div class="option-btn" data-value="romantic">
              <span class="emoji">🥰</span>
              <span class="text">설레고 싶어</span>
              <span class="desc">로맨틱한 거!</span>
            </div>
            <div class="option-btn" data-value="sad">
              <span class="emoji">😢</span>
              <span class="text">우울해...</span>
              <span class="desc">위로가 필요해</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">💡</span>
          <span class="text">무비레인저가 기분에 딱 맞는 영화를 추천해줄게!</span>
        </div>
      </div>

      <!-- 질문 2: 장르 -->
      <div class="question-panel" data-step="2">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">
              <img src="../images/icons/movie_ranger.png" alt="무비레인저">
            </div>
          </div>
          <div class="question-area">
            <div class="question-label">Q2. 장르</div>
            <div class="question-text">어떤 장르가 땡겨? 🎬</div>
            <div class="question-sub">오늘 보고 싶은 장르를 골라봐!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="action">
              <span class="emoji">💥</span>
              <span class="text">액션</span>
              <span class="desc">화끈하게!</span>
            </div>
            <div class="option-btn" data-value="comedy">
              <span class="emoji">😂</span>
              <span class="text">코미디</span>
              <span class="desc">웃고 싶어</span>
            </div>
            <div class="option-btn" data-value="romance">
              <span class="emoji">💕</span>
              <span class="text">로맨스</span>
              <span class="desc">설렘 충전</span>
            </div>
            <div class="option-btn" data-value="thriller">
              <span class="emoji">😱</span>
              <span class="text">스릴러/공포</span>
              <span class="desc">긴장감 있게</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">💡</span>
          <span class="text">취향에 맞는 영화를 찾고 있어!</span>
        </div>
      </div>

      <!-- 질문 3: 분위기 -->
      <div class="question-panel" data-step="3">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">
              <img src="../images/movie_ranger.png" alt="무비레인저">
            </div>
          </div>
          <div class="question-area">
            <div class="question-label">Q3. 분위기</div>
            <div class="question-text">어떤 분위기가 좋아? 🌙</div>
            <div class="question-sub">원하는 분위기를 선택해!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="light">
              <span class="emoji">🌈</span>
              <span class="text">가볍게</span>
              <span class="desc">머리 비우고</span>
            </div>
            <div class="option-btn" data-value="deep">
              <span class="emoji">🧠</span>
              <span class="text">깊이 있게</span>
              <span class="desc">생각할 거리</span>
            </div>
            <div class="option-btn" data-value="touching">
              <span class="emoji">🥹</span>
              <span class="text">감동적으로</span>
              <span class="desc">눈물 준비</span>
            </div>
            <div class="option-btn" data-value="exciting">
              <span class="emoji">🎢</span>
              <span class="text">스릴 넘치게</span>
              <span class="desc">손에 땀을!</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">💡</span>
          <span class="text">분위기에 맞는 영화를 찾아볼게!</span>
        </div>
      </div>

      <!-- 질문 4: 함께 볼 사람 -->
      <div class="question-panel" data-step="4">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">
              <img src="../images/movie_ranger.png" alt="무비레인저">
            </div>
          </div>
          <div class="question-area">
            <div class="question-label">Q4. 상황</div>
            <div class="question-text">누구랑 볼 거야? 👥</div>
            <div class="question-sub">상황에 맞는 영화를 추천해줄게!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="alone">
              <span class="emoji">🧑</span>
              <span class="text">혼자</span>
              <span class="desc">나만의 시간</span>
            </div>
            <div class="option-btn" data-value="friend">
              <span class="emoji">👫</span>
              <span class="text">친구랑</span>
              <span class="desc">같이 웃고 울고</span>
            </div>
            <div class="option-btn" data-value="family">
              <span class="emoji">👨‍👩‍👧</span>
              <span class="text">가족이랑</span>
              <span class="desc">온 가족 함께</span>
            </div>
            <div class="option-btn" data-value="date">
              <span class="emoji">💑</span>
              <span class="text">연인이랑</span>
              <span class="desc">로맨틱하게</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">🔥</span>
          <span class="text">마지막 질문이야! 이제 추천해줄게!</span>
        </div>
      </div>

      <!-- 버튼 영역 -->
      <div class="action-area">
        <button class="btn btn-prev" id="prevBtn" style="visibility: hidden;">← 이전</button>
        <button class="btn btn-next" id="nextBtn" disabled>다음 →</button>
      </div>
    </div>
    </form>
  </div>

  <!-- 푸터 -->
  <footer class="footer">
  <%@ include file="../common/common_footer.jsp" %>
  </footer>

  <script>
    let currentStep = 1;
    const MAX_STEP = 4;
    const answers = {};

    function updateUI() {
      document.querySelectorAll('.progress-dot').forEach(dot => {
        const step = Number(dot.dataset.step);
        dot.classList.remove('active', 'done');
        if (step === currentStep) dot.classList.add('active');
        if (step < currentStep) dot.classList.add('done');
      });

      document.querySelectorAll('.question-panel').forEach(panel => {
        panel.classList.toggle('active', Number(panel.dataset.step) === currentStep);
      });

      document.getElementById('prevBtn').style.visibility = currentStep === 1 ? 'hidden' : 'visible';
      
      const nextBtn = document.getElementById('nextBtn');
      nextBtn.textContent = currentStep === MAX_STEP ? '🎬 추천받기!' : '다음 →';

      const currentPanel = document.querySelector('.question-panel[data-step="' + currentStep + '"]');
      const hasSelection = currentPanel.querySelector('.option-btn.selected');
      nextBtn.disabled = !hasSelection;
    }

    function selectOption(btn, step) {
      btn.closest('.options-grid').querySelectorAll('.option-btn').forEach(b => b.classList.remove('selected'));
      btn.classList.add('selected');
      answers[step] = btn.dataset.value;
      document.getElementById('nextBtn').disabled = false;
    }

    document.addEventListener('DOMContentLoaded', () => {
      updateUI();

      document.querySelectorAll('.option-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const panel = btn.closest('.question-panel');
          const step = Number(panel.dataset.step);
          selectOption(btn, step);
        });
      });

      document.getElementById('prevBtn').addEventListener('click', () => {
        if (currentStep > 1) { currentStep--; updateUI(); }
      });

      document.getElementById('nextBtn').addEventListener('click', () => {
        if (currentStep < MAX_STEP) {
          currentStep++;
          updateUI();
        } else {
          location.href = 'result_movie.jsp?' + new URLSearchParams(answers);
        }
      });
    });
  </script>
</body>
</html>
