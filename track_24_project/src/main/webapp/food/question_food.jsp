<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link href="../css/food.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>    

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>맛레인저 추천 | 결정러</title>
</head>

<body>
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

    <!-- 질문 카드 -->
    <div class="question-card">
      <!-- 질문 1: 기분 -->
      <div class="question-panel active" data-step="1">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">🍜</div>
          </div>
          <div class="question-area">
            <div class="question-label">Q1. 기분</div>
            <div class="question-text">오늘 기분이 어때? 😊</div>
            <div class="question-sub">기분에 따라 어울리는 음식이 달라!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="happy">
              <span class="emoji">😄</span>
              <span class="text">기분 좋아!</span>
              <span class="desc">신나는 날이야</span>
            </div>
            <div class="option-btn" data-value="tired">
              <span class="emoji">😫</span>
              <span class="text">피곤해...</span>
              <span class="desc">에너지 충전 필요</span>
            </div>
            <div class="option-btn" data-value="stressed">
              <span class="emoji">😤</span>
              <span class="text">스트레스 받아</span>
              <span class="desc">확 풀고 싶어</span>
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
          <span class="text">맛레인저가 기분에 딱 맞는 음식을 추천해줄게!</span>
        </div>
      </div>

      <!-- 질문 2: 식사 종류 -->
      <div class="question-panel" data-step="2">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">🍜</div>
          </div>
          <div class="question-area">
            <div class="question-label">Q2. 식사</div>
            <div class="question-text">어떤 끼니를 찾고 있어? 🍽️</div>
            <div class="question-sub">상황에 맞는 메뉴를 골라줄게!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="breakfast">
              <span class="emoji">🌅</span>
              <span class="text">아침</span>
              <span class="desc">가볍게 시작</span>
            </div>
            <div class="option-btn" data-value="lunch">
              <span class="emoji">☀️</span>
              <span class="text">점심</span>
              <span class="desc">든든하게</span>
            </div>
            <div class="option-btn" data-value="dinner">
              <span class="emoji">🌙</span>
              <span class="text">저녁</span>
              <span class="desc">하루 마무리</span>
            </div>
            <div class="option-btn" data-value="snack">
              <span class="emoji">🍿</span>
              <span class="text">간식/야식</span>
              <span class="desc">출출할 때</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">💡</span>
          <span class="text">시간대에 따라 추천 메뉴가 달라져!</span>
        </div>
      </div>

      <!-- 질문 3: 음식 스타일 -->
      <div class="question-panel" data-step="3">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">🍜</div>
          </div>
          <div class="question-area">
            <div class="question-label">Q3. 스타일</div>
            <div class="question-text">어떤 느낌의 음식이 땡겨? 🤤</div>
            <div class="question-sub">오늘 입맛에 맞는 스타일을 골라봐!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="hot">
              <span class="emoji">🔥</span>
              <span class="text">뜨끈뜨끈</span>
              <span class="desc">국물/찌개/탕</span>
            </div>
            <div class="option-btn" data-value="spicy">
              <span class="emoji">🌶️</span>
              <span class="text">매콤하게</span>
              <span class="desc">화끈하게!</span>
            </div>
            <div class="option-btn" data-value="light">
              <span class="emoji">🥗</span>
              <span class="text">가볍게</span>
              <span class="desc">건강하게</span>
            </div>
            <div class="option-btn" data-value="heavy">
              <span class="emoji">🍖</span>
              <span class="text">든든하게</span>
              <span class="desc">푸짐하게!</span>
            </div>
          </div>
        </div>

        <div class="tip-bubble">
          <span class="icon">💡</span>
          <span class="text">취향 저격 메뉴를 찾고 있어!</span>
        </div>
      </div>

      <!-- 질문 4: 함께 먹을 사람 -->
      <div class="question-panel" data-step="4">
        <div class="question-header">
          <div class="character-area">
            <div class="character-icon">🍜</div>
          </div>
          <div class="question-area">
            <div class="question-label">Q4. 상황</div>
            <div class="question-text">누구랑 먹을 거야? 👥</div>
            <div class="question-sub">상황에 맞는 메뉴를 추천해줄게!</div>
          </div>
        </div>

        <div class="options-area">
          <div class="options-grid">
            <div class="option-btn" data-value="alone">
              <span class="emoji">🧑</span>
              <span class="text">혼밥</span>
              <span class="desc">나만의 시간</span>
            </div>
            <div class="option-btn" data-value="friend">
              <span class="emoji">👫</span>
              <span class="text">친구랑</span>
              <span class="desc">즐거운 식사</span>
            </div>
            <div class="option-btn" data-value="family">
              <span class="emoji">👨‍👩‍👧</span>
              <span class="text">가족이랑</span>
              <span class="desc">온 가족 함께</span>
            </div>
            <div class="option-btn" data-value="date">
              <span class="emoji">💑</span>
              <span class="text">데이트</span>
              <span class="desc">분위기 있게</span>
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
        <button class="btn btn-prev" id="prevBtn" style="visibility: hidden;">
          ← 이전
        </button>
        <button class="btn btn-next" id="nextBtn" disabled>
          다음 →
        </button>
      </div>
    </div>
  </div>

  <script>
let currentStep = 1;
const MAX_STEP = 4;
const answers = {};

function updateUI() {
  // 진행 바 업데이트
  document.querySelectorAll('.progress-dot').forEach(dot => {
    const step = Number(dot.dataset.step);
    dot.classList.remove('active', 'done');
    if (step === currentStep) dot.classList.add('active');
    if (step < currentStep) dot.classList.add('done');
  });

  // 패널 전환
  document.querySelectorAll('.question-panel').forEach(panel => {
    panel.style.display = Number(panel.dataset.step) === currentStep ? 'block' : 'none';
  });

  // 버튼 상태
  document.getElementById('prevBtn').style.visibility = currentStep === 1 ? 'hidden' : 'visible';
  
  const nextBtn = document.getElementById('nextBtn');
  if (currentStep === MAX_STEP) {
    nextBtn.textContent = '🔥 추천받기!';
  } else {
    nextBtn.textContent = '다음 →';
  }

  // 현재 스텝에 선택된 값이 있으면 버튼 활성화
  const currentPanel = document.querySelector(`.question-panel[data-step="${currentStep}"]`);
  const hasSelection = currentPanel.querySelector('.option-btn.selected');
  nextBtn.disabled = !hasSelection;
}

function selectOption(btn, step) {
  // 같은 패널의 다른 선택 해제
  btn.closest('.options-grid').querySelectorAll('.option-btn').forEach(b => {
    b.classList.remove('selected');
  });
  btn.classList.add('selected');
  
  // 답변 저장
  answers[step] = btn.dataset.value;
  
  // 다음 버튼 활성화
  document.getElementById('nextBtn').disabled = false;
}

document.addEventListener('DOMContentLoaded', () => {
  updateUI();

  // 옵션 클릭
  document.querySelectorAll('.option-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const panel = btn.closest('.question-panel');
      const step = Number(panel.dataset.step);
      selectOption(btn, step);
    });
  });

  // 이전 버튼
  document.getElementById('prevBtn').addEventListener('click', () => {
    if (currentStep > 1) {
      currentStep--;
      updateUI();
    }
  });

  // 다음 버튼
  document.getElementById('nextBtn').addEventListener('click', () => {
    if (currentStep < MAX_STEP) {
      currentStep++;
      updateUI();
    } else {
      // 마지막 단계 - 결과 페이지로 이동
      console.log('선택한 답변:', answers);
      alert('추천 결과 페이지로 이동합니다!\n\n선택: ' + JSON.stringify(answers, null, 2));
      // location.href = 'result_food.html?' + new URLSearchParams(answers);
    }
  });
});
  </script>
</body>
<!-- footer.jsp -->
<footer class="footer">
  <%@ include file="../common/common_footer.jsp" %>
</footer>
</html>